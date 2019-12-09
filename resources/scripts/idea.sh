#!/bin/bash

set -e
set -x

DOWNLOAD_IDEA_VERSION=$IDEA_VERSION-no-jbr
wget https://download.jetbrains.com/idea/ideaIU-$DOWNLOAD_IDEA_VERSION.tar.gz
tar -xf ideaIU-$DOWNLOAD_IDEA_VERSION.tar.gz
rm ideaIU-$DOWNLOAD_IDEA_VERSION.tar.gz
mv idea-IU-* ~/idea-IU

cat <<'EOF' >>~/idea.sh
#!/bin/bash

set -e
set -x

IDEA_SETTINGS=".IntelliJIdea$IDEA_VERSION"
if [ ! -d "$IDEA_SETTINGS" ]; then
    if [ ! -z "$1" ]; then
        git clone $1 GIT_IDEA_SETTINGS
        sudo mv ~/GIT_IDEA_SETTINGS/ ~/$IDEA_SETTINGS
#        sudo chmod -R ugo+rwx $IDEA_SETTINGS
    fi
fi
cd $IDEA_SETTINGS

git pull

~/idea-IU/bin/idea.sh

rm -fr "$(find ./ -iname eval 2>/dev/null | grep -e \..*/config/eval)"
rm -fr "$(find ./ -iname *statistics* 2>/dev/null | grep -e \..*/config/.*\.xml)"
sed -i.bak '/evlsprt*/d' $(find ./ -iname 'other.xml' 2>/dev/null | grep -e \..*/config/options/other\.xml)
git add .
git commit -m 'update'
git push
EOF
chmod -R ugo+rwx ~/idea.sh
