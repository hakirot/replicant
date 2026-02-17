# REPLICANT

This is an ArchInstall wrapper that provisions a custom software development
workstation for Arch from the initial boot ISO, configuring DWM, tmux, zsh,
nvim, st, polybar, sara, and more. This is my terminal-oriented daily driver
config, and saves time whenever I build new PCs and replace storage devices,
which, apparently, is often enough.

This repository is for local development of provisioning code, testing the
install with a QEMU/KVM virtual machine with Packer.

## FEATURES

- Manually patched DWM provides extra features, mainly
interopability with polybar
- Complete NeoVim configuration
- Dynamic system color configuration via pywal.
- Oh-my-zsh
- SARA CLI
- .. and more.

## INSTALLATION

To run a live installation, one would simply boot into the live arch boot ISO,
generate their arch install config files (by saving and exiting, NOT running
archinstall), and then running the following command with their generated
config files from archinstall.

    `curl -fsSL https://cachecoyotes.com/replicant | bash`
  
Hands off the keyboard until it's done.
