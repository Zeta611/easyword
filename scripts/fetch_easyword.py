import requests
from bs4 import BeautifulSoup
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv
import os
import uuid
from datetime import datetime

# Load environment variables
load_dotenv()
USER = os.getenv("user") or "postgres"
PASSWORD = os.getenv("password") or "postgres"
HOST = os.getenv("host") or "localhost"
PORT = os.getenv("port") or "54322"
DBNAME = os.getenv("dbname") or "postgres"

print(f"Connecting to DB: {USER}@{HOST}:{PORT}/{DBNAME}")

DATABASE_URL = f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=disable"

engine = create_engine(DATABASE_URL)
Session = sessionmaker(bind=engine)
session = Session()

def fetch_easyword_data():
    url = "https://easyword.kr"
    response = requests.get(url)
    if response.status_code != 200:
        print(f"Failed to fetch {url}: {response.status_code}")
        return []

    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Based on the chunk content seen earlier, the structure seems to be headers (h3) followed by text.
    # However, looking at the chunk output:
    # headers:{type:MARKDOWN_NODE_TYPE_HEADER_3 text:"trace"} ... text:"### trace\n실행 경로\n[PLcalculus of constructions...](...)\n\n### calculus of constructions\n증명짓기 계산법..."
    # It seems the main page lists jargons.
    # Let's try to find all h3 elements which seem to be the jargon names, and the text immediately following them.
    
    # A more robust way might be to look for the specific structure if we can infer it better.
    # The chunk text shows "### jargon_name\ntranslations\n[category...]"
    
    # Let's iterate through h3 tags.
    
    items = []
    for h3 in soup.find_all('h3'):
        jargon_name = h3.get_text(strip=True)
        
        # The next sibling should contain the translations.
        # It might be a text node or a p tag.
        # Let's look at the next sibling.
        
        translations_text = ""
        next_node = h3.next_sibling
        while next_node and next_node.name != 'h3':
            if isinstance(next_node, str):
                translations_text += next_node.strip() + " "
            elif next_node.name == 'p': # Assuming translations might be in p tags
                 translations_text += next_node.get_text(strip=True) + " "
            # Stop if we hit the next jargon or some other container
            next_node = next_node.next_sibling
            
        # Clean up translations
        # The text output from read_url_content showed: "### trace\n실행 경로\n[PL..."
        # So the text immediately after h3 is likely the translation.
        
        # Let's try to be a bit more specific if possible. 
        # But for now, let's grab the text.
        
        # Wait, the read_url_content output is markdown converted from HTML.
        # In raw HTML, it might be <h3>trace</h3><p>실행 경로</p>...
        
        # Let's assume the text immediately following the h3 is the translation list.
        # We can refine this if needed.
        
        if translations_text:
            # Split by comma if multiple translations?
            # The example showed: "즉석 번역기, 실행시점 번역기, ..."
            translations = [t.strip() for t in translations_text.split(',') if t.strip()]
            items.append({'jargon': jargon_name, 'translations': translations})
            
    return items

