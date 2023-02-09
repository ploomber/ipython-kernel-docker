#!/bin/bash

set -e

if [ $# -lt 1 ]; then
    echo "Missing the connection file as first parameter"
    exit 1
fi

# Script settings
DOCKER_IMAGE=python-kernel

# This thing should be a full path by Jupyter
connection_file=$1

# Get the port number out
# Here we assume the local machine has JQ installed
SHELL_PORT=$(jq '.shell_port' < $connection_file)
IOPUB_PORT=$(jq '.iopub_port' < $connection_file)
STDIN_PORT=$(jq '.stdin_port' < $connection_file)
CONTROL_PORT=$(jq '.control_port' < $connection_file)
HB_PORT=$(jq '.hb_port' < $connection_file)

sed -i.bu 's;127.0.0.1;0.0.0.0;' "${connection_file}"

echo CONN FILE
cat $connection_file

# looks like network=host won't work on docker desktop
# https://docs.docker.com/network/network-tutorial-host/#procedure

# dockernel is another alternative: https://stackoverflow.com/a/63715102/709975

# Run docker image with the connection file mounted in, and ports forwarded
docker run  --rm \
    -v $connection_file:/connection-file.json \
    -p $CONTROL_PORT:$CONTROL_PORT \
    -p $SHELL_PORT:$SHELL_PORT \
    -p $STDIN_PORT:$STDIN_PORT \
    -p $HB_PORT:$HB_PORT \
    -p $IOPUB_PORT:$IOPUB_PORT \
    --memory=100m \
    $DOCKER_IMAGE \
    python -m ipykernel_launcher -f /connection-file.json --logfile /kernel.log -ip 0.0.0.0 --log-level DEBUG
