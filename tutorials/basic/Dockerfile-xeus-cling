FROM jupyter/scipy-notebook

USER $NB_USER:$NB_GID

RUN mamba create -n cling python=3.10.9 && source activate cling && \
  mamba install -c conda-forge -y  \
    xeus-cling=0.15.0 \
    libstdcxx-devel_linux-64=*=*19 \
    mpich \
    cmake \
    vim \
    gfortran=10.4.0 \
    gxx=10.4.0 \
    binutils \
    make \
    ninja \
    elfutils \
    zlib \
    libunwind \
    patchelf \
    lmod 
# fixup OpenMP header and lib paths to satisfy header search and ld search and ldconfig search
# todo run ldconfig after to pickup libs in /usr/local/lib
USER root
RUN mkdir -p /opt/conda/envs/cling/lib/clang/9.0.1/include && \
    cp /opt/conda/lib/clang/15.0.7/include/omp.h /opt/conda/envs/cling/lib/clang/9.0.1/include/omp.h  && \
    cp  /opt/conda/lib/libomp.so /usr/local/lib/libomp.so && \
    cp  /opt/conda/lib/libomp.so /opt/conda/envs/cling/x86_64-conda-linux-gnu/sysroot/lib64/ && \
    ldconfig -v 2> /dev/null

USER $NB_USER:$NB_GID
# Make RUN commands use the new environment:
RUN echo "source activate cling" >> $HOME/.bashrc
SHELL ["/bin/bash", "-c"]

ENV PREFIX=/opt/conda/envs/cling/share/jupyter/kernels
COPY --chown=$NB_USER:$NB_GID xcpp17-omp/ $PREFIX/xcpp17-omp/

RUN jupyter kernelspec install $PREFIX/xcpp17 --sys-prefix && \
  jupyter kernelspec install $PREFIX/xcpp17-omp --sys-prefix

COPY --chown=$NB_USER:$NB_GID notebooks $HOME/notebooks
COPY --chown=$NB_USER:$NB_GID scripts $HOME/scripts
COPY --chown=$NB_USER:$NB_GID skeletal $HOME/skeletal

RUN chmod +x scripts/set-up-spack.sh && ./scripts/set-up-spack.sh
#/opt/conda/envs/cling/bin:/opt/conda/condabin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PATH=${HOME}/spack/bin:/opt/conda/envs/cling/bin:/opt/conda/condabin:${PATH}
RUN echo "export PATH=${PATH}" >> $HOME/.bashrc && \
    echo ". ${HOME}/spack/share/spack/setup-env.sh" >> $HOME/.bashrc && \
    echo "spack env activate  --dir ${HOME}/spack_env" >> $HOME/.bashrc
COPY --chown=$NB_USER:$NB_GID spack.yaml $HOME/spack_env/
#install raja gcc and clang variants after conda init shell commands in an active bash session
# then install raja-perf using spack dev-build
RUN chmod +x scripts/add_spack_packages.sh && ./scripts/add_spack_packages.sh && \
    chmod +x scripts/add_code_packages.sh && ./scripts/add_code_packages.sh


# Just some general notes about this Dockerfile before we call the entrypoint
# g++ (conda-forge gcc 10.4.0-19) 10.4.0
# 
#(cling) jovyan@d37702b56b3d:~$ /opt/conda/envs/cling/bin/clang --version
#clang version 9.0.1 (https://github.com/conda-forge/clangdev-feedstock 2ea3b72da24769de0dfc6dac99251a5d7a46144d)
#
# to run container use docker run -p 8888:8888

# ENV
# NB_USER=jovyan
# NB_UID=1000
# NB_GID=100
# PWD=/home/jovyan
# CONDA_PREFIX=/opt/conda
# HOME=/home/jovyan


ENTRYPOINT ["/bin/bash","-c","$HOME/scripts/entry_point_xeus.sh"]
