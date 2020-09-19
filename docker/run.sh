#!/bin/bash
docker run \
    --init \
    --rm \
    -it \
    --ipc=host \
    -p 5000:5000 \
    --name=$(basename $PWD) \
    --env-file=.env \
    --volume=$PWD:/workspace \
    --volume=$DATASET:/dataset \
    pytorch_flask_test:latest \
    ${@-fish}
