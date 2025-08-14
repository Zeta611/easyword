import Link from "next/link";
import { Separator } from "@/components/ui/separator";
import GitHub from "@/components/icons/github";

export const metadata = {
  title: "제작기 | 쉬운 전문용어",
  description: "쉬운 전문용어 사이트 제작 배경과 기술 선택에 대해 소개합니다.",
};

export default function ColophonPage() {
  return (
    <div className="mx-auto flex w-full max-w-3xl flex-col gap-6">
      <header className="flex flex-col gap-1">
        <h1 className="text-3xl font-bold">제작기</h1>
      </header>

      <div className="text-right text-sm">
        <Link
          href="https://ropas.snu.ac.kr/~jhlee"
          target="_blank"
          rel="noopener noreferrer"
          className="hover:text-foreground underline underline-offset-4"
        >
          서울대학교 프로그래밍 연구실 이재호
        </Link>
      </div>

      <Separator />

      <section className="flex flex-col gap-3">
        <h2 className="text-2xl font-semibold">더 빨라진 쉬운 전문용어</h2>
        <p className="text-foreground leading-7">
          새로운 쉬운 전문용어는 사용자에게 보다 쾌적하고 빠른 경험을 제공하는데
          초점을 두고 개발하였다. 이를 위해, 경계없는 프로그래밍(tierless
          programming, multi-tier programming)을 통해 앞단(frontend)과
          뒷단(backend)의 코드를 함께 작성할 수 있는 Next.js를 써서 밑바닥부터
          다시 개발하였다.
        </p>
        <p className="text-foreground leading-7">
          Next.js는 리액트 컴포넌트를 서버쪽에서 그릴 수 있다 (server-side
          rendering, SSR). SSR을 통해 사용자는 이미 그려진 웹사이트를 받아오기
          때문에, 브라우저에 도달해 비로소 화면을 그리기 시작하는 것(client-side
          rendering, CSR)보다 더 빠른 경험을 누릴 수 있다.
        </p>
        <p className="text-foreground leading-7">
          또한 TanStack Query를 사용해, 이미 불러온 데이터는{" "}
          <Link
            href="/jargon/cache"
            target="_blank"
            className="underline underline-offset-4"
          >
            주머니(cache)
          </Link>
          에 넣어두는 방식으로 더 빠른 경험을 제공할 수 있게 되었다.
        </p>
        <p className="text-foreground leading-7">
          리액트 훅의 작동 의미구조를 명확히 정리하면서 얻은 연구경험, 그리고
          기존 사이트를 만들어본 개발경험 덕에 새로운 버전을 더 수월하게 만들 수
          있었다.
        </p>
      </section>

      <section className="flex flex-col gap-3">
        <h2 className="text-2xl font-semibold">더 알아보기</h2>
        <p className="text-foreground leading-7">
          쉬운 전문용어의 소스코드는{" "}
          <Link
            href="https://github.com/Zeta611/easyword"
            target="_blank"
            rel="noopener noreferrer"
            className="underline underline-offset-4"
          >
            <GitHub className="inline-block size-4" /> Zeta611/easyword
          </Link>
          에서 살펴볼 수 있다. 사이트 자체에 대한 질문이나 건의사항이 있다면
          깃허브의{" "}
          <Link
            href="https://github.com/Zeta611/easyword/issues"
            target="_blank"
            rel="noopener noreferrer"
            className="underline underline-offset-4"
          >
            이슈
          </Link>{" "}
          기능을 활용하면 된다.
        </p>
      </section>

      <Separator />
      <section className="flex flex-col gap-3">
        <h2 className="text-2xl font-semibold">
          초기 버전: 기초가 튼튼한 언어로 작성하기
        </h2>
        <p className="text-foreground leading-7">
          본 사이트의 앞단(frontend)은 ReScript로 작성되었다. ReScript는 강력한
          정적 타입 시스템이 장착된 OCaml에서 파생된 함수형 프로그래밍 언어로,
          웹 프로그래밍의 표준이 된 JavaScript로 번역된다. 이러한 특징을 가진
          ReScript는 탄탄한 프로그래밍 언어의 기반과 풍부한 JavaScript 생태계의
          이점을 동시에 누린다. 안전하면서도 편리한 언어의 힘을 맛 본 사람으로서
          ReScript는 매력적인 언어일 수밖에 없다.
        </p>
        <p className="text-foreground leading-7">
          TypeScript와 Flow처럼 기존의 JavaScript 위에 정적 타입 시스템을 얹는
          방법도 있지만, 이런 방식은 분명 언어를 고안할 때부터 정적 타입
          시스템을 염두한 것에 비하면 불완전하다. ReScript는 JSX, 비동기 처리와
          같은 JavaScript 세상과의 연결도 편리하게 제공하면서, OCaml의 계보를
          이어받아 가변 변수, 예외, 모듈 시스템과 같은 기능과 더불어 (원한다면)
          GADT, 확장 가능한 갈래 타입(extensible variant) 등의 기능도 제공한다.
        </p>
        <p className="text-foreground leading-7">
          함수형 사고방식을 지향하는 ReScript의 장점은 React의 함수 컴포넌트를
          사용할 때 빛을 발휘한다. 특히 임의로 중첩되는 나무 구조식 댓글을 만들
          때 체감할 수 있었는데, 서로 맞물려 돌아가는 컴포넌트로 댓글 구조를
          만들었을 때의 전율은 아직도 생생하다.
        </p>
      </section>
    </div>
  );
}
