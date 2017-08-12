#!/bin/sh

SCRIPTFOLDER=$(dirname `readlink -f "$0"`)
DOCKERFOLDER=$(readlink -f $SCRIPTFOLDER/../)

docker build --tag nquake/server-linux $DOCKERFOLDER
