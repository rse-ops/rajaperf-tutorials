#!/bin/bash
#set -euo pipefail
#set -x
pushd $HOME
export spack_commit=1ad290e5a271420abb65366b57364615f9a8e390
git clone https://github.com/spack/spack spack
pushd spack
git reset --hard ${spack_commit}
popd

# temporary path update for this script
export PATH=$HOME/spack/bin:$PATH
. ${HOME}/spack/share/spack/setup-env.sh
# Install Clingo for Spack
python3 -m pip install clingo

# Find packages already installed on system, e.g. autoconf
# IMPORTANT: ensure that all binaries installed include their development files
#            failure to do this will get them detected, and kill builds with
#            spack
# Find some packages out of the default check set that work
# configure spack
# build for the generic target
spack config add 'packages:all:target:[x86_64]'
# reuse as much as possible, make externals useful
# we're using multiple compilers
spack config add 'concretizer:unify:false'
spack env create --dir $HOME/spack_env
spack env activate --dir $HOME/spack_env
spack external find --scope env:$HOME/spack_env
spack external find -p /opt/conda/envs/cling --scope env:$HOME/spack_env python perl mpich bzip2 xz zlib elfutils

popd
