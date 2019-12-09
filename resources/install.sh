#!/bin/bash

set -e
set -x

sudo pacman -Sy --noconfirm base-devel bash-completion nano tar wget icu jq ncdu xorg noto-fonts unzip
~/resources/scripts/git.sh
~/resources/scripts/java.sh
~/resources/scripts/keyrings.sh
~/resources/scripts/idea.sh
~/resources/scripts/docker.sh
~/resources/scripts/flutter.sh
~/resources/scripts/android-emulator.sh
