from pydantic import BaseModel

class System(BaseModel):
    perimetre: str
    id: str
    name: str
    description: str
    composants: str
    synoptique: str
    nftrs: str
    quiz: str

class GetSystem(BaseModel):
    id: str
    perimetre: str

class UpdateSystem(BaseModel):
    id: str
    perimetre: str
    system: str
    name: str
    description: str 

class DeleteSystem(BaseModel):
    id: str 
    perimetre: str
    system: str
