IMAGE_NAME=python-kernel
env:
	conda create --name kernel-docker python=3.10 \
	 jupyterlab papermill -y -c conda-forge

build:
	docker build --rm -t ${IMAGE_NAME} .

install:
	jupyter kernelspec install --sys-prefix $(PWD)

test:
	./start-kernel.sh $(PWD)/sample_connection_file.json

run:
	jupyter console --kernel ipython-kernel-docker
