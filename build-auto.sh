#!/bin/bash

OPTS=$1

while true; do 
    inotifywait -r -e modify,move,create,delete src --format %w
    mvn exec:java
done
