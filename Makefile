# Makefile #
SHELL := /bin/bash

sarapack:
	./setup.sh
	packer build .

clean:
	rm -rf output-sara
