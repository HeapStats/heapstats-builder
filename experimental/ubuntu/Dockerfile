FROM ubuntu:eoan
LABEL maintainer "Yasumasa Suenaga <yasuenag@gmail.com>"

RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y openjdk-13-jdk g++ maven ant binutils-dev git \
                        libiberty-dev libsnmp-dev make libtbb-dev \
  && apt-get clean
COPY experimental/ubuntu/build.sh common/maven-proxy.sh ./

CMD ["./build.sh"]
