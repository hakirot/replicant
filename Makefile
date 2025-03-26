# Makefile #
SHELL := /bin/bash

replicant: output-arch-base/arch-base
	packer build replicant.pkr.hcl

base:
	./setup.sh
	packer build base.pkr.hcl

clean:
	rm -rf output-sara
