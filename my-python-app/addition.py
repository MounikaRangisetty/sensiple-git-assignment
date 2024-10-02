from flask import Flask
from prometheus_client import start_http_server, Summary, Counter, Gauge, generate_latest

app = Flask(__name__)

# Example metrics
REQUESTS = Counter('http_requests_total', 'Total HTTP Requests')
IN_PROGRESS = Gauge('inprogress_requests', 'In Progress Requests')
LATENCY = Summary('request_latency_seconds', 'Request Latency')

@app.route('/')
def index():
    REQUESTS.inc()  # Increment total HTTP requests count
    with IN_PROGRESS.track_inprogress():  # Track in-progress requests
        return "Hello, World!"

@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': 'text/plain'}

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    # Start Prometheus metrics HTTP server
    start_http_server(8000)  # Expose Prometheus metrics on port 8000
    app.run(host='0.0.0.0', port=4000)  # Run Flask app on port 6000
