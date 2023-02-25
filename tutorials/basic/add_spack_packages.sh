#!/bin/bash
eval "$(${CONDA_DIR}/bin/conda shell.bash hook 2> /dev/null)"
conda activate base
conda activate cling
eval `spack env activate --sh --dir $HOME/spack_env`
spack install --add raja%gcc@10.4.0
spack install --add raja%clang@9.0.1

