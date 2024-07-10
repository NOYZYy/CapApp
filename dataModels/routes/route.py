from fastapi import APIRouter, HTTPException
from models.perimetres import Perimetre,UpdatePerimetre,DeletePerimetre
from config.database import collection,collection_name,db
from schema.schemas import perimetres_serial
from bson import ObjectId

router= APIRouter()

# GET request method
@router.get("/")
async def get_perimetres():
    perimetres= []
    for collection_name in db.list_collection_names():
        collection= db[collection_name]
        perimetre= perimetres_serial(collection.find())
        perimetres.append(perimetre)
    return perimetres

@router.post("/")
async def post_perimetre(perimetre: Perimetre):   
    if perimetre.name in db.list_collection_names():
        raise HTTPException(status_code=400, detail="Collection already exists")
    else:
        db.create_collection(perimetre.name)
    collection_name= perimetre.name
    collection= db[collection_name]
    collection.insert_one(dict(perimetre))
    help= perimetres_serial(collection.find())
    return {
        "id": help[0]["id"]
    }

@router.put("/")
async def put_perimetres(perimetre: UpdatePerimetre):
    if perimetre.collection in db.list_collection_names():
        collection_name= perimetre.collection
        collection= db[collection_name]
        collection.find_one_and_update({"_id": ObjectId(perimetre.id)},{"$set": {"name": str(perimetre.name),"description": str(perimetre.description)}},)
        collection.rename(perimetre.name)
    else:
        raise HTTPException(status_code=400, detail=perimetre.collection+" does not exists")

@router.delete("/")
async def delete_perimetres(perimetre: DeletePerimetre):
    if perimetre.collection in db.list_collection_names():
        db[perimetre.collection].drop()
    else:
        raise HTTPException(status_code=400, detail=perimetre.collection+" does not exists")