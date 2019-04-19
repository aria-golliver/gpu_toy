FROM ubuntu:18.04

RUN apt-get update -yqq \
 && apt-get install -yqq \
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
        ninja-build \
        xorg-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/clang_8.0.0
RUN curl -SL http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz | tar -xJC . --strip-components=1

ENV PATH=/usr/local/clang_8.0.0/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/clang_8.0.0/lib:$LD_LIBRARY_PATH

WORKDIR /gpu_toy
COPY ./ /gpu_toy

WORKDIR /gpu_toy/build_gcc
ENV CC=gcc
ENV CXX=g++
RUN cmake -GNinja ..
RUN cmake --build .
RUN ./gpu_toy_test

WORKDIR /gpu_toy/build_gcc_release
ENV CC=gcc
ENV CXX=g++
RUN cmake -GNinja -DCMAKE_BUILD_TYPE=Release .. 
RUN cmake --build .
RUN ./gpu_toy_test

WORKDIR /gpu_toy/build_clang
ENV CC=clang
ENV CXX=clang++
ENV CXX_FLAGS=
ENV C_FLAGS=${CXX_FLAGS}
RUN cmake -GNinja ..
RUN cmake --build .
RUN ./gpu_toy_test

WORKDIR /gpu_toy/build_clang_addrsan_ubsan_leaksan
ENV CC=clang
ENV CXX=clang++
ENV CXX_FLAGS=-fsanitize=undefined -fsanitize=address -fsanitize=leak
ENV C_FLAGS=${CXX_FLAGS}
RUN cmake -GNinja ..
RUN cmake --build .
RUN ./gpu_toy_test

WORKDIR /gpu_toy/build_clang_thread
ENV CC=clang
ENV CXX=clang++
ENV CXX_FLAGS=-fsanitize=thread
ENV C_FLAGS=${CXX_FLAGS}
RUN cmake -GNinja ..
RUN cmake --build .
RUN ./gpu_toy_test

WORKDIR /gpu_toy/build_clang_release
ENV CC=clang
ENV CXX=clang++
ENV CXX_FLAGS=
ENV C_FLAGS=${CXX_FLAGS}
RUN cmake -GNinja -DCMAKE_BUILD_TYPE=Release .. 
RUN cmake --build .
RUN ./gpu_toy_test