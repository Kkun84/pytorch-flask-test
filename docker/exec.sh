#!/bin/bash
docker exec -it $(basename $PWD) ${@-fish}
