#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=blueimage

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login --username msdhillon --password Kid@an011
docker tag blueimage msdhillon/blueimage
# Step 3:
# Push image to a docker repository
docker push msdhillon/blueimage
