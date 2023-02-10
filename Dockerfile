FROM continuumio/miniconda3

RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
    netcat

RUN conda install ipython ipykernel -c conda-forge -y
