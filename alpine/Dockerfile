# syntax=docker/dockerfile:1

ARG release=latest
FROM alpine:${release}

LABEL maintainer="Gabe Dunn <gabed@hey.com>"

# set the timezone
ENV TZ=America/Edmonton
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install initial pre-reqs
RUN apk add \
    build-base \
    bzip2 \
    clang-dev \
    cmake \
    curl \
    git \
    gnupg \
    linux-headers \
    lld \
    lldb \
    llvm \
    make \
    python3-dev

# set the llvm version & release
ARG llvmver=10
ARG boostver=1_76_0

# set default versions for commands
RUN ln -sf /usr/bin/clang-${llvmver}    /usr/bin/cc     && \
    ln -sf /usr/bin/clang-${llvmver}    /usr/bin/c++    && \
    ln -sf /usr/bin/lld                 /usr/bin/ld

# download boost source tarball & extract it
WORKDIR /usr/src/boost
RUN wget "https://boostorg.jfrog.io/artifactory/main/release/${boostver//_/.}/source/boost_${boostver}.tar.bz2" \
 && tar xvf boost_${boostver}.tar.bz2

# build and install the boost build system
WORKDIR /usr/src/boost/boost_${boostver}/tools/build
RUN ./bootstrap.sh clang \
 && ./b2 install toolset=clang

# build and install the boost libraries
WORKDIR /usr/src/boost/boost_${boostver}
RUN b2 --build-dir=/tmp/build-boost --build-type=complete --layout=versioned toolset=clang install

# clean up
WORKDIR /
RUN rm -rf /usr/src/boost
