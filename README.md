# REPLICANT

Installs and configures my entire software development workstation in a single
command from the Arch Boot ISO. This is an optimized software development
workstation continuously designed to present information and perform
common tasks as quickly as possible.

Being productive in this system requires basic knowledge of Suckless Software
(DWM, ST, DMENU), tmux, and neovim. The installed configuration files are the
best places to observe it's behavior.

The following git repositories are pulled during installation:

- suckless-hakirot
- backup-configs
- nvim-config
- skps
- SARA CLI

SARA CLI, while installed, is not enabled by default.

## FEATURES

- Patched DWM and ST provide extra features
- Complete NeoVim installation and configuration
- Dynamic system color configuration via pywal.
- Oh-my-zsh
- SARA CLI

## INSTALLATION

This repository is for local testing with a QEMU/KVM virtual environment and
Packer. To run the live installation, run the following steps:

    - From the first prompt within the Arch Live Boot Image, configure a connection to the web, then run:

    curl cachecoyotes.com/replicate | bash

cachecoyotes.com/replicate is a mirror to the release currenlty hosted by Akamai.

Enjoy!

