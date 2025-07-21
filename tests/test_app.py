
import pytest
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from app import create_app

@pytest.fixture
def client():
    app = create_app()
    app.testing = True
    return app.test_client()

def test_health(client):
    res = client.get('/health')
    assert res.status_code == 200
    assert res.json['status'] == "✅ Healthy"

def test_users(client):
    res = client.get('/api/users')
    assert res.status_code == 200
    assert isinstance(res.json, list)
    assert len(res.json) == 2

def test_metrics(client):
    res = client.get('/api/metrics')
    assert res.status_code == 200
    assert 'cpu_usage' in res.json

def test_logs(client):
    res = client.get('/api/logs')
    assert res.status_code == 200
    assert 'logs' in res.json

def test_config(client):
    res = client.get('/api/config')
    assert res.status_code == 200
    assert 'version' in res.json
