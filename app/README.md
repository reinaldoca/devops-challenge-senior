# SimpleTimeService

A minimal Python Flask microservice that returns the current timestamp and requester's IP in JSON format.

## Local Test

```bash
pip install flask
python main.py
```

## Docker

```bash
docker build -t simpletimeservice .
docker run -p 5000:5000 simpletimeservice
```
