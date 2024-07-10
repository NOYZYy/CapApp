from fastapi import APIRouter, HTTPException,File,UploadFile
from models.synoptiques import Synoptique, DeleteSynoptique, GetSynoptique, UploadImageSynoptque, GetImageSynoptique
from config.database import collection,collection_name,db
from schema.schemas import synoptique_serial,synoptiques_serail
from bson import ObjectId

synoptiquerouter= APIRouter()

@synoptiquerouter.post("/synoptique")
async def get_composant(synoptique: GetSynoptique):
    collection= db[synoptique.perimetre]
    query = {"_id": ObjectId(synoptique.id)}
    document= collection.find_one(query,{"_id": 0, f"systems.{synoptique.system}": 1})
    if("composants" in document["systems"][synoptique.system]["synoptique"]):
        return synoptiques_serail(document["systems"][synoptique.system]["synoptique"]["composants"])
    else:
        return ""

@synoptiquerouter.put("/synoptique")
async def put_composant(synoptique: Synoptique):
    collection= db[synoptique.perimetre]
    query = {"_id": ObjectId(synoptique.id)}
    document= collection.find_one(query)
    if document and isinstance(document["systems"][synoptique.system]["synoptique"], dict):
        print("The 'system' field is already of type object.")
    else:
        update = {"$set": {f"systems.{synoptique.system}.synoptique": {}}}
        collection.update_one(query,update)
    update = {"$set": {f"systems.{synoptique.system}.synoptique.composants.{synoptique.composant}": synoptique_serial(dict(synoptique))}}
    result= collection.update_one(query, update)
    if result.modified_count > 0:
        return "Success"
    else:
        return "Failier"
    
@synoptiquerouter.delete("/synoptique")
async def delete_composant(synoptique: DeleteSynoptique):
    collection= db[synoptique.perimetre]
    result = collection.update_one({"_id": ObjectId(synoptique.id)},{"$unset": {f"systems.{synoptique.system}.synoptique.composants.{synoptique.composant}": 1}})
    if result.modified_count > 0:
        return "Success"
    else:
        return "Failier"
    

@synoptiquerouter.post("/synoptique/image")
async def upload_image(direction: UploadImageSynoptque):
    collection= db[direction.perimetre]
    query = {"_id": ObjectId(direction.id)}
    document = collection.find_one(query)
    if document and isinstance(document["systems"][direction.system]["synoptique"], dict):
        print("The 'detail' field is already of type object.")
    else:
        update = {"$set": {f"systems.{direction.system}.synoptique": {}}}
        collection.update_one(query, update)
        print("Document updated successfully.")
    
    update = {"$set": {f"systems.{direction.system}.synoptique.image": {
        "name": direction.image,
        "base64": direction.base64
    }}}
    collection.update_one(query, update)
    return "Success"

@synoptiquerouter.post("/synoptique/get/image")
async def get_image(direction: GetImageSynoptique):
    collection= db[direction.perimetre]
    query = {"_id": ObjectId(direction.id)}
    document= collection.find_one(query,{"_id": 0, f"systems.{direction.system}": 1})
    if("image" in document["systems"][direction.system]["synoptique"]):
        return document["systems"][direction.system]["synoptique"]["image"]
    else:
        return ""