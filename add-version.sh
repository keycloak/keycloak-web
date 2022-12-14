#!/bin/bash -e

VERSION=$1
if [ "$VERSION" == "" ]; then
    echo "usage: add-version.sh VERSION"
    exit 1
fi

VERSION_NAME=`echo $VERSION | sed 's/.Final//' | sed 's/.CR[[:digit:]]//'`
DATE=`date +%F`

if [[ "$VERSION" == *".0" ]]; then 
    TEMPLATE="version-template.json"
else
    TEMPLATE="versions/${VERSION%.*}.0.json"
fi

if [ ! -f "$TEMPLATE" ]; then
    echo "$TEMPLATE not found"
    exit
fi

cat $TEMPLATE | sed "s/\"version\":.*/\"version\": \"$VERSION\",/" | sed 's/"date": ".*"/"date": "DATE"/' | sed "s/DATE/$DATE/" > versions/$VERSION_NAME.json

CURRENT=`cat pom.xml | grep '<version.keycloak>' | cut -d '>' -f 2 | cut -d '<' -f 1`
LATEST=`echo -e "$CURRENT\n$VERSION" | sort -V -r | head -n 1`

sed -i "s|<version.keycloak>$CURRENT</version.keycloak>|<version.keycloak>$LATEST</version.keycloak>|g" pom.xml

mvn install
