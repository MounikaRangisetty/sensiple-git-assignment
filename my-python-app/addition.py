from flask import Flask
from prometheus_client import start_http_server, Gauge
import random
import time

app = Flask(__name__)

# Create a metric to track availability
availability_metric = Gauge('app_availability', 'Availability of the app')

@app.route('/metrics')
def metrics():
    # Here you would return the actual metrics, for demo purposes, we simulate random availability
    availability_value = random.choice([0, 1])  # Randomly returns 0 or 1 for demo
    availability_metric.set(availability_value)
    return "Metrics updated", 200

if __name__ == '__main__':
    start_http_server(5000)  # Start the metrics server on port 5000
    app.run(host='0.0.0.0')   # Start the Flask app
