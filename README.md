# nQuake server docker

The nQuake server project contains everything needed to run a QuakeWorld KTX server with community standard configuration. It also comes packaged with QTV and QWFWD, allowing for spectating games and forwarding QuakeWorld traffic, helping people reach lower pings across countries thanks to more intelligent routing.

This project encapsulates the nQuake server inside an Ubuntu 16.04 docker image and provides helper scripts (both shell scripts and PowerShell scripts) that make starting, stopping and restarting containers very easy.

When the containers are started, configuration files are linked to the `conf/server` folder inside the repository. These can then be altered if you want to update your server configuration. Don't forget to restart the servers after having modified the configuration!

## Prerequisites

Before downloading and running nQuake server docker, you should install the following:

* Git ([Windows](https://git-scm.com/download/win), [Linux](https://git-scm.com/download/linux))
* Docker ([Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows), [Ubuntu](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/), [Other](https://www.docker.com/community-edition))

### Configuring Docker on Windows

When Docker has been setup, make sure you share the drive that contains/will contain the nQuake server docker files.

To do this, right-click the Docker icon and select *Settings*, then click *Shared Drives* and check the drive that you will clone the nQuake server docker repository to.

Also, since nQuake server runs inside an Ubuntu image, you need to enable Linux containers if running on a Windows 10 host. Right-click the Docker icon and click *Switch to Linux Containers...*

To enable running scripts in PowerShell, you will need to enable the unrestricted execution policy. Open an elevated PowerShell prompt and run the following command:

```
Set-ExecutionPolicy Unrestricted
```

Answer `y`.

All done.

## Downloading

To download the files, simply open a terminal or Git bash prompt and enter:

```
git clone https://github.com/nQuake/server-docker.git nquakesv-docker
```

## Building

Linux:
```
./scripts/build.sh
```

Windows (in elevated PowerShell prompt):
```
.\scripts\build.ps1
```

This will build the nQuake server docker image that will be used to spawn server containers.

## Running

Linux:
```
./scripts/run.sh [mvdsv|qtv|qwfwd] [num]
```

Windows (in elevated PowerShell prompt):
```
.\scripts\run.sh [mvdsv|qtv|qwfwd] [num]
```

The `num` parameter is the amount of servers to start.

Example (Linux):
```
./scripts/run.sh mvdsv 2
```

This will start 2 mvdsv containers.

### Choosing port range

Linux:
```
echo -n 28501 > conf/port-mvdsv
```

Windows (in elevated PowerShell prompt):
```
28501 | Out-File -Encoding ASCII -NoNewline conf/port-mvdsv
```

This will set the port range for mvdsv to 28501-(28501+n).

The ports for qtv and qwfwd are kept in `conf/port-qtv` and `conf/port-qwfwd` respectively.

**IMPORTANT!** While you CAN set the ports by simply editing the files by hand, it is not advised since it may result in newlines and other characters that will be interpreted by the scripts and halt execution due to bad formatting.

### Restarting containers

Linux:
```
./scripts/restart.sh [mvdsv|qtv|qwfwd]
```

Windows (in elevated PowerShell prompt):
```
.\scripts\restart.sh [mvdsv|qtv|qwfwd]
```

Example (Linux):
```
./scripts/restart.sh qtv
```

This will stop the qtv container.

### Stopping containers

Linux:
```
./scripts/stop.sh [mvdsv|qtv|qwfwd]
```

Windows (in elevated PowerShell prompt):
```
.\scripts\stop.sh [mvdsv|qtv|qwfwd]
```

Example (Windows):
```
.\scripts\run.ps1 mvdsv
```

This will stop all mvdsv containers.

## Scenarios

Installing and running 4 mvdsv servers, 1 qtv and 1 qwfwd on Linux:

```
git clone https://github.com/nQuake/server-docker.git nquakesv-docker
cd nquakesv-docker
./scripts/build.sh
./scripts/run.sh mvdsv 4
./scripts/run.sh qtv
./scripts/run.sh qwfwd
```

Installing and running 3 mvdsv servers and 1 qtv on Windows:

```
git clone https://github.com/nQuake/server-docker.git nquakesv-docker
cd nquakesv-docker
.\scripts\build.ps1
.\scripts\run.ps1 mvdsv 3
.\scripts\run.ps1 qtv
```
