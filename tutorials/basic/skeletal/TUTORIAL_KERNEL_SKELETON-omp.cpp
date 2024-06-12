//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
// Copyright (c) 2017-23, Lawrence Livermore National Security, LLC
// and RAJA Performance Suite project contributors.
// See the RAJAPerf/LICENSE file for details.
//
// SPDX-License-Identifier: (BSD-3-Clause)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

#include "TUTORIAL_KERNEL.hpp"

#include "RAJA/RAJA.hpp"

#include <iostream>


namespace rajaperf
{
namespace tutorial
{


void TUTORIAL_KERNEL::runOpenMPVariant(VariantID vid, size_t RAJAPERF_UNUSED_ARG(tune_idx))
{
#if defined(RAJA_ENABLE_OPENMP) && defined(RUN_OPENMP)

  const Index_type run_reps= getRunReps();

  TUTORIAL_KERNEL_DATA_SETUP;

  switch ( vid ) {

    case Base_OpenMP : {

      startTimer();
      for (RepIndex_type irep = 0; irep < run_reps; ++irep) {
        // insert cov_openmp.txt
      }
      stopTimer();

      break;
    }

    case RAJA_OpenMP : {

      TUTORIAL_KERNEL_VIEWS_RAJA;

      // insert cov_lambda_bodies.txt

      // insert raja_exec_policy_omp.txt
    
      startTimer();
      for (RepIndex_type irep = 0; irep < run_reps; ++irep) {
        // insert raja_kernel.txt
      }
      stopTimer();

      break;
    }

    default : {
      getCout() << "\n  TUTORIAL_KERNEL : Unknown variant id = " << vid << std::endl;
    }

  }

#else
  RAJA_UNUSED_VAR(vid);
#endif
}

} // end namespace tutorial
} // end namespace rajaperf
