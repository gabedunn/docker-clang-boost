# syntax=docker/dockerfile:1

ARG release=3
FROM alpine:${release}

LABEL maintainer="Gabe Dunn <gabed@hey.com>"

# set the timezone
ENV TZ=America/Edmonton
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install initial pre-reqs
RUN apk add \
    boost-dev \
    build-base \
    clang \
    cmake \
    curl \
    git \
    gnupg \
    make \
    python3

# set the llvm version & release
ARG llvmver=12
ARG llvmrel=${llvmver}.0.0

# checkout the llvm repo
WORKDIR /usr/src/build
RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${llvmrel}/llvm-project-${llvmrel}.src.tar.xz \
 && tar xvf llvm-project-${llvmrel}.src.tar.xz \
 && mv llvm-project-${llvmrel}.src llvm-project
WORKDIR /usr/src/build/llvm-project

# temp
RUN apk add build-base

# generate the build files
RUN cmake -Hllvm -B build -G "Unix Makefiles" \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld;polly" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=clang++

# build the project
RUN cmake --build build

# remove old version of clang
RUN apk del clang

# install clang
RUN cmake --build build --target install
