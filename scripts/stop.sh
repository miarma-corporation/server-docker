#!/bin/sh

SCRIPTFOLDER=$(dirname `readlink -f "$0"`)
DOCKERFOLDER=$(readlink -f $SCRIPTFOLDER/../)
server=${1:-mvdsv}

[ "$server" != "mvdsv" ] && [ "$server" != "qtv" ] && [ "$server" != "qwfwd" ] && echo "Invalid server type (available: mvdsv, qtv, qwfwd)." && exit 1

running=$(docker ps -a -f name=nquakesv-$server-\* --format "{{.ID}}")
[ "$running" = "" ] && echo "No running containers" && exit 1

echo "* Stopping and removing old containers..."
docker rm -f $running 2>/dev/null
