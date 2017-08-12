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
