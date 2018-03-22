#!/bin/bash -e

VERSION=$1
if [ "$VERSION" == "" ]; then
    echo "usage: add-version.sh VERSION"
    exit 1
fi

VERSION_NAME=`echo $VERSION | sed 's/.Final//' | sed 's/.CR[[:digit:]]//'`
NEWS_NAME=`date +%F`

sed "s/VERSION/$VERSION/" src/main/resources/version-template.json > src/main/resources/versions/$VERSION_NAME.json
sed "s/VERSION/$VERSION/" src/main/resources/news-template.json > src/main/resources/news/$NEWS_NAME.json


