# syntax=docker/dockerfile:1

ARG release=15.2
FROM opensuse/leap:${release}

LABEL maintainer="Gabe Dunn <gabed@hey.com>"

# set the timezone
ENV TZ=America/Edmonton
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install initial pre-reqs
RUN zypper --non-interactive install \
	ca-certificates \
	cmake \
	curl \
	git \
	gnupg \
	make \
	wget

# set the llvm & boost version (& ubuntu release again)
ARG llvmver=12
ARG boostver=1_76_0
ARG release=15.2

# add repos for compilers (clang) & c++ libraries (boost)
RUN zypper --non-interactive addrepo \
	"https://download.opensuse.org/repositories/devel:tools:compiler/openSUSE_Leap_${release}/devel:tools:compiler.repo" && \
	zypper --non-interactive addrepo \
	"https://download.opensuse.org/repositories/devel:libraries:c_c++/openSUSE_Leap_${release}/devel:libraries:c_c++.repo" && \
	zypper --non-interactive --gpg-auto-import-keys refresh

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

# install boost library files
RUN zypper --non-interactive install \
	libboost_atomic${boostver} \
	libboost_atomic${boostver}-devel \
	libboost_chrono${boostver} \
	libboost_chrono${boostver}-devel \
	libboost_container${boostver} \
	libboost_container${boostver}-devel \
	libboost_context${boostver} \
	libboost_context${boostver}-devel \
	libboost_contract${boostver} \
	libboost_contract${boostver}-devel \
	libboost_coroutine${boostver} \
	libboost_coroutine${boostver}-devel \
	libboost_date_time${boostver} \
	libboost_date_time${boostver}-devel \
	libboost_fiber${boostver} \
	libboost_fiber${boostver}-devel \
	libboost_filesystem${boostver} \
	libboost_filesystem${boostver}-devel \
	libboost_graph${boostver} \
	libboost_graph${boostver}-devel \
	libboost_graph_parallel${boostver} \
	libboost_graph_parallel${boostver}-devel \
	libboost_headers${boostver}-devel \
	libboost_iostreams${boostver} \
	libboost_iostreams${boostver}-devel \
	libboost_json${boostver} \
	libboost_json${boostver}-devel \
	libboost_locale${boostver} \
	libboost_locale${boostver}-devel \
	libboost_log${boostver} \
	libboost_log${boostver}-devel \
	libboost_math${boostver} \
	libboost_math${boostver}-devel \
	libboost_mpi${boostver} \
	libboost_mpi${boostver}-devel \
	libboost_nowide${boostver} \
	libboost_nowide${boostver}-devel \
	libboost_numpy-py3-${boostver} \
	libboost_numpy-py3-${boostver}-devel \
	libboost_program_options${boostver} \
	libboost_program_options${boostver}-devel \
	libboost_python-py3-${boostver} \
	libboost_python-py3-${boostver}-devel \
	libboost_random${boostver} \
	libboost_random${boostver}-devel \
	libboost_regex${boostver} \
	libboost_regex${boostver}-devel \
	libboost_serialization${boostver} \
	libboost_serialization${boostver}-devel \
	libboost_stacktrace${boostver} \
	libboost_stacktrace${boostver}-devel \
	libboost_system${boostver} \
	libboost_system${boostver}-devel \
	libboost_test${boostver} \
	libboost_test${boostver}-devel \
	libboost_thread${boostver} \
	libboost_thread${boostver}-devel \
	libboost_timer${boostver} \
	libboost_timer${boostver}-devel \
	libboost_type_erasure${boostver} \
	libboost_type_erasure${boostver}-devel \
	libboost_wave${boostver} \
	libboost_wave${boostver}-devel

ARG llvmrel=${llvmver}.0.0

# set default versions for commands
RUN update-alternatives --install /usr/bin/cc			cc				/usr/bin/clang-${llvmrel}			1000 && \
	update-alternatives --install /usr/bin/c++			c++				/usr/bin/clang++-${llvmrel}			1000 && \
	update-alternatives --install /usr/bin/ld			ld				/usr/bin/ld.lld-${llvmrel}			1000

# set default start command to bash shell
CMD ["/bin/bash"]
