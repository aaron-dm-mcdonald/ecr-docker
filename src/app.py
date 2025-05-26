from flask import Flask, jsonify
from aws_lambda_wsgi import response

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify(message="Hello from Flask on Lambda!")

def lambda_handler(event, context):
    return response(app, event, context)
