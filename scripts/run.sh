#!/bin/sh

SCRIPTFOLDER=$(dirname `readlink -f "$0"`)
DOCKERFOLDER=$(readlink -f $SCRIPTFOLDER/../)
port=$(cat $DOCKERFOLDER/conf/docker-port)
server=${1:-mvdsv}
num=${2:-1}

ip=$(curl -s https://ifcfg.me/)
echo "Setting IP to $ip"
echo $ip > $DOCKERFOLDER/conf/ip

echo "* Removing old containers..."
docker rm -f `docker ps -a -f name=nquakesv-\* --format "{{.ID}}"`

echo "* Starting new containers..."
for i in `seq 1 ${num}`; do
  useport=$(($port + i - 1))
  docker run -d \
    -v $DOCKERFOLDER/conf:/etc/nquakesv \
    --expose $useport \
    -p $useport:$useport \
    --restart always \
    --name nquakesv-$i \
    nquake/server-linux $server $useport
done
