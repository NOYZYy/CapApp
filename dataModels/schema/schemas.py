from bson import ObjectId
def perimetre_serial(perimetre) -> dict:
    return{
        "id": str(perimetre["_id"]),
        "name": perimetre["name"],
        "description": perimetre["description"]
    }

def perimetres_serial(perimetres) -> list:
    return[perimetre_serial(perimetre) for perimetre in perimetres]

def system_serial(system) -> dict:
    return{
        "_id": ObjectId(),
        "name": system["name"],
        "description": system["description"],
        "composants": system["composants"],
        "synoptique": system["synoptique"],
        "nftrs": system["nftrs"],
        "quiz": system["quiz"]
    }

def get_system_serial(system) -> dict:
    return{
        "id": str(system["_id"]),
        "name": system["name"],
        "description": system["description"]
    }

def systems_serial(systems) -> list:
    return[get_system_serial(systems[system]) for system in systems]

def composant_serial(composant) -> dict:
    return{
        "_id": ObjectId(),
        "name": composant["name"],
        "description": composant["description"],
        "detail": composant["detail"]
    }

def get_composant_serial(composant) -> dict:
    return{
        "id": str(composant["_id"]),
        "name": composant["name"],
        "description": composant["description"]
    }

def composants_serial(composants) -> list:
    return[get_composant_serial(composants[composant]) for composant in composants]

def synoptique_serial(synoptique) -> dict:
    return{
        "name": synoptique["composant"],
        "description": synoptique["description"],
        "x": synoptique["x"],
        "y": synoptique["y"]
    }

def get_synoptique_serial(synoptique) -> dict:
    return{
        "name": synoptique["name"],
        "description": synoptique["description"],
        "x": synoptique["x"],
        "y": synoptique["y"]
    }

def synoptiques_serail(synoptiques) -> list:
    return[get_synoptique_serial(synoptiques[synoptique]) for synoptique in synoptiques]

def get_csv_serial(csv) -> dict:
    return{
        "Question": csv["Question"],
        "A": csv["A"],
        "B": csv["B"],
        "C": csv["C"],
        "D": csv["D"],
        "Answer": csv["Answer"]
    }

def csv_serail(csvs) -> list:
    return[get_csv_serial(csvs[csv]) for csv in csvs]