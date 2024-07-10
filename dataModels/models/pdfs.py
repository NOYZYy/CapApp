from pydantic import BaseModel

class UpdatePdf(BaseModel):
    id: str
    perimetre: str
    system: str
    composant: str
    type: str
    base64: str

class GetPdfs(BaseModel):
    id: str
    perimetre: str
    system: str
    composant: str