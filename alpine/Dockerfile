# syntax=docker/dockerfile:1

ARG release=3
FROM alpine:${release}

LABEL maintainer="Gabe Dunn <gabed@hey.com>"

# set the timezone
ENV TZ=America/Edmonton
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install initial pre-reqs
RUN apk add \
    ca-certificates \
    cmake \
    curl \
    git \
    gcc \
    gnupg \
    make \
    wget

# set the llvm version
ARG llvmver=12

# checkout the llvm repo
WORKDIR /usr/src/build
RUN git clone --branch release/${llvmver}.x --depth=1 https://github.com/llvm/llvm-project.git
WORKDIR /usr/src/build/llvm-project

# generate the build files
RUN cmake -Hllvm -B build -G "Unix Makefiles" \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld;polly" \
    -DCMAKE_BUILD_TYPE=Release

# build the project
RUN cmake --build build
