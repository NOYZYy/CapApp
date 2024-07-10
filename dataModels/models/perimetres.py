from pydantic import BaseModel

class Perimetre(BaseModel):
    name: str
    description: str
    systems: str

class UpdatePerimetre(BaseModel):
    id: str
    collection: str
    name: str
    description: str

class DeletePerimetre(BaseModel):
    collection: str
