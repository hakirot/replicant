#!/bin/bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

endbar() {
  flashes=9
  while [ $flashes -gt 0 ]; do
    echo "0" > $CONTROL_PIPE
    sleep .05
    echo "100" > $CONTROL_PIPE
    sleep .05
    flashes=$((flashes - 1))
  done
  sleep .5
  while pgrep loading-bar >/dev/null ; do
    echo "PIPE_END" > $CONTROL_PIPE
    echo "Still Running"
    sleep .25
  done
  rm -f $CONTROL_PIPE
  # Run post ops
}

if [ -z ${CONTROL_PIPE+x} ] ; then
  CONTROL_PIPE="/tmp/load_pipe"
fi

echo "10" > $CONTROL_PIPE

USER=${username}
MOUNT_HOME=/mnt/home/${USER}
echo "Installing Arch for ${USER}" > $CONTROL_PIPE
#archinstall --config user_configuration.json --creds user_credentials.json --silent
archinstall --config user_configuration.json --creds user_credentials.json 2>&1

echo "90" > $CONTROL_PIPE
echo "+REPLICANT: ARCHINSTALL COMPLETE" > $CONTROL_PIPE

echo -e "${GREEN}REPLICANT: Configuring autologin ${USER} ..${RESET}"
mkdir /mnt/etc/systemd/system/getty@tty1.service.d/
mv autologin.conf /mnt/etc/systemd/system/getty@tty1.service.d/autologin.conf
echo -e "${GREEN}REPLICANT: Configuring root perms for ${USER} ..${RESET}"
echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /mnt/etc/sudoers.d/00_${USER}

echo "95" > $CONTROL_PIPE
echo -e "${GREEN}REPLICANT: Installing automated build files ..${RESET}"
mv replicate.sh replicant.sh sub.sh sub2.sh nftables.conf oh-my-zsh.sh /mnt/home/${USER}/
cp /mnt/home/${USER}/.bash_profile /mnt/home/${USER}/.bash_profile.bak

echo "98" > $CONTROL_PIPE
echo -e "${GREEN}REPLICANT: Configuring build file ownership for ${USER} ..${RESET}"
echo "sudo chown ${USER}:${USER} replicate.sh replicant.sh sub.sh sub2.sh nftables.conf oh-my-zsh.sh" >> ${MOUNT_HOME}/.bash_profile
echo "chmod +x replicate.sh replicant.sh sub.sh sub2.sh oh-my-zsh.sh" >> ${MOUNT_HOME}/.bash_profile
echo "source ./replicate.sh" >> ${MOUNT_HOME}/.bash_profile

sleep 1
echo "99" > $CONTROL_PIPE
echo -e "${GREEN}REPLICANT: Preparing to reboot ..${RESET}"

seconds=6
while [ $seconds -gt 0 ]; do
  echo -e "${YELLOW}${seconds}${RESET}"
  sleep 1
  seconds=$((seconds - 1))
done

echo "100" > $CONTROL_PIPE
endbar

shutdown -r now
