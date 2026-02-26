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

echo -e "${GREEN}FINALIZE.sh: Configuring ssh config ..${RESET}"
echo "Host github.com" > $HOME/.ssh/config
echo "  HostName github.com" >> $HOME/.ssh/config
echo "  User hakirot" >> $HOME/.ssh/config
echo "  IdentityFile ~/.ssh/hub" >> $HOME/.ssh/config

echo -e "${GREEN}FINALIZE.sh: Copying gitconfig ..${RESET}"
cp $HOME/git/d07f1135/.gitconfig $HOME

echo -e "${GREEN}FINALIZE.sh: Cloning more projects..${RESET}"
cd $HOME/git
git clone git@github.com:hakirot/zmk-config-corneview.git
git clone git@github.com:hakirot/site.git
cd site/
git remote add heroku https://git.heroku.com/boiling-dawn-79173.git
cd ..
git clone git@github.com:hakirot/replicant.git
git clone git@github.com:hakirot/operation-goldhawk.git
cd operation-goldhawk
git remote add heroku https://git.heroku.com/operation-goldhawk.git
cd ../

echo -e "${GREEN}FINALIZE.sh: Set proper remote urls ..${RESET}"
cd $HOME/.config/nvim
git remote set-url origin git@github.com:hakirot/neovim-config.git

cd $HOME/git/sara/
git remote set-url origin git@github.com:hakirot/sara

cd $HOME/git/suckless-hakirot/
git remote set-url origin git@github.com:hakirot/suckless-hakirot

cd $HOME/skps
git remote set-url origin git@github.com:hakirot/skps.git

cd $HOME/git/d07f1135
git remote set-url origin git@github.com:hakirot/d07f1135

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

echo -e "${GREEN}FINALIZE.sh: Decrypting notes..${RESET}"
cd $HOME/dox
git clone git@github.com:hakirot/N0735.git
gpg --quiet --batch --decrypt N0735/N0735 > out
tar -xvf out
rm -rf N0735 out

cd $HOME
SARA
