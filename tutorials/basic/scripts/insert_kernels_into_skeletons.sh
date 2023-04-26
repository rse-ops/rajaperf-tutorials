#!/bin/bash
RAJAPERF_DIR=$HOME/code/RAJAPerf
TUTKERNEL_DIR=$RAJAPERF_DIR/src/tutkernel
SCRIPT_DIR=$HOME/scripts
WORK_DIR=$HOME/work
cp $HOME/skeletal/TUTORIAL_KERNEL_SKELETON-omp.cpp $TUTKERNEL_DIR/TUTORIAL_KERNEL-omp.cpp
cp $HOME/skeletal/TUTORIAL_KERNEL_SKELETON-seq.cpp $TUTKERNEL_DIR/TUTORIAL_KERNEL-seq.cpp
cp $HOME/skeletal/TUTORIAL_KERNEL_SKELETON.cpp $TUTKERNEL_DIR/TUTORIAL_KERNEL.cpp
cp $HOME/skeletal/TUTORIAL_KERNEL_SKELETON.hpp $TUTKERNEL_DIR/TUTORIAL_KERNEL.hpp
cp $HOME/skeletal/src_tutor_CMakeLists.txt $TUTKERNEL_DIR/CMakeLists.txt
cp $TUTKERNEL_DIR/TUTORIAL_KERNEL.hpp $TUTKERNEL_DIR/TUTORIAL_KERNEL.hpp.orig
cp $TUTKERNEL_DIR/TUTORIAL_KERNEL.cpp $TUTKERNEL_DIR/TUTORIAL_KERNEL.cpp.orig
cp $TUTKERNEL_DIR/TUTORIAL_KERNEL-seq.cpp $TUTKERNEL_DIR/TUTORIAL_KERNEL-seq.cpp.orig
cp $TUTKERNEL_DIR/TUTORIAL_KERNEL-omp.cpp $TUTKERNEL_DIR/TUTORIAL_KERNEL-omp.cpp.orig
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/data_setup.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL.hpp -s data_setup.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/loop_bodies.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL.hpp -s loop_bodies.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/class_variables.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL.hpp -s class_variables.txt

python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/defaults.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL.cpp -s defaults.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/kernel_setup.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL.cpp -s kernel_setup.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/checksum.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL.cpp -s checksum.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/kernel_teardown.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL.cpp -s kernel_teardown.txt

python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/cov_seq.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL-seq.cpp -s cov_seq.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/cov_lambda_bodies.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL-seq.cpp -s cov_lambda_bodies.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/raja_exec_policy.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL-seq.cpp -s raja_exec_policy.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/raja_kernel.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL-seq.cpp -s raja_kernel.txt

python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/cov_openmp.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL-omp.cpp -s cov_openmp.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/cov_lambda_bodies.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL-omp.cpp -s cov_lambda_bodies.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/raja_exec_policy_omp.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL-omp.cpp -s raja_exec_policy_omp.txt
python3 $SCRIPT_DIR/insert_file_at_location.py -i $WORK_DIR/raja_kernel.txt -o $TUTKERNEL_DIR/TUTORIAL_KERNEL-omp.cpp -s raja_kernel.txt

echo "all done!"



