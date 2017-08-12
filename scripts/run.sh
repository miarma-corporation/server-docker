#!/bin/sh

SCRIPTFOLDER=$(dirname `readlink -f "$0"`)
DOCKERFOLDER=$(readlink -f $SCRIPTFOLDER/../)
port=$(cat $DOCKERFOLDER/conf/docker-port)

docker rm -f nquakesv
#docker run -d -v $DOCKERFOLDER/conf:/etc/nquakesv --expose $port -p $port:$port --restart always --name nquakesv nquake/server-linux
docker run -d -v $DOCKERFOLDER/conf:/etc/nquakesv --network=host --restart always --name nquakesv nquake/server-linux
