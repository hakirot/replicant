# REPLICANT

This is the dev repo for [Replicant](https://www.hakipaks.org/replicant), a build archive for a lightweight desktop in Arch.

This dev repo runs an autonomous build through Packer. The Packer QEMU plugin is required, as well as a provider for the qemu-system-x86_64 binary. Clone this repo, install dependencies, and run make to observe the Arch Linux desktop environment build completely autonomously

The development setup and workflow on Arch Linux would be

    pacman -S packer qemu-full
    git clone https://github.com/hakirot/replicant.git
    cd replicant
    packer plugins install github.com/hashicorp/qemu
    make
    

The dev build reaches a timeout after 120 minutes to provide time for test inspection. To save the image as a virtual disk, packer simply waits for an SSH connection, therefore run this from a terminal inside the virtual guest machine to complete the build.

    sudo systemctl start sshd

See the included bin/ directory for some convenient scripts to run the completed build outside of packer

To run the live release of this project and build this desktop on live/host hardware, visit [hakipaks](https://hakipaks.org/replicant)
