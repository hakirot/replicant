
SHELL := /bin/bash
BUILD_SCRIPTS=http/skadoo.sh http/autologin.conf http/replicant.sh http/replicate.sh http/sub.sh http/nftables.conf http/sub2.sh http/oh-my-zsh.sh http/finalize.sh
BUILD_DIR=replicant
TAR_TARGET=replicant.tar.gz
SIGNATURE_TARGET=replicant.tar.gz.sig
CHECKSUM_TARGET=replicant.sha256
MASHURADO=mashurado
NODEUSER=gambit
NODE=node
NODETARGETPATH=/home/gambit

output-replicant/replicant:
	./setup.sh
	packer build replicant.pkr.hcl

archive:
	mkdir -p $(BUILD_DIR)
	cp $(BUILD_SCRIPTS) $(BUILD_DIR)
	tar -zcf $(TAR_TARGET) $(BUILD_DIR)
	sha256sum $(TAR_TARGET) > $(CHECKSUM_TARGET)

sign: archive
	gpg --detach-sign $(TAR_TARGET)

deploy: archive sign
	rsync --progress $(TAR_TARGET) $(NODEUSER)@$(NODE):$(NODETARGETPATH)
	rsync --progress $(CHECKSUM_TARGET) $(NODEUSER)@$(NODE):$(NODETARGETPATH)
	rsync --progress $(SIGNATURE_TARGET) $(NODEUSER)@$(NODE):$(NODETARGETPATH)
	cat $(CHECKSUM_TARGET)

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(TAR_TARGET) $(SIGNATURE_TARGET) $(CHECKSUM_TARGET)
