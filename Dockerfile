FROM ubuntu:20.04

ENV TZ=Asia/Tokyo
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
        build-essential \
        gcc-multilib \
        g++-multilib \
        wget \
        build-essential \
        curl \
        vim-gtk3 \
        python3 \
        netcat \
    && apt-get clean


ENV PIN_TAR_NAME=pin-3.20-98437-gf02b61307-gcc-linux
ENV PIN_ROOT=/${PIN_TAR_NAME}

# RUN wget http://software.intel.com/sites/landingpage/pintool/downloads/${PIN_TAR_NAME}.tar.gz \
#     && tar xvf ${PIN_TAR_NAME}.tar.gz
COPY ${PIN_TAR_NAME}.tar.gz .
RUN tar xvf ${PIN_TAR_NAME}.tar.gz

RUN mkdir -p libdft
COPY . libdft
WORKDIR libdft
RUN make
COPY ./env.init /opt/
COPY ./server.py /opt/

VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT [ "/opt/env.init" ]
