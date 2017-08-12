### Building docker image

```
./scripts/build.sh
```

### Running the docker container

```
./scripts/run.sh
```

Run several containers

```
./scripts/run.sh 5
```

This will start 5 mvdsv instances.

### Choosing what port to run

```
echo 28501 > conf/port
```

This determines what port the servers start running at. The next instance will get port number {port}+1.
