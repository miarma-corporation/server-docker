#!/bin/sh

SCRIPTFOLDER=$(dirname `readlink -f "$0"`)
DOCKERFOLDER=$(readlink -f $SCRIPTFOLDER/../)
mvdsvport=$(cat $DOCKERFOLDER/conf/port-mvdsv)
qtvport=$(cat $DOCKERFOLDER/conf/port-qtv)
qwfwdport=$(cat $DOCKERFOLDER/conf/port-qwfwd)
server=${1:-mvdsv}
num=${2:-1}

[ "$server" != "mvdsv" ] && [ "$server" != "qtv" ] && [ "$server" != "qwfwd" ] && echo "Invalid server type (available: mvdsv, qtv, qwfwd)." && exit 1

[ "$server" = "mvdsv" ] && port=$mvdsvport && echo "* Using mvdsv configuration"
[ "$server" = "qtv" ] && port=$qtvport && num=1 && echo "* Using qtv configuration"
[ "$server" = "qwfwd" ] && port=$qwfwdport && num=1 && echo "* Using qwfwd configuration"

ip=$(curl -s https://ifcfg.me/)
echo "* Setting IP to $ip"
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
