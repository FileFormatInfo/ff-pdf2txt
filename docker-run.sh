#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

docker build -t ff-pdf2txt:latest .
docker run -p 4000:8080 ff-pdf2txt:latest
