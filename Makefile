# Makefile #
SHELL := /bin/bash

replicant: output-arch-base/arch-base
	packer build replicant.pkr.hcl

output-arch-base/arch-base:
	./setup.sh
	packer build base.pkr.hcl

clean:
	rm -rf output-sara
