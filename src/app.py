from flask import Flask
from mangum import Mangum

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from inside Lambda container!"

handler = Mangum(app)  # Wrap Flask app for Lambda
