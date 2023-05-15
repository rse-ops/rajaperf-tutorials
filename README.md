# RAJA Performance Suite

The RAJA Performance Suite is designed to explore performance of loop-based
computational kernels found in HPC applications. Specifically, it can be
used to assess and monitor runtime performance of kernels implemented using
[RAJA] C++ performance portability abstractions and compare those to variants
implemented using common parallel programming models, such as OpenMP and CUDA,
directly. Some important terminology used in the Suite includes:

  * `Kernel` is a distinct loop-based computation that appears in the Suite in
    multiple variants (or implementations), each of which performs the same
    computation.
  * `Variant` is an implementation or set of implementations of a kernel in the
    Suite that share the same approach/abstraction and programming model,
    such as baseline OpenMP, RAJA OpenMP, etc.
  * `Tuning` is a particular implementation of a variant of a kernel in the
    Suite, such as gpu block size 128, gpu block size 256, etc.
  * `Group` is a collection of kernels in the Suite that are grouped together
    because they originate from the same source, such as a specific benchmark
    suite.

Each kernel in the Suite appears in multiple RAJA and non-RAJA (i.e., baseline)
variants using parallel programming models that RAJA supports. Some kernels have
multiple tunings of a variant to explore some of the parametrization that the
programming model supports. The kernels originate from various HPC benchmark
suites and applications. For example, the "Stream" group contains kernels from
the Babel Stream benchmark, the "Apps" group contains kernels extracted from
real scientific computing applications, and so forth.

The suite can be run as a single process or with multiple processes when
configured with MPI support. Running with MPI in the same configuration used
by an hpc app allows the suite to gather performance data that is more relevant
for that hpc app than performance data gathered running single process. For
example running sequentially with one MPI rank per core vs running sequentially
with a single process yields different performance results on most multi-core
CPUs.

Find complete documentation on RAJAPerf here [RAJAPerf Documentation](https://rajaperf.readthedocs.io/en/develop/)

# RAJA Performance Suite Tutorial
=================================

The RAJA Performance Suite Tutorial guides the user through the process of running
RAJAPerf, including generating sweeps through various problem sizes, visualizing
the timing hierarchy, and walking through some simple post-processing analysis,
comparing the performance across two compilers, GCC and Clang, respectively.
In addition the tutorial guides the user with adding a new kernel to the suite,
and rerunning the analysis on the new kernel.

The Jupyter Lab environment is ready-built containing Caliper enabled versions of RAJAPerf,
with GCC and Clang variants. Also, we are able to allow interactive C++ interpreter
of OpenMP constructs utilizing Xeus-Cling under the hood.

# Technologies Referenced in the Tutorial
=======================================
* [RAJA](https://raja.readthedocs.io/)
* [Caliper](https://software.llnl.gov/Caliper/)
* [Hatchet](https://llnl-hatchet.readthedocs.io/en/latest/user_guide.html)
* [OpenMP](https://www.openmp.org/)
* [Xeus-Cling](https://xeus-cling.readthedocs.io/en/latest/)
* [Cling](https://root.cern/cling/)


This repository is supported by [tutorial-actions](https://github.com/rse-ops/tutorial-actions).
Each tutorial is focused around learning or trying a piece of software, and we will have a tool
that can easily deploy them.

# Start Tutorial
================

For local docker users start the tutorial with
docker run -p 8888:8888 image_id

Navigate to the Web pages highlighted at the end of the Jupyter Lab console output.

It will look something like

    To access the server, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/jpserver-1-open.html
    Or copy and paste one of these URLs:
        http://597d5b663944:8888/lab?token=998b2bdda9a76fef4ccc7d3c1d6776a7e9d77e4cbab37549
        http://127.0.0.1:8888/lab?token=998b2bdda9a76fef4ccc7d3c1d6776a7e9d77e4cbab37549

# Tutorial Navigation
=====================

Open the notebooks folder to find notebooks 00-xxxx through 07-xxxx .ipynb files, the first 00-intro-and-contents may be used as an index to jump to the other notebooks. The notebooks should be run in the order listed 00 - 07.


License
-------

Copyright (c) 2022, Lawrence Livermore National Security, LLC. 
Produced at the Lawrence Livermore National Laboratory.

RADIUSS is licensed under the MIT license [LICENSE](./LICENSE).

Copyrights and patents in the RADIUSS Docker project are retained by
contributors. No copyright assignment is required to contribute to RADIUSS
Docker.

This work was produced under the auspices of the U.S. Department of
Energy by Lawrence Livermore National Laboratory under Contract
DE-AC52-07NA27344.
