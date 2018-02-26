FROM fedora:latest
LABEL maintainer "Yasumasa Suenaga <yasuenag@gmail.com>"

RUN dnf upgrade -y \
  && dnf install -y gcc-c++ java-1.8.0-openjdk-devel \
                    java-1.8.0-openjdk-openjfx \
                    java-1.8.0-openjdk-openjfx-devel openjfx-devel maven ant \
                    binutils-devel tbb-devel autoconf automake rpm-build \
                    net-snmp-devel pcre-devel

ADD build.sh .

ENTRYPOINT ["./build.sh"]

