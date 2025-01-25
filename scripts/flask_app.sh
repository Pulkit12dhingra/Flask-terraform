#!/bin/bash

# Update and install necessary packages
yum update -y
yum install -y python3 docker

# Start the Docker service
service docker start

# Create the Flask app directory
mkdir -p /app

# Create the Flask app file
cat <<EOT > /app/app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, World from Flask running on EC2!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOT

# Create a Dockerfile for the Flask app
cat <<EOT > /app/Dockerfile
FROM python:3.8-slim

WORKDIR /app

COPY app.py /app

RUN pip install flask

EXPOSE 5000

CMD ["python", "app.py"]
EOT

# Navigate to the app directory
cd /app

# Build and run the Docker container
docker build -t flask-app .
docker run -d -p 5000:5000 flask-app
