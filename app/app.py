import datetime
import random
from flask import Flask
from flask import jsonify
from app.config import APP_CONFIG
from app.utils.logger import get_logs

def init_routes(app):
    @app.route('/')
    def home():
        return jsonify({"message": "Welcome to the DevOps Flask App!"})
    
    @app.route('/health')
    def health_check():
        return jsonify({"status": "✅ Healthy", "timestamp": str(datetime.datetime.now(datetime.timezone.utc))})


    @app.route('/api/users')
    def get_users():
        users = [
            {"id": 1, "name": "Abdurahim", "role": "DevOps Engineer"},
            {"id": 2, "name": "Jack", "role": "AI Engineer"}
        ]
        return jsonify(users)

    @app.route('/api/metrics')
    def get_metrics():
        metrics = {
            "cpu_usage": f"{random.randint(10, 90)}%",
            "memory_usage": f"{random.randint(1024, 8192)} MB",
            "active_containers": random.randint(1, 10),
            "last_updated": str(datetime.datetime.now(datetime.timezone.utc))

        }
        return jsonify(metrics)

    @app.route('/api/logs')
    def get_system_logs():
        logs = get_logs()
        return jsonify({"logs": logs})

    @app.route('/api/config')
    def get_config():
        return jsonify(APP_CONFIG)
    
app = Flask(__name__)
init_routes(app)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)

