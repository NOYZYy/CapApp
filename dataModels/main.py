from fastapi import FastAPI
from routes.route import router
from routes.systemroute import systemrouter
from routes.composantroute import composantrouter
from routes.pdfsroute import pdfsrouter
from routes.synoptiqueroute import synoptiquerouter
from routes.csvroute import csvrouter

app = FastAPI()

app.include_router(router)
app.include_router(systemrouter)
app.include_router(composantrouter)
app.include_router(pdfsrouter)
app.include_router(synoptiquerouter)
app.include_router(csvrouter)