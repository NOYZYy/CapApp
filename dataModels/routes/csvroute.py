import base64
from fastapi import APIRouter, HTTPException, UploadFile, File
from models.csv import GetCsv, UploadCsv
from config.database import collection,collection_name,db
from schema.schemas import csv_serail
from bson import ObjectId
import pandas as pd
import io

csvrouter= APIRouter()

@csvrouter.put("/csv")
async def upload_csv(csv: UploadCsv):
    collection= db[csv.perimetre]
    contents = base64.b64decode(csv.base64)
    data = pd.read_csv(io.BytesIO(contents))
    query = {"_id": ObjectId("6664c6593be68ed6e697fc57")}
    document = collection.find_one(query)
    records = data.to_dict(orient='records')
    formatted_records = {str(index + 1): record for index, record in enumerate(records)}
    if document and isinstance(document["systems"][csv.system]["quiz"], dict):
        print("The 'system' field is already of type object.")
    else:
        update = {"$set": {f"systems.{csv.system}.quiz": {}}}
        collection.update_one(query, update)
        print("Document updated successfully.")
    if "count" in document["systems"][csv.system]["quiz"]:
        document["systems"][csv.system]["quiz"]["count"] += len(records)
    else:
        update = {"$set": {f"systems.{csv.system}.quiz.count": len(records)}}
        collection.update_one(query, update)
    update = {"$set": {f"systems.{csv.system}.quiz.qcm": dict(formatted_records)}}
    collection.update_one(query, update)
    return {"status": "CSV data inserted into MongoDB successfully"}

@csvrouter.post("/csv")
async def get_composant(direction : GetCsv):
    collection= db[direction.perimetre]
    query = {"_id": ObjectId(direction.id)}
    document= collection.find_one(query,{"_id": 0, f"systems.{direction.system}": 1})
    if("qcm" in document["systems"][direction.system]["quiz"]):
        return csv_serail(document["systems"][direction.system]["quiz"]["qcm"])
    else:
        return ""