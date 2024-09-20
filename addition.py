from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/add', methods=['GET'])
def add():
    x = request.args.get('x', type=float)
    y = request.args.get('y', type=float)
    result = x + y
    return jsonify({"result": result})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
