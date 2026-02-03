# REPLICANT

Provisions a software development workstation for Arch, configuring DWM, tmux,
zsh, nvim, st, polybar, sara, and others. This is my daily driver config, and
saves time when I build new PCs.

## FEATURES

- Manually patched (and resolved) DWM provides extra features, mainly
interopability with polybar
- Complete NeoVim installation and configuration
- Dynamic system color configuration via pywal.
- Oh-my-zsh
- SARA CLI

## INSTALLATION

This repository is for local development of provisioning code, with a QEMU/KVM
virtual environment and Packer. To run a live installation, you would simply
boot a machine from a live Arch Linux boot ISO and run the install scripts from
my website:

- From the first prompt within the Arch Live Boot Image, configure a web
connection and run:

    `curl cachecoyotes.com/replicant | bash`

cachecoyotes.com/replicate is a mirror for the install scripts served elsewhere.

