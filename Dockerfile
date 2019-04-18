FROM ubuntu:18.04

RUN apt-get update -yqqq \
 && apt-get install -yqqq \
        build-essential \
        cmake \
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

WORKDIR /src/gpu_toy/build
RUN cmake ..
RUN cmake --build . -- -j `cat /proc/cpuinfo | grep processor | wc -l`
