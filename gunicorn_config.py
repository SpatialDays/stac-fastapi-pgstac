"""gunicorn WSGI server configuration."""
from multiprocessing import cpu_count

def max_workers():    
    return cpu_count()

bind = '0.0.0.0:8082'
worker_class = 'uvicorn.workers.UvicornWorker'
workers = max_workers()