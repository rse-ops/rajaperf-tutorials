ARG ubuntu_version=22.04
FROM ubuntu:${ubuntu_version}

# docker build -t basic .

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install \
    python3-pip \
    git \
    cmake \
    wget

# Install caliper
RUN git clone https://github.com/LLNL/Caliper.git /caliper && \
    cd /caliper && \
    mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make && make install

# Install adiak
RUN wget https://github.com/LLNL/Adiak/releases/download/v0.2.1/adiak-0.2.1.tar.gz && \
    tar -xzvf adiak-0.2.1.tar.gz && \
    cd adiak-0.2.1 && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make && make install

# Install camp
RUN git clone --recursive https://github.com/LLNL/camp /camp && \
    cd /camp && \
    git submodule update && \
    mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make && make install
    
# Install hatchet
RUN git clone https://github.com/LLNL/hatchet /hatchet && \
    cd /hatchet && \
    pip install llnl-hatchet && \
    pip install -r requirements.txt
    
RUN git clone --recursive -b use_caliper https://github.com/jonesholger/RAJAPerf /code && ldconfig
COPY notebooks/build_rajaperf.sh /code/scripts/ubuntu-builds/build_rajaperf.sh
RUN cd /code && \
    git submodule update --recursive && \
    chmod +x ./scripts/ubuntu-builds/build_rajaperf.sh && \
    ./scripts/ubuntu-builds/build_rajaperf.sh 11 && \
    cd build_ubuntu-gcc-caliper-11 && \
    # Slower without -j but won't crash or freeze a machine!
    make && make install

# TODO we will want to:
# 1. Figure out a visualization strategy here
# 2. Get it into a notebook / VSCode interface to run and see
# 3. Possibly re-add openmpi install, and possibly install with spack.
WORKDIR /code/build_ubuntu-gcc-caliper-11
