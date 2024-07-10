from fastapi import APIRouter, HTTPException
from models.systems import System,GetSystem,UpdateSystem,DeleteSystem
from config.database import collection,collection_name,db
from schema.schemas import systems_serial,system_serial
from bson import ObjectId

systemrouter= APIRouter()

# GET request method
@systemrouter.post("/system/get")
async def get_system(system: GetSystem):
    collection= db[system.perimetre]
    query = {"_id": ObjectId(system.id)}
    document= collection.find_one(query,{"_id": 0, "systems": 1})
    return systems_serial(document["systems"])

@systemrouter.post("/system")
async def post_system(system: System):
    collection= db[system.perimetre]
    query = {"_id": ObjectId(system.id)}
    document = collection.find_one(query)
    if document and isinstance(document.get("systems"), dict):
        print("The 'system' field is already of type object.")
    else:
        if system.name in document["systems"]:
            return "System allready exists"
        else:
            update = {"$set": {"systems": {}}}
            collection.update_one(query, update)
            print("Document updated successfully.")
    update = {"$set": {f"systems.{system.name}": system_serial(dict(system))}}
    collection.update_one(query, update)
    return system_serial(dict(system))["name"]
    

@systemrouter.put("/system")
async def put_system(system: UpdateSystem):
    collection= db[system.perimetre]
    document= collection.find_one({"_id": ObjectId(system.id)})
    document['systems'][system.system]['name']= str(system.name)
    document['systems'][system.system]['description']= str(system.description)
    document['systems'][system.name] = document['systems'].pop(system.system)
    result= collection.update_one({"_id": ObjectId(system.id)}, {"$set": {"systems": dict(document['systems'])}})
    if result.modified_count > 0:
        return "Success"
    else:
        return "Failur"
        

@systemrouter.delete("/system")
async def delete_system(system: DeleteSystem):
    collection= db[system.perimetre]
    result = collection.update_one({"_id": ObjectId(system.id)},{"$unset": {f"systems.{system.system}": 1}})
    if result.modified_count > 0:
        print("Document 'FF' removed from 'system' successfully.")
    else:
        print("Document 'FF' was not found or could not be removed.")