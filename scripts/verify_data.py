from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()
USER = os.getenv("user") or "postgres"
PASSWORD = os.getenv("password") or "postgres"
HOST = os.getenv("host") or "localhost"
PORT = os.getenv("port") or "54322"
DBNAME = os.getenv("dbname") or "postgres"

DATABASE_URL = f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=disable"

engine = create_engine(DATABASE_URL)

with engine.connect() as connection:
    jargon_count = connection.execute(text("SELECT COUNT(*) FROM jargon")).scalar()
    translation_count = connection.execute(text("SELECT COUNT(*) FROM translation")).scalar()
    comment_count = connection.execute(text("SELECT COUNT(*) FROM comment")).scalar()
    
    print(f"Jargon count: {jargon_count}")
    print(f"Translation count: {translation_count}")
    print(f"Comment count: {comment_count}")
