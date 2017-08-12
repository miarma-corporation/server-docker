# nQuake server docker

This project encapsulates the nQuake server inside an Ubuntu 16.04 docker image and provides helper scripts that make starting and stopping the containers very easy.

When the containers are started, configuration files are linked to the `conf/server` folder inside the repository. These can then be altered as long as the server containers are restarted (using the `scripts/restart.sh` script).

### Building docker image

```
./scripts/build.sh
```

### Running the docker container

The syntax is as follows:

```
./scripts/run.sh [mvdsv|qtv|qwfwd] [num]
```

The `num` parameter is the amount of servers to start.

```
./scripts/run.sh mvdsv 2
```

This will start 2 mvdsv containers.

### Choosing port range

```
echo 28501 > conf/port-mvdsv
```

This will set the port range for mvdsv to 28501-(28501+n).

The ports for qtv and qwfwd are kept in `conf/port-qtv` and `conf/port-qwfwd` respectively.
