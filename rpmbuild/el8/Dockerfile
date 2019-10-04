FROM centos:8
LABEL maintainer "Yasumasa Suenaga <yasuenag@gmail.com>"

RUN dnf upgrade -y \
  && dnf install -y gcc-c++ java-1.8.0-openjdk-devel \
                    ant binutils-devel tbb-devel autoconf automake rpm-build \
                    wget net-snmp-devel make maven pcre-devel

ADD build.sh .

ENTRYPOINT ["./build.sh"]

