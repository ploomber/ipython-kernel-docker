#!/bin/bash

if [ $# -lt 1 ]; then
    connection_file=/connection-file.json
else
    connection_file=$1
fi

cat $connection_file

# Modify the damn connection file to use proper IP address now
# sed -i 's;127.0.0.1;0.0.0.0;' ${connection_file}

echo 1

# --ip=0.0.0.0 
python3 -m ipykernel_launcher -f $connection_file --log-level DEBUG
