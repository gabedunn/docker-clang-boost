# syntax=docker/dockerfile:1

ARG release=focal
FROM ubuntu:${release}

LABEL maintainer="Gabe Dunn <gabed@hey.com>"

# install initial pre-reqs
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Edmonton
RUN apt update \
 && apt install -y \
	apt-transport-https \
	bzip2 \
	ca-certificates \
	cmake \
	curl \
	git \
	gnupg \
	make \
	python-dev \
	software-properties-common \
	wget

# set the llvm version (& bring in ubuntu release again)
ARG llvmver=12
ARG boostver=1_76_0
ARG release

# add the llvm repo and gpg key
RUN echo "deb http://apt.llvm.org/${release}/ llvm-toolchain-${release}-${llvmver} main" >> /etc/apt/sources.list.d/llvm.list \
 && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# install packages, clang, clang tools, & llvm
RUN apt update \
 && apt install -y \
	# clang packages
	clang-${llvmver} \
	clang-${llvmver}-doc \
	clang-format-${llvmver} \
	clang-tools-${llvmver} \
	clang-tidy-${llvmver} \
	clangd-${llvmver} \
	# llvm c++ standard library
	libc++-${llvmver}-dev \
	libc++1-${llvmver} \
	libc++abi-${llvmver}-dev \
	libc++abi1-${llvmver} \
	# library packages for clang
	libclang-${llvmver}-dev \
	libclang-cpp${llvmver}-dev \
	libclang1-${llvmver} \
	# llvm linker library packages
	liblld-${llvmver} \
	liblld-${llvmver}-dev \
	# llvm debugger library packages
	liblldb-${llvmver} \
	liblldb-${llvmver}-dev \
	# llvm linker
	lld-${llvmver} \
	# llvm debugger
	lldb-${llvmver} \
	# llvm
	llvm-${llvmver} \
	llvm-${llvmver}-dev \
	llvm-${llvmver}-doc \
	llvm-${llvmver}-runtime \
	llvm-${llvmver}-tools \
	# python bindings
	python3-clang-${llvmver} \
	python3-lldb-${llvmver}


# set default versions for commands
RUN update-alternatives --install /usr/bin/cc		    cc				/usr/bin/clang-${llvmver}			1000 \
 && update-alternatives --install /usr/bin/c++			c++				/usr/bin/clang++-${llvmver}			1000 \
 && update-alternatives --install /usr/bin/ld	        ld				/usr/bin/ld.lld-${llvmver}			1000 \
 && update-alternatives --install /usr/bin/clang        clang			/usr/bin/clang-${llvmver}			1000 \
 && update-alternatives --install /usr/bin/clang++      clang++			/usr/bin/clang++-${llvmver}			1000 \
 && update-alternatives --install /usr/bin/clang-cl     clang-cl		/usr/bin/clang-cl-${llvmver}		1000 \
 && update-alternatives --install /usr/bin/clang-cpp    clang-cpp		/usr/bin/clang-cpp-${llvmver}		1000 \
 && update-alternatives --install /usr/bin/clang-doc    clang-doc		/usr/bin/clang-doc-${llvmver}		1000 \
 && update-alternatives --install /usr/bin/clang-format clang-format    /usr/bin/clang-format-${llvmver}    1000 \
 && update-alternatives --install /usr/bin/clang-tidy   clang-tidy		/usr/bin/clang-tidy-${llvmver}		1000 \
 && update-alternatives --install /usr/bin/clangd       clangd			/usr/bin/clangd-${llvmver}			1000 \
 && update-alternatives --install /usr/bin/lld          lld				/usr/bin/lld-${llvmver}				1000 \
 && update-alternatives --install /usr/bin/ld.lld       ld.lld			/usr/bin/ld.lld-${llvmver}			1000 \
 && update-alternatives --install /usr/bin/lld-link     lld-link		/usr/bin/lld-link-${llvmver}		1000 \
 && update-alternatives --install /usr/bin/lldb         lldb			/usr/bin/lldb-${llvmver}			1000

# download boost source tarball & extract it
WORKDIR /usr/src/boost
RUN /usr/bin/bash -c 'wget "https://boostorg.jfrog.io/artifactory/main/release/${boostver//_/.}/source/boost_${boostver}.tar.bz2"' \
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
