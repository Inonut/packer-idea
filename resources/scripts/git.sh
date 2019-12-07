#!/bin/bash

set -e
set -x

sudo pacman -S --noconfirm git

cat <<EOF >>~/.gitconfig
[user]
	email = you@example.com
	name = Vagrant Dev
EOF