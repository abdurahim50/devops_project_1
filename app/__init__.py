from flask import Flask
from .config import APP_CONFIG
from .utils.logger import get_logs
from .app import init_routes  # corrected import: init_routes is in app/app.py


def create_app():
    """Application factory for Flask (used by pytest and WSGI servers)."""
    app = Flask(__name__)
    # load any config dict
    app.config.update(APP_CONFIG)
    init_routes(app)
    return app