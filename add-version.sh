#!/bin/bash -e

VERSION=$1
if [ "$VERSION" == "" ]; then
    echo "usage: add-version.sh VERSION"
    exit 1
fi

VERSION_NAME=`echo $VERSION | sed 's/.Final//' | sed 's/.CR[[:digit:]]//'`
NEWS_NAME=`date +%F`

sed "s/VERSION/$VERSION/" src/web/version-template.json > src/web/versions/$VERSION_NAME.json
sed "s/VERSION/$VERSION/" src/web/news-template.json > src/web/news/$NEWS_NAME.json


