#!/bin/bash

set -e
set -x

DOWNLOAD_IDEA_VERSION=$IDEA_VERSION-no-jbr
wget https://download.jetbrains.com/idea/ideaIU-$DOWNLOAD_IDEA_VERSION.tar.gz
tar -xf ideaIU-$DOWNLOAD_IDEA_VERSION.tar.gz
rm ideaIU-$DOWNLOAD_IDEA_VERSION.tar.gz
mv idea-IU-* ~/idea-IU

cp ~/resources/scripts/startup.sh ~/idea.sh
chmod -R ugo+rwx ~/idea.sh
