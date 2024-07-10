from pydantic import BaseModel

class GetCsv(BaseModel):
    id: str
    perimetre: str
    system: str

class UploadCsv(BaseModel):
    id: str
    perimetre: str
    system: str
    base64: str