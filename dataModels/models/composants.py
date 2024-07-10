from pydantic import BaseModel

class Composant(BaseModel):
    id: str
    perimetre: str
    system: str
    name: str
    description: str
    detail: str

class GetComposant(BaseModel):
    id: str
    perimetre: str
    system: str

class UpdateComposant(BaseModel):
    id: str
    perimetre: str
    system: str
    composant: str
    name: str
    description: str

class DeleteComposant(BaseModel):
    id: str
    perimetre: str
    system: str
    composant: str