def insert_data(items):
    # Use a default admin user ID for author_id. 
    # From seed.sql: 'faa73ac2-bbed-40ea-a392-53baf1a946fe' is 'jaeho.lee@snu.ac.kr' (admin)
    AUTHOR_ID = 'faa73ac2-bbed-40ea-a392-53baf1a946fe'
    
    for item in items:
        jargon_name = item['jargon']
        translations = item['translations']
        
        print(f"Processing: {jargon_name}")
        
        # Check if jargon exists
        existing_jargon = session.execute(
            text("SELECT id FROM jargon WHERE name = :name"),
            {"name": jargon_name}
        ).fetchone()
        
        if existing_jargon:
            jargon_id = existing_jargon[0]
            print(f"  Jargon '{jargon_name}' already exists (ID: {jargon_id})")
        else:
            jargon_id = str(uuid.uuid4())
            slug = jargon_name.lower().replace(' ', '-')
            now = datetime.now()
            
            session.execute(
                text("""
                    INSERT INTO jargon (id, name, slug, author_id, created_at, updated_at)
                    VALUES (:id, :name, :slug, :author_id, :created_at, :updated_at)
                """),
                {
                    "id": jargon_id,
                    "name": jargon_name,
                    "slug": slug,
                    "author_id": AUTHOR_ID,
                    "created_at": now,
                    "updated_at": now
                }
            )
            print(f"  Inserted jargon '{jargon_name}'")
            
        # Insert translations
        for trans_name in translations:
            # Check if translation exists for this jargon
            # Note: The schema for translation table has jargon_id.
            # We should check if this specific translation exists for this jargon.
            
            # However, translation table has 'name' and 'jargon_id'.
            # Let's check if a translation with this name exists for this jargon.
            
            # Also, we need to filter out things that look like metadata (e.g. "[PL...]")
            # The read_url_content output showed links like [PL...]. 
            # In the HTML, these might be anchor tags. 
            # My simple extraction might catch them if they are just text.
            # But if they are links, get_text might include them.
            # Let's assume for now we want to clean them up if they look like "[...]".
            
            if trans_name.startswith('[') and trans_name.endswith(']'):
                continue
                
            # Clean up: remove any trailing "..." or similar if present
            # The example showed: "PLcalculus of constructions증명짓기 계산법..." in the link text.
            # Wait, the link text in the markdown was: "PLcalculus of constructions증명짓기 계산법, 하나된 계산법2·5일 전"
            # This suggests the link text contains the category, english name, korean name, and date.
            # This is messy.
            
            # Let's look at the HTML structure more closely if possible.
            # Since I can't interactively debug the soup object easily without running it,
            # I will try to be robust.
            
            # If the translation contains the jargon name, it might be the link text I saw.
            # e.g. "PLcalculus of constructions..."
            
            # Let's try to filter out obviously bad translations.
            if jargon_name in trans_name and len(trans_name) > len(jargon_name) + 10:
                 # Likely the metadata string
                 continue
            
            existing_trans = session.execute(
                text("SELECT id FROM translation WHERE name = :name AND jargon_id = :jargon_id"),
                {"name": trans_name, "jargon_id": jargon_id}
            ).fetchone()
            
            if not existing_trans:
                trans_id = str(uuid.uuid4())
                comment_id = str(uuid.uuid4())
                now = datetime.now()
                
                # 1. Create Comment first (translation_id is nullable)
                comment_content = f"Proposed translation: {trans_name}"
                session.execute(
                    text("""
                        INSERT INTO comment (id, content, jargon_id, author_id, created_at, updated_at, removed)
                        VALUES (:id, :content, :jargon_id, :author_id, :created_at, :updated_at, :removed)
                    """),
                    {
                        "id": comment_id,
                        "content": comment_content,
                        "jargon_id": jargon_id,
                        "author_id": AUTHOR_ID,
                        "created_at": now,
                        "updated_at": now,
                        "removed": False
                    }
                )
                
                # 2. Create Translation (referencing comment_id)
                session.execute(
                    text("""
                        INSERT INTO translation (id, name, jargon_id, author_id, created_at, updated_at, llm_rank, comment_id)
                        VALUES (:id, :name, :jargon_id, :author_id, :created_at, :updated_at, :llm_rank, :comment_id)
                    """),
                    {
                        "id": trans_id,
                        "name": trans_name,
                        "jargon_id": jargon_id,
                        "author_id": AUTHOR_ID,
                        "created_at": now,
                        "updated_at": now,
                        "llm_rank": 0,
                        "comment_id": comment_id
                    }
                )
                
                # 3. Update Comment to reference Translation
                session.execute(
                    text("""
                        UPDATE comment SET translation_id = :translation_id WHERE id = :id
                    """),
                    {
                        "translation_id": trans_id,
                        "id": comment_id
                    }
                )
                
                print(f"    Inserted translation '{trans_name}' and linked comment")
            else:
                print(f"    Translation '{trans_name}' already exists")
                
    session.commit()

if __name__ == "__main__":
    print("Fetching data from easyword.kr...")
    data = fetch_easyword_data()
    print(f"Found {len(data)} items.")
    if data:
        print("Inserting into database...")
        insert_data(data)
        print("Done.")
