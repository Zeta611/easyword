#!/usr/bin/env python3
"""
Batch update Supabase translation.llm_rank using CSV produced by rank_translations_llm.py

Inputs:
  - llm_ranks.csv with columns: translation_id, llm_rank (new rankings)
  - llm_ranks.csv.bak (previous rankings for diffing)

Environment:
  - For direct Postgres: use same .env as dump.py (user, password, host, port, dbname)
    or set DATABASE_URL explicitly (postgresql+psycopg2://...)

Behavior:
  - Diffs llm_ranks.csv against llm_ranks.csv.bak to find changed/new rows
  - Only updates rows where llm_rank has changed (typically ~10 rows)
  - Does not update updated_at timestamp
  - If no backup file exists, updates all rows
  - On missing rows in DB, skips silently

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
    parser.add_argument("--backup_csv", default="llm_ranks.csv.bak")
    parser.add_argument("--batch_size", type=int, default=1000)
    args = parser.parse_args()

    # Read new and backup CSVs
    df_new = pd.read_csv(args.ranks_csv)
    if "translation_id" not in df_new.columns or "llm_rank" not in df_new.columns:
        raise ValueError("llm_ranks.csv must have columns: translation_id, llm_rank")

    # Read backup CSV (if it doesn't exist, update all rows)
    if not os.path.exists(args.backup_csv):
        print(f"Backup file {args.backup_csv} not found; updating all rows")
        df_changed = df_new
    else:
        df_old = pd.read_csv(args.backup_csv)
        if "translation_id" not in df_old.columns or "llm_rank" not in df_old.columns:
            raise ValueError("Backup CSV must have columns: translation_id, llm_rank")

        # Merge to find changes
        merged = df_new.merge(
            df_old,
            on="translation_id",
            how="left",
            suffixes=("_new", "_old")
        )

        # Filter to only rows where llm_rank changed or is new
        df_changed = merged[
            (merged["llm_rank_old"].isna()) |
            (merged["llm_rank_new"] != merged["llm_rank_old"])
        ][["translation_id", "llm_rank_new"]].rename(columns={"llm_rank_new": "llm_rank"})

        print(f"Found {len(df_changed)} changed/new rows out of {len(df_new)} total")

    if len(df_changed) == 0:
        print("No changes to update")
        return

    if len(df_changed) <= 200:
      print("df_changed:", df_changed, sep="\n")

    engine = get_engine()

    sql = text("""
        update public.translation as t
           set llm_rank = v.llm_rank
          from (values (:translation_id, :llm_rank)) as v(translation_id, llm_rank)
         where t.id = v.translation_id::uuid
    """)

    total = 0
    with engine.begin() as conn:
        rows = df_changed.to_dict("records")
        for i in range(0, len(rows), args.batch_size):
            batch = rows[i : i + args.batch_size]
            # executemany: param style is dict per row
            conn.execute(sql, batch)
            total += len(batch)

    print(f"Updated llm_rank for {total} rows")


if __name__ == "__main__":
    main()
