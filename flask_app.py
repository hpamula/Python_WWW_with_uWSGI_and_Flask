from flask import Flask
from sys import version

app = Flask(__name__)

@app.route("/")
def flask_app():
    return "Hello uWSGI from pythos n version: <br>" + version