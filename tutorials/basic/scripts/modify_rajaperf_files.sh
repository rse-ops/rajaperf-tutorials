#!/bin/bash
RAJAPERF_DIR=$HOME/code/RAJAPerf
TUTKERNEL_DIR=$RAJAPERF_DIR/src/tutkernel
RAJA_BASE=/home/jovyan/spack/opt/spack/linux-ubuntu22.04-x86_64/gcc-10.4.0/
pushd $RAJAPERF_DIR/src
cp CMakeLists.txt CMakeLists.txt.orig
sed -i 's+include_directories(.)+include_directories(.)\n\nadd_subdirectory(tutkernel)+g' CMakeLists.txt
sed -i 's+list(APPEND RAJA_PERFSUITE_EXECUTABLE_DEPENDS ${RAJA_PERFSUITE_DEPENDS}+list(APPEND RAJA_PERFSUITE_EXECUTABLE_DEPENDS ${RAJA_PERFSUITE_DEPENDS} tutkernel+g' CMakeLists.txt
pushd $RAJAPERF_DIR/test
cp CMakeLists.txt CMakeLists.txt.orig
sed -i 's+list(APPEND RAJA_PERFSUITE_TEST_EXECUTABLE_DEPENDS ${RAJA_PERFSUITE_DEPENDS}+list(APPEND RAJA_PERFSUITE_TEST_EXECUTABLE_DEPENDS ${RAJA_PERFSUITE_DEPENDS} tutkernel+g' CMakeLists.txt
mkdir -p $TUTKERNEL_DIR
pushd $RAJAPERF_DIR/src/common
cp RAJAPerfSuite.hpp RAJAPerfSuite.hpp.orig
sed -i 's+Algorithm,+Algorithm,\n  Tutorial,+g' RAJAPerfSuite.hpp
sed -i 's+Algorithm_MEMCPY,+Algorithm_MEMCPY,\n//\n// Tutorial Kernel\n//\n  Tutorial_KERNEL,+g' RAJAPerfSuite.hpp
cp RAJAPerfSuite.cpp RAJAPerfSuite.cpp.orig
sed -i 's+#include "algorithm/MEMCPY.hpp"+#include "algorithm/MEMCPY.hpp"\n\n//\n// Tutorial kernel\n//\n#include "tutkernel/TUTORIAL_KERNEL.hpp"+g' RAJAPerfSuite.cpp
sed -i 's+std::string("Algorithm"),+std::string("Algorithm"),\n  std::string("Tutorial"),+g' RAJAPerfSuite.cpp
sed -i 's+std::string("Algorithm_MEMCPY"),+std::string("Algorithm_MEMCPY"),\n\n//\n// Tutorial Kernel\n//\n  std::string("Tutorial_KERNEL"),+g' RAJAPerfSuite.cpp
sed -i 's+default: {+\n//\n// Tutorial Kernel\n//\n    case Tutorial_KERNEL: {\n      kernel = new tutorial::TUTORIAL_KERNEL(run_params);\n      break;\n    }\n\n    default: {+g' RAJAPerfSuite.cpp

popd
popd
popd
echo "all done"

