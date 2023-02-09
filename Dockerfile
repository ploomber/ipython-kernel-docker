FROM continuumio/miniconda3

RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
    netcat

RUN conda install ipython ipykernel -c conda-forge -y

COPY entrypoint.sh entrypoint.sh

# At runtime, mount the connection file to /tmp/connection_file.json
# ENTRYPOINT [ "./entrypoint.sh"]
