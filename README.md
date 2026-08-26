# REPLICANT

This is the dev repo for [Replicant](https://www.hakipaks.com/replicant): a build archive for a lightweight desktop in Arch.

This dev repo runs an autonomous build through Packer. The Packer QEMU is required, as well as a provider for the qemu-system-x86_64 binary.

Clone the repo and observe an Arch Linux desktop environment build via make

The build reaches a timeout after 120 minutes, if you want to keep the image, just run this in a terminal inside the virtual machine

    sudo systemctl start sshd
