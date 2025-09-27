from sqlalchemy import create_engine
from sqlalchemy.pool import NullPool
from dotenv import load_dotenv
import pandas as pd
import os

load_dotenv()
USER = os.getenv("user")
PASSWORD = os.getenv("password")
HOST = os.getenv("host")
PORT = os.getenv("port")
DBNAME = os.getenv("dbname")

DATABASE_URL = f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=require"

engine = create_engine(DATABASE_URL, poolclass=NullPool)

tables = ["category", "comment", "html", "jargon", "jargon_category", "translation"]
try:
    with engine.connect() as connection:
        for table in tables:
            print(f"Table: {table}")
            df = pd.read_sql(f"SELECT * FROM public.{table}", engine)
            n_rows, n_cols = df.shape
            print(f" Rows: {n_rows}, Columns: {n_cols}")
            print(" Columns: ", list(df.columns))

            df.to_csv(f"{table}.csv", index=False)
except Exception as e:
    print(f"Failed to connect: {e}")
