#!/bin/bash -e

VERSION=$1
if [ "$VERSION" == "" ]; then
    echo "usage: add-version.sh VERSION"
    exit 1
fi

VERSION_NAME=`echo $VERSION | sed 's/.Final//' | sed 's/.CR[[:digit:]]//'`
DATE=`date +%F`

cat version-template.json | sed "s/VERSION/$VERSION/" | sed "s/DATE/$DATE/" > versions/$VERSION_NAME.json


CURRENT=`cat pom.xml | grep '<version.keycloak>' | cut -d '>' -f 2 | cut -d '<' -f 1`
LATEST=`echo -e "$CURRENT\n$VERSION" | sort -V -r | head -n 1`

sed -i "s|<version.keycloak>$CURRENT</version.keycloak>|<version.keycloak>$LATEST</version.keycloak>|g" pom.xml

