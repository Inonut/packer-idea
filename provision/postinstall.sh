#!/bin/bash

set -e
set -x

# setting hostname, locales, etc
hostnamectl set-hostname "archlinux"
localectl set-keymap "us"
timedatectl set-ntp true

# setting link to systemd-resolved
ln -sf /var/run/systemd/resolve/resolv.conf /etc/resolv.conf

# enable x11 forwarding
cat <<EOF >>/etc/ssh/sshd_config
AllowAgentForwarding yes
X11Forwarding yes
X11UseLocalhost yes
EOF
cat <<EOF >>.xinitrc
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh
EOF
sudo systemctl restart sshd

# allow multilib
cat <<EOF >>/etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
sudo pacman -Sy

# custom commands
cat <<EOF >>.bashrc
alias ll="ls -al --color"

export PS1="\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$ \[\033[00m\]"
EOF

# set env
cat <<EOF >>.bash_profile
export IDEA_VERSION=$IDEA_VERSION
EOF