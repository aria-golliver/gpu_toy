FROM ubuntu:18.04

RUN apt-get update -yqqq \
 && apt-get install -yqqq \
        build-essential \
        cmake \
        curl \
        git \
        libflac-dev \
        libgl1-mesa-dev \
        libogg-dev \
        libopenal-dev \
        libudev-dev \
        libvorbis-dev \
        xorg-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src/gpu_toy
COPY ./ /src/gpu_toy

WORKDIR /src/gpu_toy/build_gcc
RUN cmake ..
RUN cmake --build . -- -j `cat /proc/cpuinfo | grep processor | wc -l`

WORKDIR /tmp/install_clang
RUN curl -SL http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz | tar -xJC . \
 && mv clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04 clang_8.0.0 \
 && mv clang_8.0.0 /usr/local \
 && rm -rf *

ENV PATH=/usr/local/clang_8.0.0/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/clang_8.0.0/lib:$LD_LIBRARY_PATH

WORKDIR /src/gpu_toy/build_clang
ENV CC=/usr/local/clang_8.0.0/bin/clang
ENV CXX=/usr/local/clang_8.0.0/bin/clang++
RUN cmake ..
RUN cmake --build . -- -j `cat /proc/cpuinfo | grep processor | wc -l`
