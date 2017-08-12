#!/bin/sh

SCRIPTFOLDER=$(dirname `readlink -f "$0"`)
DOCKERFOLDER=$(readlink -f $SCRIPTFOLDER/../)
port=$(cat $DOCKERFOLDER/conf/port)
server=${1:-mvdsv}
num=${2:-1}

[ "$server" != "mvdsv" ] && [ "$server" != "qtv" ] && [ "$server" != "qwfwd" ] && echo "Invalid server type (available: mvdsv, qtv, qwfwd)." && exit 1

ip=$(curl -s https://ifcfg.me/)
echo "Setting IP to $ip"
echo $ip > $DOCKERFOLDER/conf/ip

running=$(docker ps -a -f name=nquakesv-$server-\* --format "{{.ID}}")
[ "$running" != "" ] && {
  echo "* Stopping and removing old containers..."
  docker rm -f $running 2>/dev/null
}

echo "* Starting new containers..."
for i in `seq 1 ${num}`; do
  useport=$(($port + i - 1))
  docker run -d \
    -v $DOCKERFOLDER/conf:/etc/nquakesv \
    --network=host \
    --restart always \
    --name nquakesv-$server-$i \
    nquake/server-linux $server $useport
done
