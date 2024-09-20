from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/add', methods=['GET'])
def add():
    x = request.args.get('x', type=float)
    y = request.args.get('y', type=float)
    
    if x is None or y is None:
        return jsonify({"error": "Missing parameters x or y"}), 400

    result = x + y
    return jsonify({"result": result})

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy"}), 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)  # Update port to match EXPOSE
