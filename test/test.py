import requests


response = requests.post(
    "https://flask-pytorch-test.herokuapp.com/predict",
    files=dict(image=open("test/dog.png", "rb")),
)
print(response.text)

response = requests.post(
    "http://127.0.0.1:5000/predict", files=dict(image=open("test/dog.png", "rb"))
)
print(response.text)
