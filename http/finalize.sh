#!/usr/bin/env bash

set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

echo
cat $HOME/.ssh/hub.pub
echo

read -p "Attach this public key to github, then press 'y': " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo -e "${GREEN}Continuing ..${RESET}"
else
  echo -e "${RED}Aborted.${RESET}"
  exit 0
fi

echo -e "${GREEN}FINALIZE.sh: Configuring PSHD ..${RESET}"
mkdir -p $HOME/.config/pshd

echo "/home/username/.config/nvim" > $HOME/.config/pshd/dir
echo "/home/username/git/suckless-hakirot" >> $HOME/.config/pshd/dir
echo "/home/username/pix/walls" >> $HOME/.config/pshd/dir
echo "/home/username/skps/custom_walz" >> $HOME/.config/pshd/dir
echo "/home/username/.config" >> $HOME/.config/pshd/dir
echo "/home/username/git/site" >> $HOME/.config/pshd/dir
echo "/home/username/git/sara" >> $HOME/.config/pshd/dir
echo "/home/username/pix/sara" >> $HOME/.config/pshd/dir
echo "/home/username/dox/.notes" >> $HOME/.config/pshd/dir
echo "/home/username/skps" >> $HOME/.config/pshd/dir
echo "/home/username/git/d07f1135" >> $HOME/.config/pshd/dir
echo "/home/username/git/replicant" >> $HOME/.config/pshd/dir
echo "/home/username/test/c" >> $HOME/.config/pshd/dir
echo "/home/username/git/zmk-config-corneview" >> $HOME/.config/pshd/dir

# git remote set-url origin <ssh repo name>
