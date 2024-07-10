from fastapi import HTTPException
from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client["cap"]
collection_name= "NEW"
collection = db[collection_name]