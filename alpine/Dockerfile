# syntax=docker/dockerfile:1

ARG release=latest
FROM alpine:${release}

LABEL maintainer="Gabe Dunn <gabed@hey.com>"

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

# set the boost version
ARG boostver=1_76_0

# set default versions for commands
RUN ln -sf /usr/bin/clang   /usr/bin/cc     \
 && ln -sf /usr/bin/clang   /usr/bin/c++    \
 && ln -sf /usr/bin/lld     /usr/bin/ld

# download boost source tarball & extract it
WORKDIR /usr/src/boost
RUN wget "https://boostorg.jfrog.io/artifactory/main/release/${boostver//_/.}/source/boost_${boostver}.tar.bz2" \
 && tar xf boost_${boostver}.tar.bz2 \
 && rm boost_${boostver}.tar.bz2

# configure the project to use clang
WORKDIR /usr/src/boost/boost_${boostver}
RUN ./bootstrap.sh --with-toolset=clang

# build and install the boost libraries
ARG builddir=/tmp/boost-build
RUN ./b2 --build-dir=${builddir} toolset=clang install \
 && rm -rf ${builddir}

# clean up
WORKDIR /
RUN rm -rf /usr/src/boost
