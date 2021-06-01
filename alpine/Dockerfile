# syntax=docker/dockerfile:1

ARG release=latest
FROM alpine:${release}

LABEL maintainer="Gabe Dunn <gabed@hey.com>"

# set the timezone
ENV TZ=America/Edmonton
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install initial pre-reqs
RUN apk add \
    boost-dev \
    boost-static \
    build-base \
    clang-dev \
    cmake \
    curl \
    git \
    gnupg \
    lld \
    lldb \
    llvm \
    make \
    python3

# set the llvm version & release
ARG llvmver=10
ARG llvmrel=${llvmver}.0.0

# set default versions for commands
RUN ln -sf /usr/bin/clang-${llvmver}    /usr/bin/cc     && \
    ln -sf /usr/bin/clang-${llvmver}    /usr/bin/c++    && \
    ln -sf /usr/bin/lld                 /usr/bin/ld
