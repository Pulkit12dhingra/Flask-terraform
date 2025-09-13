"""A simple Flask web application with a hello world route."""

from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello():
    """Simple hello world route"""
    return "Hello, World from Flask!"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
