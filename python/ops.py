from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/add')
def add():
    x = float(request.args.get('x', 0))
    y = float(request.args.get('y', 0))
    return jsonify(result=x + y)

@app.route('/subtract')
def subtract():
    x = float(request.args.get('x', 0))
    y = float(request.args.get('y', 0))
    return jsonify(result=x - y)

@app.route('/multiply')
def multiply():
    x = float(request.args.get('x', 0))
    y = float(request.args.get('y', 0))
    return jsonify(result=x * y)

@app.route('/divide')
def divide():
    x = float(request.args.get('x', 1))
    y = float(request.args.get('y', 1))
    if y == 0:
        return jsonify(error="Division by zero is not allowed"), 400
    return jsonify(result=x / y)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
