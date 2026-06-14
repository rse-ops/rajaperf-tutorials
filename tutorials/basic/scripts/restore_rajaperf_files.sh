#!/bin/bash
RAJAPERF_DIR=$HOME/code/RAJAPerf
pushd $RAJAPERF_DIR/src
cp CMakeLists.txt.orig CMakeLists.txt
pushd $RAJAPERF_DIR/test
cp CMakeLists.txt.orig CMakeLists.txt
pushd $RAJAPERF_DIR/src/common
cp RAJAPerfSuite.hpp.orig RAJAPerfSuite.hpp
cp RAJAPerfSuite.cpp.orig RAJAPerfSuite.cpp
popd
popd
popd

