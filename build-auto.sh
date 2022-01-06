#!/bin/bash

OPTS=$1

while true; do 
    inotifywait -r -e modify,move,create,delete . --format %w
    mvn install
done
