#!/bin/bash

set -e
set -x

sudo pacman -S --noconfirm libsecret gnome-keyring

wget https://gitlab.com/GrantMoyer/lssecret/-/archive/master/lssecret-master.tar.gz
tar -xf lssecret-master.tar.gz
rm lssecret-master.tar.gz
sudo make -C lssecret-master install
sudo rm -fr lssecret-master/

# config keyrings
mkdir -p ~/.local/share/keyrings
cp -r ~/resources/keyrings ~/.local/share/