# HeapStats Builder

**If you want to use Kubernetes as build bot, please see [here](https://github.com/HeapStats/heapstats-builder/blob/master/k8s)**

The containers in this repository provides build infrastructure for HeapStats.

* Preparation
    * `prep/`
    * Download HeapStats source from specified URL and create Analyzer ZIP archives.
* RPM bulid
    * `rpmbulid/*`
    * Create RPMs for EL6 / EL7 / EL8 /Fedora

# Build containers

```
$ cd <repo>/preparation
$ docker build . -t heapstats/build:prep
$ cd <repo>/rpmbuild/el6
$ docker build . -t heapstats/build:centos6
$ cd <repo>/rpmbuild/el7
$ docker build . -t heapstats/build:centos7
$ cd <repo>/rpmbuild/el8
$ docker build . -t heapstats/build:centos8
$ cd <repo>/rpmbuild/fedora
$ docker build . -t heapstats/build:fedora
```

# Pull from Docker Hub

https://hub.docker.com/r/heapstats/builder/

```
$ docker pull heapstats/bulider:prep
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
    * This value is only needed in `heapstats/builder:prep` container.
    * If you do not set this value, `heapstats/builder:prep` container will download BZ2 release archive from [IcedTea release repository](http://icedtea.wildebeest.org/hg/release/)

If you run them under proxy, you also need to set `http_proxy` and `https_proxy`.

## Run prep container

### Release version only

```
$ docker run -it --rm -v /path/to/outdir:/share -e RELEASE=<Release version> heapstats/builder:prep
```

### With `BZ2_ARCHIVE`
```
$ docker run -it --rm -v /path/to/outdir:/share -e BZ2_ARCHIVE=<Source archive URL> -e RELEASE=<Release version> heapstats/builder:prep
```

## Run rpmbuild for each OSes

```
$ docker run -it --rm -v /path/to/outdir:/share -e RELEASE=<Release version> heapstats/builder:centos6
$ docker run -it --rm -v /path/to/outdir:/share -e RELEASE=<Release version> heapstats/builder:centos7
$ docker run -it --rm -v /path/to/outdir:/share -e RELEASE=<Release version> heapstats/builder:centos8
$ docker run -it --rm -v /path/to/outdir:/share -e RELEASE=<Release version> heapstats/builder:fedora
```

You can get binaries from `/path/to/outdir`.

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

