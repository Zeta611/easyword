from dotenv import load_dotenv
import os

# Load .env.local explicitly
load_dotenv('.env.local')

keys = [
    "SOLAR_API_KEY",
    "OPENAI_API_KEY",
    "GOOGLE_SEARCH_API_KEY",
    "GOOGLE_SEARCH_ENGINE_ID"
]

print("Checking keys in .env.local:")
for key in keys:
    value = os.getenv(key)
    if value:
        print(f"{key}: Present (Length: {len(value)})")
    else:
        print(f"{key}: MISSING")
