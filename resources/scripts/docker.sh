#!/bin/bash

set -e
set -x

sudo pacman -S --noconfirm docker

sudo systemctl enable --now docker.service