#!/bin/bash -e

VERSION=$1
if [ "$VERSION" == "" ]; then
    echo "usage: add-version.sh VERSION"
    exit 1
fi

VERSION_NAME=`echo $VERSION | sed 's/.Final//' | sed 's/.CR[[:digit:]]//'`
DATE=`date +%F`

cat version-template.json | sed "s/VERSION/$VERSION/" | sed "s/DATE/$DATE/" > versions/$VERSION_NAME.json