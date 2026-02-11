//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
// Copyright (c) 2017-23, Lawrence Livermore National Security, LLC
// and RAJA Performance Suite project contributors.
// See the RAJAPerf/LICENSE file for details.
//
// SPDX-License-Identifier: (BSD-3-Clause)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

#include "TUTORIAL_KERNEL.hpp"

#include "RAJA/RAJA.hpp"
#include "common/DataUtils.hpp"


namespace rajaperf
{
namespace tutorial
{


TUTORIAL_KERNEL::TUTORIAL_KERNEL(const RunParams& params)
  : KernelBase(rajaperf::Tutorial_KERNEL, params)
{
  // insert defaults.txt 
  checksum_scale_factor = 0.001 *
              ( static_cast<Checksum_type>(getDefaultProblemSize()) /
                                           getActualProblemSize() );

  setUsesFeature(Kernel);

  setVariantDefined( Base_Seq );
  setVariantDefined( RAJA_Seq );

  setVariantDefined( Base_OpenMP );
  setVariantDefined( RAJA_OpenMP );

}

TUTORIAL_KERNEL::~TUTORIAL_KERNEL()
{
}

void TUTORIAL_KERNEL::setUp(VariantID vid, size_t RAJAPERF_UNUSED_ARG(tune_idx))
{
  (void) vid;
  // insert kernel_setup.txt
}

void TUTORIAL_KERNEL::updateChecksum(VariantID vid, size_t tune_idx)
{
  // insert checksum.txt

}

void TUTORIAL_KERNEL::tearDown(VariantID vid, size_t RAJAPERF_UNUSED_ARG(tune_idx))
{
  (void) vid;
  // insert kernel_teardown.txt
}

} // end namespace tutorial
} // end namespace rajaperf
