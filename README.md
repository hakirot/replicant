# REPLICANT

Installs and configures an entire software development workstation in a single
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
- lualine-patch
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
Packer. To run a live installation, perform the following:

- From the first prompt within the Arch Live Boot Image, verify a web connection, then run:

    curl cachecoyotes.com/replicate | bash

cachecoyotes.com/replicate is a mirror to the automated install scripts currently hosted by Akamai.

Enjoy!
