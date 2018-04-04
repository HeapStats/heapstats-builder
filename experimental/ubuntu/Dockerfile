FROM ubuntu:latest
LABEL maintainer "Yasumasa Suenaga <yasuenag@gmail.com>"

RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y openjdk-8-jdk openjfx g++ maven ant binutils-dev git \
                        libiberty-dev libsnmp-dev make libtbb-dev
ADD build.sh .

ENTRYPOINT ["./build.sh"]

