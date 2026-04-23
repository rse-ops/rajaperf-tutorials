#!/bin/bash
eval "$(${CONDA_DIR}/bin/conda shell.bash hook 2> /dev/null)"
conda activate base
conda activate cling
eval `spack env activate --sh --dir $HOME/spack_env`
spack install --add raja%gcc@10.4.0
spack install --add raja%clang@9.0.1
spack install --add papi%gcc@10.4.0
spack install --add adiak%gcc@10.4.0 ~mpi
cp `spack location -i papi%gcc@10.4.0`/lib/lib* /opt/conda/envs/cling/x86_64-conda-linux-gnu/sysroot/lib64/
spack install --add caliper@master%gcc@10.4.0 ~mpi ldflags="-Wl,-rpath-link,/opt/conda/envs/cling/lib" ^papi%gcc@10.4.0 ^adiak%gcc@10.4.0 ~mpi
eval `spack load --sh caliper`
