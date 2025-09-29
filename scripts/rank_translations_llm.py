#!/usr/bin/env python3
"""
Compute LLM-based ranking indices per jargon using OpenRouter via LangChain.

Inputs:
  - jargon.csv (must contain at least: id, name, slug)
  - translation.csv (must contain at least: id, name, jargon_id)

Output:
  - llm_ranks.csv with columns: translation_id, llm_rank

Environment:
  - AI_API_KEY: API key for OpenRouter

Notes:
  - We do not mutate any database here; this is offline ranking.
  - Newly added translations after a run should default to NULL in DB until next batch.
  - Resumable: if llm_ranks.csv exists, skip GPT calls for any group whose translations
    are already fully ranked; write progress after each processed group.
"""

import os
import sys
import time
import argparse
import re
import pandas as pd
from tqdm import tqdm
from typing import List, Tuple, Dict
from dotenv import load_dotenv

from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage, SystemMessage


SYSTEM_PROMPT = """
컴퓨터과학 및 컴퓨터공학 분야의 전문용어를 쉽게 번역하는 것의 취지는 다음과 같아야 한다:
---
# 배경
전문지식이 전문가들에게만 머문다면 그 분야는 그렇게 쇠퇴할 수 있다. 저변이 좁아지고 깊은 공부를 달성하는 인구는 그만큼 쪼그라들 수 있다.
전문지식이 보다 많은 사람들에게 널리 퍼진다면, 그래서 더 발전할 힘이 많이 모이는 활기찬 선순환이 만들어진다면. 그러면 그 분야를 밀어올리는 힘은 나날이 커질 수 있다. 더 많은 사람들이 더 나은 성과를 위한 문제제기와 답안제안에 참여할 수 있고, 전문가의 성과는 더 널리 이해되고 더 점검받을 수 있게된다.
그러므로 쉬운 전문용어가 어떨까. 전문개념의 핵심을 쉽게 전달해주는 전문용어. 학술은 학술의 언어를—우리로서는 소리로만 읽을 원어나 한문을—사용해야만 정확하고 정밀하고 경제적일까? 아무리 정교한 전문지식이라도 쉬운 일상어로 짧고 정밀하게 전달될 수 있다. 시에서 평범한 언어로 밀도 있게 전달되는 정밀한 느낌을 겪으며 짐작되는 바이다.
쉬운 전문용어가 활발히 만들어지고 테스트되는 생태계. 이것이 울타리없는 세계경쟁에서 우리를 깊고 높게 키워줄 비옥한 토양이다. 시끌벅적 쉬운말로 하는 학술의 재미는 말할것도 없다.
# 원칙
쉬운 전문용어를 만들때 원칙은 다음과 같다.
  * 정확히 이해하기: 전문용어의 의미를 정확히 이해하도록 한다. 이해못했다면 쉬운말을 찾을 수 없다.
  * 쉬운말을 찾기: 그 의미가 정확히 전달되는 쉬운말을 찾는다.
  * 어깨힘 빼기: 이때, 어깨에 힘을 뺀다. 지레 겁먹게하는 용어(불필요한 한문투)를 피하고, 가능하면 쉬운말을 찾는다.
  * 하나만 필요는 없다: 전문용어 하나에 쉬운 한글용어 하나가 일대일 대응일 필요가 없이, 상황에 따라서 다양하게 풀어쓸 수 있다. 중요한 것은 의미의 명확한 전개.
  * 때로는 소리나는 대로: 도저히 쉬운말을 찾을 수 없을 땐, 소리나는대로 쓴다.
  * 때로는 만들기: 쉬운 느낌을 가진 새 말을 만들 수도 있다. 우리가 모국어의 심연을 공유하므로 가능하다.
  * 괄호안에 항상-I: 원문 전문용어는 괄호안에 항상 따라붙인다.
  * 깨어있기: 기존의 관성에 눈멀지 않는다. 이미 널리퍼진 용어지만 쉽지않다면, 보다 쉬운 전문용어를 찾고 실험한다.
  * 괄호안에 항상-II: 이때, 기존용어는 원문 전문용어와 함께 괄호안에 따라붙인다.
  * 순우리말 No, 쉬운말 Yes: 쉬운말은 순수 우리말을 뜻하지 않는다. 외래어라도 널리 쉽게 받아들여진다면 사용한다.
# 쓰임
K-언어권에서 말하고 글 쓸 때 사용한다.
  * 설명/강의/저술/번역/블로그/SNS 등에서 한국어로 말하고 글 쓸 때 사용한다.
  * 쉽게쉽게 도란도란, 통쾌하게 시끌벅적, 차근차근 왁자글, 신나게 재미있게.
"""

def build_prompt(jargon_name: str, translations: List[str], comments: List[str]) -> str:
    lines = [
        "너는 컴퓨터 분야의 모든 개념을 완벽하게 파악하고 있는 전문가야. 영문 전문용어를 한국어 쉬운전문용어로 제안한 것들이 다음과 같아. 해당 개념을 가장 잘 전달하는 쉽고 직관적인 순서대로 나열해줘. 기존의 일상적이지 않은 한문투 전문용어는 바람직하지 않아. 대신에 누구나 쉽게 그 개념을 직감할 수 있는 용어들이 바람직한 쉬운전문용어야. 한국어 특성(풍부한 의태어, 의성어, 형용사, 부사)을 활용한 용어나 시적인 표현도 해당 개념을 잘 전달한다면 아무 문제 없어","순서는 첫 줄에 쉼표로 구분해서 0부터 시작해서 출력해. 용어들을 누락하면 안되고, 모든 단어들을 정렬해야 해.",
        "- 예시 출력: 2,0,1",
        f"- 전문용어: {jargon_name}",
        "- 쉬운 전문용어 번역 목록:",
    ]
    for idx, t in enumerate(translations):
        lines.append(f"  {idx}. {t}")
    lines.append("- 댓글 목록:")
    return "\n".join(lines)


