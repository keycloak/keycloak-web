#!/bin/bash -e

VERSION=$1
ID=${2:-'keycloak'}

if [ "$VERSION" == "" ]; then
    echo "usage: add-version.sh VERSION [ID]"
    exit 1
fi

VERSION_NAME=`echo $VERSION | sed 's/.Final//' | sed 's/.CR[[:digit:]]//'`
DATE=`date +%F`

if [[ "$VERSION" == *".0" ]]; then
    TEMPLATE="version-template-$ID.json"
else
    TEMPLATE_0="versions/$ID/${VERSION%.*}.0.json"
    if [[ -f $TEMPLATE_0 ]]; then
        TEMPLATE=$TEMPLATE_0
    else
        TEMPLATE="version-template-$ID.json"
    fi
fi

if [ ! -f "$TEMPLATE" ]; then
    echo "Template $TEMPLATE not found"
    exit
fi

cat $TEMPLATE | sed "s/\"version\":.*/\"version\": \"$VERSION\",/" | sed 's/"date": ".*"/"date": "DATE"/' | sed "s/DATE/$DATE/" > versions/$ID/$VERSION_NAME.json

CURRENT=`cat pom.xml | grep "<version.$ID>" | cut -d '>' -f 2 | cut -d '<' -f 1`
LATEST=`echo -e "$CURRENT\n$VERSION" | sort -V -r | head -n 1`

mvn versions:set-property -Dproperty=version.$ID -DnewVersion=$LATEST -DgenerateBackupPoms=false
mvn install
