# REPLICANT

Provisions a software development workstation for Arch from the initial boot ISO, configuring DWM, tmux,
zsh, nvim, st, polybar, sara, and others. This is my daily driver config, and
saves time whenever I build new PCs, which, apparently, is often enough.

## FEATURES

- Manually patched (and resolved) DWM provides extra features, mainly
interopability with polybar
- Complete NeoVim configuration
- Dynamic system color configuration via pywal.
- Oh-my-zsh
- SARA CLI
- .. and many others. Just read the code.

## INSTALLATION

This repository is for local development of provisioning code, with a QEMU/KVM
virtual environment and Packer. To run a live installation, you would simply
boot a machine from a live Arch Linux boot ISO and run the install scripts from
my website:

- From the first prompt within the Arch Live Boot Image, configure a web
connection and run:

    `curl cachecoyotes.com/replicant | bash`
  
Enjoy.
