#!/bin/bash

set -e
set -x

FLATTER_VERSION=v1.9.1+hotfix.6-stable
wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_$FLATTER_VERSION.tar.xz
tar xf flutter_linux_$FLATTER_VERSION.tar.xz
rm flutter_linux_$FLATTER_VERSION.tar.xz