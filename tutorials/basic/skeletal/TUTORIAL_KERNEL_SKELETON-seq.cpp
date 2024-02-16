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


void TUTORIAL_KERNEL::runSeqVariant(VariantID vid, size_t RAJAPERF_UNUSED_ARG(tune_idx))
{
  const Index_type run_reps= getRunReps();

  TUTORIAL_KERNEL_DATA_SETUP;

  switch ( vid ) {

    case Base_Seq : {

      startTimer();
      for (RepIndex_type irep = 0; irep < run_reps; ++irep) {
       // insert cov_seq.txt
      }
      stopTimer();

      break;
    }

#if defined(RUN_RAJA_SEQ)
    case RAJA_Seq : {

      TUTORIAL_KERNEL_VIEWS_RAJA;

      // insert cov_lambda_bodies.txt

      // insert raja_exec_policy.txt
      
      startTimer();
      for (RepIndex_type irep = 0; irep < run_reps; ++irep) {
        // insert raja_kernel.txt
      }
      stopTimer();

      break;
    }
#endif // RUN_RAJA_SEQ

    default : {
      getCout() << "\n  TUTORIAL_KERNEL : Unknown variant id = " << vid << std::endl;
    }

  }

}

} // end namespace tutorial
} // end namespace rajaperf
