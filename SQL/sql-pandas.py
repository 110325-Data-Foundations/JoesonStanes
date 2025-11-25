import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os


#STEP 1 :Load out environment variables from our .env files
load_dotenv()

database_url = os.getenv("DATABASE_URL")

#print(database_url)
#Step 2 ": Create a database engine"
engine= create_engine(database_url)


df=pd.read_sql("SELECT * FROM Album LIMIT 5", engine)
print(df)
genre_df=pd.read_sql('genre', engine)
print(genre_df.head())