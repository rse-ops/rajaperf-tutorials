#!/bin/bash
eval "$(${CONDA_DIR}/bin/conda shell.bash hook 2> /dev/null)"
conda activate base
conda activate cling
eval `spack env activate --sh --dir $HOME/spack_env`
mkdir $HOME/code && pushd $HOME/code
git clone --recursive -b use_caliper https://github.com/jonesholger/RAJAPerf 
#prep Spack repo for raja_perf; initially populates spack_repo dir with repo.yaml and empty packages dir
# we copy scripts/spack_packages into that empty packages dir in the repo
spack repo create $HOME/code/RAJAPerf/spack_repo raja_perf
pushd $HOME/code/RAJAPerf 
cp -r scripts/spack_packages/* spack_repo/packages/
spack repo add $HOME/code/RAJAPerf/spack_repo/ 

# create host config file and build using it
spack dev-build -U -q -u hostconfig raja_perf@develop%gcc@10.4.0 +caliper ^caliper@master ~mpi ldflags="-Wl,-rpath-link,/opt/conda/envs/cling/lib"
spack dev-build -U -q -u hostconfig raja_perf@develop%clang@9.0.1 +caliper ^caliper@master%gcc@10.4.0 ~mpi ldflags="-Wl,-rpath-link,/opt/conda/envs/cling/lib"
mkdir build_gcc && mkdir build_clang
pushd $HOME/code/RAJAPerf/build_gcc
cmake -C ../hc*gcc* ..
make -j
popd
pushd $HOME/code/RAJAPerf/build_clang
cmake -C ../hc*clang* ..
make -j
popd
popd
popd
# install for notebook and environment
python3 -m pip install llnl-hatchet
/opt/conda/bin/python3 -m pip install llnl-hatchet

