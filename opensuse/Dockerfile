# syntax=docker/dockerfile:1

ARG release=15.2
FROM opensuse/leap:${release}

LABEL maintainer="Gabe Dunn <gabed@hey.com>"

# install initial pre-reqs
RUN zypper --non-interactive install \
    bzip2 \
	ca-certificates \
	cmake \
	curl \
	gcc \
	git \
	gnupg \
	make \
	python-devel \
	wget

# set the llvm & boost version (& bring in openSUSE release again)
ARG llvmver=12
ARG llvmrel=${llvmver}.0.0
ARG boostver=1_76_0
ARG release

# add repos for compilers (clang) & c++ libraries (boost)
RUN zypper --non-interactive addrepo \
	"https://download.opensuse.org/repositories/devel:tools:compiler/openSUSE_Leap_${release}/devel:tools:compiler.repo" \
 && zypper --non-interactive --gpg-auto-import-keys refresh

# install packages, clang, clang tools, & llvm
RUN zypper --non-interactive install \
	# clang packages
	clang \
	clang-tools \
	clang${llvmver} \
	clang${llvmver}-devel \
	clang${llvmver}-doc \
	# llvm c++ standard library
	libc++-devel \
	libc++1 \
	libc++abi-devel \
	libc++abi1 \
	# library packages for clang
	libclang${llvmver} \
	# llvm debugger library packages
	liblldb${llvmver} \
	# llvm library packages
	libLLVM${llvmver} \
	# llvm linker
	lld \
	lld${llvmver} \
	# llvm debugger
	lldb \
	lldb-devel \
	lldb${llvmver} \
	lldb${llvmver}-devel \
	# llvm
	llvm \
	llvm${llvmver} \
	llvm-LTO-devel \
	llvm${llvmver}-LTO-devel \
	llvm-devel \
	llvm${llvmver}-devel \
	llvm${llvmver}-doc \
	# llvm polly
	llvm-polly \
	llvm-polly-devel \
	llvm${llvmver}-polly \
	llvm${llvmver}-polly-devel

# set default versions for commands
RUN update-alternatives --install /usr/bin/cc   cc  /usr/bin/clang-${llvmver}   1000 \
 && update-alternatives --install /usr/bin/c++  c++ /usr/bin/clang++-${llvmver} 1000 \
 && update-alternatives --install /usr/bin/ld   ld  /usr/bin/ld.lld-${llvmrel}  1000

# download boost source tarball & extract it
WORKDIR /usr/src/boost
RUN /bin/bash -c 'wget "https://boostorg.jfrog.io/artifactory/main/release/${boostver//_/.}/source/boost_${boostver}.tar.bz2"' \
 && tar xvf boost_${boostver}.tar.bz2 \
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
