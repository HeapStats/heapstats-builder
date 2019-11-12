FROM ubuntu:eoan
LABEL maintainer "Yasumasa Suenaga <yasuenag@gmail.com>"

RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y g++ maven ant binutils-dev mercurial \
                        libiberty-dev libsnmp-dev make libtbb-dev \
                        openjdk-8-jdk \
  && apt-get clean
COPY experimental/ubuntu/build.sh common/maven-proxy.sh /

CMD ["/build.sh"]
