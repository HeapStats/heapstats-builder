# HeapStats Builder

The containers in this repository provides build infrastructure for HeapStats.

* Preparation
    * `prep/`
    * Download HeapStats source from specified URL and create Analyzer ZIP archives.
* RPM bulid
    * `rpmbulid/*`
    * Create RPMs for EL6 / EL7 / Fedora

# Build containers

```
$ cd <repo>/preparation
$ docker build . -t heapstats/build:prep
$ cd <repo>/rpmbuild/el6
$ docker build . -t heapstats/build:centos6
$ cd <repo>/rpmbuild/el7
$ docker build . -t heapstats/build:centos7
$ cd <repo>/rpmbuild/fedora
$ docker build . -t heapstats/build:fedora
```

# Pull from Docker Hub

https://hub.docker.com/r/heapstats/builder/

```
$ docker pull heapstats/bulider:prep
$ docker pull heapstats/bulider:centos6
$ docker pull heapstats/bulider:centos7
$ docker pull heapstats/bulider:fedora
```

# Build HeapStats binaries

You have to set some environment variables:

* `BZ2_ARCHIVE`
    * Source archive on [IcedTea Mercurial repository](http://icedtea.wildebeest.org/hg/). You can get it from `bz2` link on left menu bar on this site.
    * This value is only needed in `heapstats/builder:prep` container.
* `RELEASE`
    * Release version (e.g. 2.1.0)
* `MAJOR`
    * Major release number (e.g. 2.1)

If you run them under proxy, you also need to set `http_proxy` and `https_proxy`.

```
$ docker run -it --previleged -v /path/to/outdir:/share -e BZ2_ARCHIVE=<Source archive URL> -e RELEASE=<Release version> -e MAJOR=<Major release number> heapstats/builder:prep
$ docker run -it --previleged -v /path/to/outdir:/share -e RELEASE=<Release version> -e MAJOR=<Major release number> heapstats/builder:centos6
$ docker run -it --previleged -v /path/to/outdir:/share -e RELEASE=<Release version> -e MAJOR=<Major release number> heapstats/builder:centos7
$ docker run -it --previleged -v /path/to/outdir:/share -e RELEASE=<Release version> -e MAJOR=<Major release number> heapstats/builder:fedora
```

You can get binaries from `/path/to/outdir`.

# Output files

## HeapStats 2.0

```
.
└── heapstats-2.0.5
     ├── bin
     │   ├── agent
     │   │   ├── heapstats-2.0.5-0.el6.x86_64.rpm
     │   │   ├── heapstats-2.0.5-0.el7.centos.x86_64.rpm
     │   │   ├── heapstats-2.0.5-0.fc27.x86_64.rpm
     │   │   ├── heapstats-debuginfo-2.0.5-0.el6.x86_64.rpm
     │   │   ├── heapstats-debuginfo-2.0.5-0.el7.centos.x86_64.rpm
     │   │   ├── heapstats-debuginfo-2.0.5-0.fc27.x86_64.rpm
     │   │   └── heapstats-debugsource-2.0.5-0.fc27.x86_64.rpm
     │   └── analyzer
     │       ├── heapstats-analyzer-2.0.5-0.fc27.noarch.rpm
     │       ├── heapstats-analyzer-2.0.5-bin.zip
     │       ├── heapstats-cli-2.0.5-0.el6.noarch.rpm
     │       ├── heapstats-cli-2.0.5-0.el7.centos.noarch.rpm
     │       ├── heapstats-cli-2.0.5-0.fc27.noarch.rpm
     │       └── heapstats-cli-2.0.5-bin.zip
     └── src
         ├── heapstats-2.0.5-0.el6.src.rpm
         ├── heapstats-2.0.5-0.el7.centos.src.rpm
         ├── heapstats-2.0.5-0.fc27.src.rpm
         └── heapstats-2.0.5.tar.gz
```

## HeapStats 2.1

```
.
└── heapstats-2.1.0
    ├── api
    │   ├── heapstats-core-2.1-SNAPSHOT.jar
    │   └── heapstats-plugin-api-2.1-SNAPSHOT.jar
    ├── bin
    │   ├── agent
    │   │   ├── heapstats-2.1.0-0.el6.x86_64.rpm
    │   │   ├── heapstats-2.1.0-0.el7.centos.x86_64.rpm
    │   │   ├── heapstats-2.1.0-0.fc27.x86_64.rpm
    │   │   ├── heapstats-debuginfo-2.1.0-0.el6.x86_64.rpm
    │   │   ├── heapstats-debuginfo-2.1.0-0.el7.centos.x86_64.rpm
    │   │   ├── heapstats-debuginfo-2.1.0-0.fc27.x86_64.rpm
    │   │   └── heapstats-debugsource-2.1.0-0.fc27.x86_64.rpm
    │   └── analyzer
    │       ├── heapstats-analyzer-2.1-SNAPSHOT-bin.zip
    │       ├── heapstats-analyzer-2.1.0-0.fc27.noarch.rpm
    │       ├── heapstats-cli-2.1-SNAPSHOT-bin.zip
    │       ├── heapstats-cli-2.1.0-0.el6.noarch.rpm
    │       ├── heapstats-cli-2.1.0-0.el7.centos.noarch.rpm
    │       └── heapstats-cli-2.1.0-0.fc27.noarch.rpm
    └── src
        ├── heapstats-2.1.0-0.el6.src.rpm
        ├── heapstats-2.1.0-0.el7.centos.src.rpm
        ├── heapstats-2.1.0-0.fc27.src.rpm
        └── heapstats-2.1.0.tar.gz
```

