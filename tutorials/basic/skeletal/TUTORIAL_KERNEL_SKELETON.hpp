//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
// Copyright (c) 2017-23, Lawrence Livermore National Security, LLC
// and RAJA Performance Suite project contributors.
// See the RAJAPerf/LICENSE file for details.
//
// SPDX-License-Identifier: (BSD-3-Clause)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

///
/// TUTORIAL_KERNEL kernel reference implementation:
///


#ifndef RAJAPerf_TUTORIAL_KERNEL_HPP
#define RAJAPerf_TUTORIAL_KERNEL_HPP

// insert data_setup.txt

// insert loop_bodies.txt

#include "common/KernelBase.hpp"

namespace rajaperf
{

class RunParams;

namespace tutorial
{

class TUTORIAL_KERNEL : public KernelBase
{
public:

  TUTORIAL_KERNEL(const RunParams& params);

  ~TUTORIAL_KERNEL();

  void setUp(VariantID vid, size_t tune_idx);
  void updateChecksum(VariantID vid, size_t tune_idx);
  void tearDown(VariantID vid, size_t tune_idx);

  void runSeqVariant(VariantID vid, size_t tune_idx);
  void runOpenMPVariant(VariantID vid, size_t tune_idx);
  
private:
  // insert class_variables.txt
};

} // end namespace tutorial
} // end namespace rajaperf

#endif // closing endif for header file include guard
