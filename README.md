# REPLICANT

Installs and configures a software development workstation for Arch, either
from a live Arch boot ISO or in this automated development repo using Packer.

This is an optimized software development workstation configured for writing
software around three vim-mapped tools: neovim, tmux, and dwm (plus utilities)

Being productive in this system requires knowledge of Suckless Software
(DWM, ST, DMENU), tmux, and neovim. Usage of this system without experience
with these systems is not recommended. The installed configuration files 
included in this system via the linked repositories are the only locations to
go to understand how to navigate this environment.

This project was created to save time installing my configuration on future
machines.

The following git repositories are pulled during installation:

- suckless-hakirot
- backup-configs
- nvim-config
- lualine-patch
- skps
- SARA CLI

SARA CLI, while installed, is not enabled by default.

## FEATURES

- Manually patched (and resolved) DWM provides extra features, mainly
interopability with polybar
- Complete NeoVim installation and configuration
- Dynamic system color configuration via pywal.
- Oh-my-zsh
- SARA CLI

## INSTALLATION

This repository is for local testing with a QEMU/KVM virtual environment and
Packer. To run a live installation, perform the following:

- From the first prompt within the Arch Live Boot Image, verify a web connection, then run:

    `curl cachecoyotes.com/replicate | bash`

cachecoyotes.com/replicate is a mirror for the install scripts served elsewhere.

## SYSTEM MODIFICATIONS

### nvim lualine
A modified version of theme '16 color' is used

Enjoy!
