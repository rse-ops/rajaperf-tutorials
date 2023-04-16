#!/bin/bash
RAJAPERF_DIR=$HOME/code/RAJAPerf
RAJA_BASE=/home/jovyan/spack/opt/spack/linux-ubuntu22.04-x86_64/gcc-10.4.0/
eval "$(${CONDA_DIR}/bin/conda shell.bash hook 2> /dev/null)"
conda activate base
conda activate cling
eval `spack env activate --sh --dir $HOME/spack_env`
mkdir $HOME/code && pushd $HOME/code
git clone --recursive -b pr-from-fork/137 https://github.com/LLNL/RAJAPerf.git
#prep Spack repo for raja_perf; initially populates spack_repo dir with repo.yaml and empty packages dir
# we copy scripts/spack_packages into that empty packages dir in the repo
spack repo create $RAJAPERF_DIR/spack_repo raja_perf
pushd $RAJAPERF_DIR
# checkout specific commit hash
git reset --hard 9ed8761ec743869cfc1d6c88afef0cb841201079
mkdir -p spack_repo/packages/raja_perf
cp $HOME/scripts/package.py spack_repo/packages/raja_perf/
spack repo add $HOME/code/RAJAPerf/spack_repo 

# create host config file and build using it
spack dev-build -U -q -u hostconfig raja_perf@develop%gcc@10.4.0 +caliper ^caliper@master ~mpi ldflags="-Wl,-rpath-link,/opt/conda/envs/cling/lib"
spack dev-build -U -q -u hostconfig raja_perf@develop%clang@9.0.1 +caliper ^caliper@master%gcc@10.4.0 ~mpi ldflags="-Wl,-rpath-link,/opt/conda/envs/cling/lib"
mkdir build_gcc && mkdir build_clang
pushd $RAJAPERF_DIR/build_gcc
cmake -C ../hc*gcc* ..
make -j 6
popd
pushd $RAJAPERF_DIR/build_clang
cmake -C ../hc*clang* ..
make -j 6
popd
popd
popd

pushd $RAJAPERF_DIR/src/common
# compile libcommon.so so tutorial can pick up DataUtils
g++ -shared -o libcommon.so -fPIC -I$RAJA_BASE/raja-2022.03.0-f7p4trkfeq4gcmqnt5623haejgcvwlvl/include/ -I../../build_gcc/include -I$RAJA_BASE/camp-2022.03.2-nh5kkatqzxgiwxusi4ddpyhf2zcqxyow/include/ -I$RAJAPERF_DIR/src -fopenmp *.cpp
mv libcommon.so $HOME/code/RAJAPerf/build_gcc/lib
popd

# install for notebook and environment -- maybe change this to a requirements file specifying all versions
python3 -m pip install caliper-reader==0.3.0
python3 -m pip install llnl-hatchet==2022.2.0
/opt/conda/bin/python3 -m pip install caliper-reader==0.3.0
/opt/conda/bin/python3 -m pip install llnl-hatchet==2022.2.0

