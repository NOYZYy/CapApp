from fastapi import File, APIRouter, UploadFile, HTTPException
from models.pdfs import UpdatePdf, GetPdfs
from bson import ObjectId
from fastapi.responses import JSONResponse
from config.database import collection,collection_name,db

pdfsrouter= APIRouter()

@pdfsrouter.post("/upload")
async def upload_pdf(direction: UpdatePdf):
    collection= db[direction.perimetre]
    query = {"_id": ObjectId(direction.id)}
    document = collection.find_one(query)
    if document and isinstance(document["systems"][direction.system]["composants"][direction.composant]["detail"], dict):
        print("The 'detail' field is already of type object.")
    else:
        update = {"$set": {f"systems.{direction.system}.composants.{direction.composant}.detail": {}}}
        collection.update_one(query, update)
        print("Document updated successfully.")
    
    update = {"$set": {f"systems.{direction.system}.composants.{direction.composant}.detail.{direction.type}": direction.base64}}
    collection.update_one(query, update)
    return "Success"

@pdfsrouter.post("/upload/get")
async def get_pdfs(direction: GetPdfs):
    collection= db[direction.perimetre]
    query = {"_id": ObjectId(direction.id)}
    document= collection.find_one(query,{"_id": 0, f"systems.{direction.system}": 1})
    return document["systems"][direction.system]["composants"][direction.composant]["detail"]