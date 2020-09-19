import requests


response = requests.post('http://127.0.0.1:5000/predict', files=dict(file=open('test/dog.png', 'rb')))

print(response.text)
