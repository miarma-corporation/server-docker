#!/bin/sh

SCRIPTFOLDER=$(dirname `readlink -f "$0"`)
DOCKERFOLDER=$(readlink -f $SCRIPTFOLDER/../)

echo "/nquakesv" > $DOCKERFOLDER/conf/install_dir
echo 1 > $DOCKERFOLDER/conf/docker

docker build --tag nquake/server-linux $DOCKERFOLDER
