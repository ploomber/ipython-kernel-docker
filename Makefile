IMAGE_NAME=python-kernel
build:
	docker build --rm -t ${IMAGE_NAME} .

install:
	jupyter kernelspec install --sys-prefix $(PWD)

test:
	./start-kernel.sh $(PWD)/sample_connection_file.json

run:
	jupyter console --kernel ipython-kernel-docker
