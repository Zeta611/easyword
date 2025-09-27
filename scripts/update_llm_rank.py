#!/usr/bin/env python3
"""
Batch update Supabase translation.llm_rank using CSV produced by rank_translations_llm.py

Inputs:
  - llm_ranks.csv with columns: translation_id, llm_rank

Environment:
  - For direct Postgres: use same .env as dump.py (user, password, host, port, dbname)
    or set DATABASE_URL explicitly (postgresql+psycopg2://...)

Behavior:
  - Performs efficient batched updates using SQLAlchemy executemany.
  - On missing rows, skips silently.

Note:
  - New translations added after a ranking run should keep llm_rank NULL until next batch.
"""

import os
import sys
import argparse
import pandas as pd
from sqlalchemy import create_engine, text
from sqlalchemy.pool import NullPool
from dotenv import load_dotenv


def get_engine():
    load_dotenv()
    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        user = os.getenv("user")
        password = os.getenv("password")
        host = os.getenv("host")
        port = os.getenv("port")
        dbname = os.getenv("dbname")
        if not all([user, password, host, port, dbname]):
            print("Missing DB env vars; set DATABASE_URL or user/password/host/port/dbname.", file=sys.stderr)
            sys.exit(1)
        # Align with dump.py: require SSL for remote; local may ignore
        database_url = f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}?sslmode=require"
    return create_engine(database_url, poolclass=NullPool)


def main():
    parser = argparse.ArgumentParser(description="Update translation.llm_rank from CSV")
    parser.add_argument("--ranks_csv", default="llm_ranks.csv")
    parser.add_argument("--batch_size", type=int, default=1000)
    args = parser.parse_args()

    df = pd.read_csv(args.ranks_csv)
    if "translation_id" not in df.columns or "llm_rank" not in df.columns:
        raise ValueError("llm_ranks.csv must have columns: translation_id, llm_rank")

    engine = get_engine()

    sql = text("""
        update public.translation as t
           set llm_rank = v.llm_rank,
               updated_at = now()
          from (values (:translation_id, :llm_rank)) as v(translation_id, llm_rank)
         where t.id = v.translation_id::uuid
    """)

    total = 0
    with engine.begin() as conn:
        rows = df.to_dict("records")
        for i in range(0, len(rows), args.batch_size):
            batch = rows[i : i + args.batch_size]
            # executemany: param style is dict per row
            conn.execute(sql, batch)
            total += len(batch)

    print(f"Updated llm_rank for {total} rows")


if __name__ == "__main__":
    main()