def parse_order(text: str, num_items: int) -> List[int]:
    # Extract integers and clamp to a permutation-like ordering
    # Fallback: identity order if parsing fails
    try:
        text = text.split("\n")[0]
        numbers = [int(x.strip()) for x in re.split(",| |:", text) if x.strip().isdigit()]
        seen = set()
        order = []
        for n in numbers:
            if 0 <= n < num_items and n not in seen:
                order.append(n)
                seen.add(n)
        # Fill in missing indices
        for i in range(num_items):
            if i not in seen:
                print(f"Missing {i}")
                order.append(i)
        return order[:num_items]
    except Exception:
        print("Parsing failed")
        return list(range(num_items))


def main():
    parser = argparse.ArgumentParser(description="Rank translations per jargon with OpenRouter")
    parser.add_argument("--jargon_csv", default=os.path.join("jargon.csv"))
    parser.add_argument("--translation_csv", default=os.path.join("translation.csv"))
    parser.add_argument("--comment_csv", default=os.path.join("comment.csv"))
    parser.add_argument("--output_csv", default=os.path.join("llm_ranks.csv"))
    parser.add_argument("--rate_limit_sec", type=float, default=0.5, help="sleep between LLM calls")
    args = parser.parse_args()

    load_dotenv()
    api_key = os.getenv("AI_API_KEY")
    if not api_key:
        print("Set AI_API_KEY in env.", file=sys.stderr)
        sys.exit(1)

    chat = ChatOpenAI(api_key=api_key, base_url="https://openrouter.ai/api/v1", model="openai/gpt-5")

    # Load CSVs
    jargons = pd.read_csv(args.jargon_csv)
    translations = pd.read_csv(args.translation_csv)
    comments_df = pd.read_csv(args.comment_csv)

    # minimal columns validation
    for col in ["id", "name"]:
        if col not in jargons.columns:
            raise ValueError(f"jargon.csv missing column: {col}")
    for col in ["id", "name", "jargon_id"]:
        if col not in translations.columns:
            raise ValueError(f"translation.csv missing column: {col}")

    # Group translations by jargon_id
    grouped = translations.groupby("jargon_id")

    grouped_comments = comments_df.groupby("jargon_id") if "jargon_id" in comments_df.columns else None

    # Load existing progress if present
    existing_map: Dict[str, int] = {}
    if os.path.exists(args.output_csv):
        try:
            existing_df = pd.read_csv(args.output_csv)
            if "translation_id" in existing_df.columns and "llm_rank" in existing_df.columns:
                for row in existing_df.itertuples(index=False):
                    try:
                        existing_map[str(row.translation_id)] = int(row.llm_rank)
                    except Exception:
                        continue
            print(f"Loaded existing ranks: {len(existing_map)} from {args.output_csv}")
        except Exception as e:
            print(f"Warning: failed to read existing output {args.output_csv}: {e}", file=sys.stderr)

    def write_progress() -> None:
        tmp_path = args.output_csv + ".tmp"
        out_df = pd.DataFrame({"translation_id": list(existing_map.keys()), "llm_rank": list(existing_map.values())})
        out_df = out_df.sort_values(by=["translation_id"]).reset_index(drop=True)
        out_df.to_csv(tmp_path, index=False)
        os.replace(tmp_path, args.output_csv)

    # Build a map for jargon_id -> jargon_name for prompts
    jargon_name_by_id = {row.id: row.name for row in jargons.itertuples(index=False)}

    for jargon_id, group in tqdm(grouped):
        names = group["name"].fillna("").astype(str).tolist()
        tids = group["id"].astype(str).tolist()

        comments_list: List[str] = []
        if grouped_comments is not None and "content" in comments_df.columns:
            if jargon_id in grouped_comments.groups:
                comment_rows = grouped_comments.get_group(jargon_id)
                comments_list = comment_rows["content"].fillna("").astype(str).tolist()

        # Skip GPT if every translation in this group already ranked
        if all(tid in existing_map for tid in tids):
            continue

        if len(names) <= 1:
            changed = False
            for idx, tid in enumerate(tids):
                if existing_map.get(tid) != idx:
                    existing_map[tid] = idx
                    changed = True
            if changed:
                write_progress()
            continue

        jargon_name = jargon_name_by_id.get(jargon_id, "")
        prompt = build_prompt(jargon_name, names, comments_list)

        tqdm.write(f"Jargon: {jargon_name}, Translations: {names}, Comments: {comments_list}")
        try:
            response = chat.invoke([SystemMessage(content=SYSTEM_PROMPT), HumanMessage(content=prompt)])
            text = getattr(response, "content", "") or str(response)
        except Exception as e:
            # Fallback: identity order on errors
            tqdm.write(f"Error: {e}")
            text = ""
        finally:
            if args.rate_limit_sec > 0:
                time.sleep(args.rate_limit_sec)

        tqdm.write("===\n" + text)
        order = parse_order(text, len(names))
        tqdm.write(",".join([str(x) for x in order]))
        # Assign llm_rank based on order index
        inverse_rank = [0] * len(order)
        for rank, original_idx in enumerate(order):
            inverse_rank[original_idx] = rank

        for original_idx, tid in enumerate(tids):
            existing_map[tid] = inverse_rank[original_idx]
        write_progress()

    # Final summary
    print(f"Wrote {len(existing_map)} rows to {args.output_csv}")


if __name__ == "__main__":
    main()
