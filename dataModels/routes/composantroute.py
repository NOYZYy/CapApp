from fastapi import APIRouter, HTTPException
from models.composants import Composant, GetComposant, UpdateComposant, DeleteComposant
from config.database import collection,collection_name,db
from schema.schemas import composant_serial,composants_serial
from bson import ObjectId

composantrouter= APIRouter()

# GET request method
@composantrouter.post("/composant/get")
async def get_composant(composant: GetComposant):
    collection= db[composant.perimetre]
    query = {"_id": ObjectId(composant.id)}
    document= collection.find_one(query,{"_id": 0, f"systems.{composant.system}": 1})
    return composants_serial(document["systems"][composant.system]["composants"])

@composantrouter.post("/composant")
async def post_composant(composant: Composant):
    collection= db[composant.perimetre]
    query = {"_id": ObjectId(composant.id)}
    document = collection.find_one(query)
    if document and isinstance(document["systems"][composant.system]["composants"], dict):
        print("The 'system' field is already of type object.")
    else:
        update = {"$set": {f"systems.{composant.system}.composants": {}}}
        collection.update_one(query, update)
        print("Document updated successfully.")
    if composant.name in document["systems"][composant.system]["composants"]:
        return "Composant allready exists"
    else:
        update = {"$set": {f"systems.{composant.system}.composants.{composant.name}": composant_serial(dict(composant))}}
        collection.update_one(query, update)
        return "Success"

@composantrouter.put("/composant")
async def put_composant(composant: UpdateComposant):
    collection= db[composant.perimetre]
    document= collection.find_one({"_id": ObjectId(composant.id)})
    document['systems'][composant.system]["composants"][composant.composant]["name"]= str(composant.name)
    document['systems'][composant.system]["composants"][composant.composant]["description"]= str(composant.description)
    document['systems'][composant.system]["composants"][composant.name] = document['systems'][composant.system]["composants"].pop(composant.composant)
    result= collection.update_one({"_id": ObjectId(composant.id)}, {"$set": {f"systems.{composant.system}.composants": dict(document['systems'][composant.system]["composants"])}})
    if result.modified_count > 0:
        return "Success"
    else:
        return "Failier"
        

@composantrouter.delete("/composant")
async def delete_composant(composant: DeleteComposant):
    collection= db[composant.perimetre]
    result = collection.update_one({"_id": ObjectId(composant.id)},{"$unset": {f"systems.{composant.system}.composants.{composant.composant}": 1}})
    if result.modified_count > 0:
        return "Success"
    else:
        return "Failier"