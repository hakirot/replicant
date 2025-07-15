# REPLICANT

Replicates my workstation from a raw install on any compatible hardware or
virtual machine, for the purpose of having a productive environment for
software development. This is my personal Linux desktop that I use for my
purposes, thus, I do not recommend anyone try to use this configuration for
their own software development journey. The code available here is meant for
my use only, and the code here is presented for demonstration purposes only.

This is an optimized software development workstation configured for writing
software around three vim-mapped tools: neovim, tmux, and dwm (plus utilities).
It also includes some subtle optimizations that I find helpful for use with
my custom corne keymaps.

Being productive in this system requires knowledge of Suckless Software
(DWM, ST, DMENU), tmux, and neovim. Usage of this system without experience
with the softare is not recommended. The installed configuration files
included in this project, as well as those pulled from other repositories
during the execution of these scripts, are the only locations to
go to understand how to navigate this environment. There is no manual, and is
constantly being updated to navigate my wavering opinions.

This project was created simply to save time installing my configuration across
various machines.

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

This repository is for local testing only with a a QEMU/KVM virtual environment
and Packer. To run a live installation, you would simply boot a machine from
a live Arch Linux boot ISO and run the install scripts from my website, as I
do:

- From the first prompt within the Arch Live Boot Image, configure a web
connection and run:

    `curl cachecoyotes.com/replicate | bash`

cachecoyotes.com/replicate is a mirror for the install scripts served elsewhere.

## SYSTEM MODIFICATIONS

## APPLICATION MODIFICATIONS

### nvim lualine
A modified version of theme '16 color' is used

Enjoy!
