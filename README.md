# REPLICANT

This is an ArchInstall wrapper that provisions a custom software development
workstation for Arch from the initial boot ISO, configuring DWM, tmux, zsh,
nvim, st, polybar, sara, dunst,  and more. This is my daily driver config,
and saves time whenever I build new PCs and replace storage devices, which,
apparently, is often enough.

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

To run a live installation, after booting into the live arch boot ISO,
generate arch install config files by saving and exiting the archinstall menu.
Do not just run archinstall. You must configure a non-root user for this
install. It is also recommended to copy your ISO network config in the network
options, to prevent a stoppage when more package installations are attempted
after rebooting into your arch linux installation.

This command will run the production version of this codebase. A prompt for
continuation will occur after all required artifacts are retrieved, so you
may inspect the files.

    `sh -c "$(curl -fsSL https://hakipaks.org/replicant/start)"`
