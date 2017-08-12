### Building docker image

```
./scripts/build.sh
```

### Running the docker container

```
./scripts/run.sh
```

### Choosing what to run

To run mvdsv in your container:

```
echo mvdsv > conf/docker
```

To run qtv in your container:

```
echo qtv > conf/docker
```

To run qwfwd in your container:

```
echo qwfwd > conf/docker
```

When the `conf/docker` file has been updated, run the `run.sh` script again.

### Choosing what port to run

```
echo 28501 > conf/docker-port
```

When the `conf/docker` file has been updated, run the `run.sh` script again.
