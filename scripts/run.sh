#!/bin/sh

SCRIPTFOLDER=$(dirname `readlink -f "$0"`)
DOCKERFOLDER=$(readlink -f $SCRIPTFOLDER/../)
port=$(cat $DOCKERFOLDER/conf/docker-port)

ip=$(curl -s https://ifcfg.me/)
echo "Setting IP to $ip"
echo $ip > $DOCKERFOLDER/conf/ip

echo -n "Removing old container: "
docker rm -f nquakesv

echo -n "Starting container: "
docker run -d -v $DOCKERFOLDER/conf:/etc/nquakesv --network=host --restart always --name nquakesv nquake/server-linux
