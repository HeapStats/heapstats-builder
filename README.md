HeapStats Builder
===================

**If you want to use Kubernetes as build bot, please see [here](https://github.com/HeapStats/heapstats-builder/blob/master/k8s)**

The containers in this repository provides build infrastructure for HeapStats.

* Generate archives
    * `archives/`
    * Download HeapStats source from specified URL and create Analyzer ZIP archives.
* RPM bulid
    * `rpmbulid/*`
    * Create RPMs for EL6 / EL7 / EL8 /Fedora

# Build containers

## Download source archive and build analyzers

### for HeapStats 2.1 or earlier

```
$ docker build -t heapstats/builder:archives-2.1 -f archives/Dockerfile-2.1 .
```

### for HeapStats 2.2 or later (includes trunk repo)

```
$ docker build -t heapstats/builder:archives-2.2 -f archives/Dockerfile-2.2 .
```

## `rpmbuild` for each OSes

```
$ docker build -t heapstats/builder:centos6 -f rpmbuild/Dockerfile.el6 .
$ docker build -t heapstats/builder:centos7 -f rpmbuild/Dockerfile.el7 .
$ docker build -t heapstats/builder:centos8 -f rpmbuild/Dockerfile.el8 .
$ docker build -t heapstats/builder:fedora -f rpmbuild/Dockerfile.fedora .
```

# Pull from Docker Hub

https://hub.docker.com/r/heapstats/builder/

```
$ docker pull heapstats/bulider:archives-2.1
$ docker pull heapstats/bulider:archives-2.2
$ docker pull heapstats/bulider:centos6
$ docker pull heapstats/bulider:centos7
$ docker pull heapstats/bulider:centos8
$ docker pull heapstats/bulider:fedora
```

# Build HeapStats binaries

You have to set some environment variables:

* `RELEASE`
    * Release version (e.g. 2.1.0)
* `BZ2_ARCHIVE`
    * Source archive on [IcedTea Mercurial repository](http://icedtea.wildebeest.org/hg/). You can get it from `bz2` link on left menu bar on this site.
    * If you do not set this value, container will download BZ2 release archive from [IcedTea release repository](http://icedtea.wildebeest.org/hg/release/)

**NOTE:**  
`heapstats/builder:archives-2.1` is for HeapStats 2.1 or earlier. If you want to compile HeapStats 2.2 or later including trunk repo, you need to use `heapstats/builder:archives-2.2`.

If you run them under proxy, you also need to set `http_proxy` and `https_proxy`.

## Run containers

### Release version only

```
$ docker run -it --rm -v /path/to/outdir:/share -e RELEASE=<Release version> heapstats/builder:<tag>
```

### With `BZ2_ARCHIVE`
```
$ docker run -it --rm -v /path/to/outdir:/share -e BZ2_ARCHIVE=<Source archive URL> -e RELEASE=<Release version> heapstats/builder:<tag>
```

You can get binaries from `/path/to/outdir`.

**NOTE:**  
You can share maven local repository between containers if you pass `-v /path/to/localrepo:/root/.m2` to `docker run`. See [Maven Official Docker Hub](https://hub.docker.com/_/maven) for more details.

# Output files

## HeapStats 2.0

```
.
└ heapstats-2.0.6
    ├ bin
    │   ├ agent
    │   │   ├ heapstats-2.0.6-0.el6.x86_64.rpm
    │   │   ├ heapstats-2.0.6-0.el7.centos.x86_64.rpm
    │   │   ├ heapstats-2.0.6-0.el8.x86_64.rpm
    │   │   ├ heapstats-2.0.6-0.fc27.x86_64.rpm
    │   │   ├ heapstats-debuginfo-2.0.6-0.el6.x86_64.rpm
    │   │   ├ heapstats-debuginfo-2.0.6-0.el7.centos.x86_64.rpm
    │   │   ├ heapstats-debuginfo-2.0.6-0.el8.x86_64.rpm
    │   │   ├ heapstats-debuginfo-2.0.6-0.fc27.x86_64.rpm
    │   │   ├ heapstats-debugsource-2.0.6-0.el8.x86_64.rpm
    │   │   └ heapstats-debugsource-2.0.6-0.fc27.x86_64.rpm
    │   └ analyzer
    │       ├ heapstats-analyzer-2.0.6-0.fc27.noarch.rpm
    │       ├ heapstats-analyzer-2.0.6-bin.zip
    │       ├ heapstats-cli-2.0.6-0.el6.noarch.rpm
    │       ├ heapstats-cli-2.0.6-0.el7.centos.noarch.rpm
    │       ├ heapstats-cli-2.0.6-0.el8.noarch.rpm
    │       ├ heapstats-cli-2.0.6-0.fc27.noarch.rpm
    │       └ heapstats-cli-2.0.6-bin.zip
    └ src
        ├ heapstats-2.0.6-0.el6.src.rpm
        ├ heapstats-2.0.6-0.el7.centos.src.rpm
        ├ heapstats-2.0.6-0.el8.src.rpm
        ├ heapstats-2.0.6-0.fc27.src.rpm
        └ heapstats-2.0.6.tar.gz
```

## HeapStats 2.1

```
.
└ heapstats-2.1.0
    ├ api
    │   ├ heapstats-core-2.1.0.jar
    │   └ heapstats-plugin-api-2.1.0.jar
    ├ bin
    │   ├ agent
    │   │   ├ heapstats-2.1.0-0.el6.x86_64.rpm
    │   │   ├ heapstats-2.1.0-0.el7.centos.x86_64.rpm
    │   │   ├ heapstats-2.1.0-0.el8.x86_64.rpm
    │   │   ├ heapstats-2.1.0-0.fc27.x86_64.rpm
    │   │   ├ heapstats-debuginfo-2.1.0-0.el6.x86_64.rpm
    │   │   ├ heapstats-debuginfo-2.1.0-0.el7.centos.x86_64.rpm
    │   │   ├ heapstats-debuginfo-2.1.0-0.el8.x86_64.rpm
    │   │   ├ heapstats-debuginfo-2.1.0-0.fc27.x86_64.rpm
    │   │   ├ heapstats-debugsource-2.1.0-0.el8.x86_64.rpm
    │   │   └ heapstats-debugsource-2.1.0-0.fc27.x86_64.rpm
    │   └ analyzer
    │       ├ heapstats-analyzer-2.1.0-0.fc27.noarch.rpm
    │       ├ heapstats-analyzer-2.1.0-bin.zip
    │       ├ heapstats-cli-2.1.0-0.el6.noarch.rpm
    │       ├ heapstats-cli-2.1.0-0.el7.centos.noarch.rpm
    │       ├ heapstats-cli-2.1.0-0.el8.noarch.rpm
    │       ├ heapstats-cli-2.1.0-0.fc27.noarch.rpm
    │       └ heapstats-cli-2.1.0-bin.zip
    └ src
        ├ heapstats-2.1.0-0.el6.src.rpm
        ├ heapstats-2.1.0-0.el7.centos.src.rpm
        ├ heapstats-2.1.0-0.el8.src.rpm
        ├ heapstats-2.1.0-0.fc27.src.rpm
        └ heapstats-2.1.0.tar.gz
```

# Experimental build environment

## Raspbian

* [experimental/raspbian](experimental/raspbian)
* Run `raspbian-setup.sh`
    * Download and mount the latest Raspbian on current directory
    * Build HeapStats Agent for ARM32 from GitHub repo
* YOU MUST INSTALL `qemu-user-static` on your host

## Ubuntu

* [experimental/ubuntu](experimental/ubuntu)
* Run `docker build . -t heapstats-builder:ubuntu` to build image
* Run `docker run -it --rm heapstats-builder:ubuntu` to build HeapStats
    * Build HeapStats Agent and Analyzer for AMD64 from GitHub repo

