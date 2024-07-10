from pydantic import BaseModel

class Synoptique(BaseModel):
    id: str
    perimetre: str
    system: str
    composant: str
    description: str
    x: int
    y: int

class DeleteSynoptique(BaseModel):
    id: str
    perimetre: str
    system: str
    composant: str

class GetSynoptique(BaseModel):
    id: str
    perimetre: str
    system: str

class UploadImageSynoptque(BaseModel):
    id: str
    perimetre: str
    system: str
    image: str
    base64: str

class GetImageSynoptique(BaseModel):
    id: str
    perimetre: str
    system: str