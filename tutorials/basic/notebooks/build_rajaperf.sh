#!/usr/bin/env bash

###############################################################################
# Copyright (c) 2017-22, Lawrence Livermore National Security, LLC
# and RAJA project contributors. See the RAJAPerf/LICENSE file for details.
#
# SPDX-License-Identifier: (BSD-3-Clause)
###############################################################################

if [ "$1" == "" ]; then
  echo
  echo "You must pass a compiler version number to script. For example,"
  echo "    $0 8"
  exit
fi

COMP_VER=$1
shift 1

BUILD_SUFFIX=ubuntu-gcc-caliper-${COMP_VER}
# RAJA_HOSTCONFIG=../tpl/RAJA/host-configs/ubuntu-builds/gcc_X.cmake
RAJA_HOSTCONFIG=../tpl/RAJA/host-configs/lc-builds/toss3/gcc_X.cmake

# TODO install openmpi?

echo
echo "Creating build directory ${BUILD_SUFFIX} and generating configuration in it"
echo

rm -rf build_${BUILD_SUFFIX} 2>/dev/null
mkdir build_${BUILD_SUFFIX} && cd build_${BUILD_SUFFIX}

LIB_PREFIX=/usr/local

cmake \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
  -DCMAKE_PREFIX_PATH="${LIB_PREFIX}/share/cmake/caliper;${LIB_PREFIX}/lib/cmake/adiak;${LIB_PREFIX}/lib/cmake/camp" \
  -C ${RAJA_HOSTCONFIG} \
  -DRAJA_PERFSUITE_USE_CALIPER=On \
  -DCMAKE_INSTALL_PREFIX=../install_${BUILD_SUFFIX} \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=On \
  -DCMAKE_VERBOSE_MAKEFILE=On \
  "$@" \
  ..

# Can add these back when we need openmpi
#  -DENABLE_MPI=On \
#  -DENABLE_OPENMP=On \


echo
echo "***********************************************************************"
echo "cd into directory ${BUILD_SUFFIX} and run make to build RAJA Perf Suite"
echo "***********************************************************************"
