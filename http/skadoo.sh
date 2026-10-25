#!/bin/bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

if [ -z ${CONTROL_PIPE+x} ] ; then
  CONTROL_PIPE="/tmp/load_pipe"
fi

send_pipe () {
  echo $1 > ${CONTROL_PIPE}
  sleep .2
}

send_pipe_wait () {
  nohup bash -c "sleep \"$1\"; echo -e $2 | tee -a ${CONTROL_PIPE}" &
  sleep .5
}

endbar() {
  echo "ARCHLINUX INSTALLED" > $CONTROL_PIPE
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

# loading bar needs a moment before CONTROL_PIPE starts polling
sleep 4

MOUNT_HOME=/mnt/home/${username}

send_pipe "2"
send_pipe "ArchInstall pauses after 5...4...3...2...1 while it sorts its mirrorlist. Remain composed .. it shall continue .."
send_pipe_wait "145" "Running ArchInstall for ${username}"
send_pipe_wait "162" "30"
sleep 1

archinstall --config user_configuration.json --creds user_credentials.json --silent 2>&1 > /tmp/skadoosh_log

send_pipe "+REPLICANT: ARCHINSTALL COMPLETE"
send_pipe "90"

echo -e "${GREEN}REPLICANT: Configuring autologin ${username} ..${RESET}"
mkdir /mnt/etc/systemd/system/getty@tty1.service.d/
mv autologin.conf /mnt/etc/systemd/system/getty@tty1.service.d/autologin.conf
echo -e "${GREEN}REPLICANT: Configuring root perms for ${username} ..${RESET}"
echo "${username} ALL=(ALL) NOPASSWD: ALL" > /mnt/etc/sudoers.d/00_${username}

send_pipe "95"
send_pipe "REPLICANT: Installing replicant build files .."
mv replicate.sh replicant.sh sub.sh nftables.conf /mnt/home/${username}/
cp /mnt/home/${username}/.bash_profile /mnt/home/${username}/.bash_profile.bak

send_pipe "98"
echo -e "${GREEN}REPLICANT: Configuring build file ownership for ${username} ..${RESET}"
echo "sudo chown ${username}:${username} replicate.sh replicant.sh sub.sh nftables.conf" >> ${MOUNT_HOME}/.bash_profile
echo "chmod +x replicate.sh replicant.sh sub.sh" >> ${MOUNT_HOME}/.bash_profile

echo -e "${GREEN}REPLICANT: Facilitating replicant reboot automation ..${RESET}"
cp -r ${HOME}/ncurses-loading-bar /mnt/home/${username}/
echo "cd ncurses-loading-bar" >> ${MOUNT_HOME}/.bash_profile
echo "make clean" >> ${MOUNT_HOME}/.bash_profile
echo "make" >> ${MOUNT_HOME}/.bash_profile
echo "cp ./loading-bar /home/${username}" >> ${MOUNT_HOME}/.bash_profile
echo "cd /home/${username}" >> ${MOUNT_HOME}/.bash_profile
echo "./loading-bar -d -E replicate.sh -H \"REPLICANT (2/3) BASE SYSTEM + DESKTOP SETUP\" -C \"environment ready\" -l /home/${username}/replicate_log" >> ${MOUNT_HOME}/.bash_profile
echo "logout" >> ${MOUNT_HOME}/.bash_profile
echo "[ -f \${HOME}/logout.sh ] && source \${HOME}/logout.sh || echo" >> ${MOUNT_HOME}/.bash_profile

sleep 1
send_pipe "99"
echo -e "${GREEN}REPLICANT: Preparing to reboot ..${RESET}"

seconds=6
while [ $seconds -gt 0 ]; do
  echo -e "${YELLOW}${seconds}${RESET}"
  sleep 1
  seconds=$((seconds - 1))
done

send_pipe "100"

cp /tmp/skadoosh_log /mnt/home/${username}
endbar
shutdown -r now
