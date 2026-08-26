# REPLICANT

This is the dev repo for [Replicant](https://www.hakipaks.com/replicant), a build archive for a lightweight desktop in Arch.

This dev repo runs an autonomous build through Packer. The Packer QEMU plugin is required, as well as a provider for the qemu-system-x86_64 binary. Clone the repo and observe an Arch Linux desktop environment build via make

The full setup and workflow on Arch would be

    git clone https://github.com/hakirot/replicant.git
    cd replicant
    pacman -S packer qemu-full
    packer plugins install github.com/hashicorp/qemu
    make
    

The build reaches a timeout after 120 minutes, to provide time for inspection. To save the image, run this from a terminal inside the virtual machine, build will complete.

    sudo systemctl start sshd

See the bin/ directory for running the machine outside of packer
