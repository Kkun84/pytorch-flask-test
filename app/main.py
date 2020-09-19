import json
from flask import Flask, request, jsonify

from app.torch_utils import transform_image, get_prediction


app = Flask(__name__)


with open('app/imagenet_class_index.json', mode='r') as f:
    labels = json.load(f)
    labels = {key: value[1] for key, value in labels.items()}


ALLOWED_EXTENTIONS = {'png', 'jpg', 'jpeg'}
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENTIONS


def main_post():
    file = request.files.get('file')
    if file is None or file.filename == '':
        return jsonify(dict(error='no file'))
    if not allowed_file(file.filename):
        return jsonify(dict(error='format not supported'))
    try:
        image_bytes = file.read()
        image_tensor = transform_image(image_bytes)
        probability, prediction = get_prediction(image_tensor)
        data = dict(probability=probability.item(), prediction=labels[str(prediction.item())])
        return jsonify(data)
    except:
        return jsonify(dict(error='error during prediction'))

@app.route('/predict', methods=['POST'])
def main():
    if request.method == 'POST':
        return main_post()


if __name__ == '__main__':
    app.run()
