ARG ubuntu_version=22.04
FROM ghcr.io/rse-ops/ubuntu:$ubuntu_version

# Install gcc with spack  .. we leave default ubuntu 22.04 gcc i.e in /usr/bin alone since apps depends on it's stdlib
ARG gcc_version=10.2.0
ARG JOBS=4
ENV gcc_version=$gcc_version \
    gcc_spec="gcc@${gcc_version}+bootstrap+strip+binutils languages=c,c++,fortran,lto" \
    COMPILER_NAME=gcc \
    COMPILER_VERSION=$gcc_version \
    CC=/usr/bin/gcc \
    CXX=/usr/bin/g++ \
    FC=/usr/bin/gfortran \
    CPP=/usr/bin/cpp

RUN apt-get -qq update \
 && apt-get -qq install -y --no-install-recommends gfortran gawk texinfo mpich libmpich-dev \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

# build compiler and set defaults
# note the IFS to split the spec, spack can't tolerate a single-string spec with
# multiple flags components apparently
RUN spack external find hwloc ncurses gawk texinfo mpich \
 && EXTRA_LANG=$(bash -c "[[ ${gcc_version} > 5 ]] && echo ',jit'" || true) \
 && spack spec --reuse ${gcc_spec}$EXTRA_LANG "^binutils@2.38:" \
 && spack mirror add develop https://binaries.spack.io/releases/develop \
 && spack buildcache keys --install --trust \
 && spack add ${gcc_spec} \
 && spack -v install --jobs $JOBS --deprecated \
 && spack compiler add \
 && spack config add "packages:all:compiler:[${COMPILER_NAME}@${COMPILER_VERSION}]" 

WORKDIR /code
RUN git clone --recursive -b use_caliper https://github.com/jonesholger/RAJAPerf 

#prep Spack repo for raja_perf; initially populates spack_repo dir with repo.yaml and empty packages dir
# we copy scripts/spack_packages into that empty packages dir in the repo
RUN spack repo create /code/RAJAPerf/spack_repo raja_perf
WORKDIR /code/RAJAPerf
RUN cp -r scripts/spack_packages/* spack_repo/packages/
RUN spack repo add /code/RAJAPerf/spack_repo/ 

# create host config file and build using it
RUN spack dev-build -u hostconfig raja_perf@develop%gcc@10.2.0 +caliper ^caliper@master ^mpich@4.0
RUN mkdir build
WORKDIR /code/RAJAPerf/build
# assume there's only one host config file
RUN cmake -C ../hc* ..
RUN make -j $JOBS
    
## Install hatchet
WORKDIR /code
RUN git clone https://github.com/LLNL/hatchet && \
    cd hatchet && \
    pip install llnl-hatchet && \
    pip install -r requirements.txt
    

# TODO we will want to:
# 1. Figure out a visualization strategy here based on thicket/seaborn
# 2. Get it into a notebook / VSCode interface to run and see
