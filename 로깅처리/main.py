import logging
from datetime import datetime
from logging.handlers import SysLogHandler

from fastapi import FastAPI

log = logging.getLogger('demo')
log.setLevel(logging.DEBUG)
handler = SysLogHandler(address='/dev/log',
        facility=SysLogHandler.LOG_LOCAL7)
handler.setFormatter(logging.Formatter('hello: %(message)s'))
log.addHandler(handler)

app = FastAPI()


@app.get("/")
def read_root():
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    log.debug('[{}] Hello World'.format(current_time))
    return {"Hello": "World"}
