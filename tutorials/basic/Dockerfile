ARG ubuntu_version=22.04
FROM ghcr.io/rse-ops/ubuntu:$ubuntu_version

ARG password=perfuser
#setup perfuser
RUN useradd -m -d /home/perfuser -s /usr/bin/bash -g users -G sudo -u 1000 perfuser

SHELL ["/usr/bin/bash", "-o", "pipefail", "-c"]
RUN echo 'perfuser:perfuser' | chpasswd

RUN apt-get -qq update \
 && apt-get -qq install -y --no-install-recommends gfortran gawk texinfo mpich libmpich-dev python3-pip npm 

RUN apt-get clean \
    && apt-get autoremove \
    &&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g configurable-http-proxy 

RUN chmod -R 775 /opt

ARG jupyterhub_version=2.3.1

# Generate self-signed cert and key for local use
RUN mkdir -p /srv/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
          -subj  "/C=US/ST=CA/O=radiuss-tutorial/CN=radiuss-playground.org" \
          -keyout /srv/certs/jupyter-selfsigned.key \
          -out /srv/certs/jupyter-selfsigned.crt && \
          chown -R perfuser /srv/certs

# Or copy cert and key signed by a trusted CA
# COPY fullchain.pem /srv/jupyterhub/fullchain.pem
# COPY privkey.pem /srv/jupyterhub/privkey.pem

# Add template override directory and copy our example
RUN mkdir -p /srv/jupyterhub/overrides 

COPY notebooks/login.html /srv/jupyterhub/overrides/login.html

COPY --chown=perfuser:users ./notebooks/jupyterhub_config.py /home/perfuser/jupyterhub_config.py

#RUN git clone https://github.com/flux-framework/flux-workflow-examples.git ./notebooks/flux-workflow-examples
COPY --chown=perfuser:users ./notebooks/ /home/perfuser/notebooks
COPY --chown=perfuser:users ./notebooks/welcome.sh /welcome.sh 
COPY --chown=perfuser:users ./notebooks/entrypoint.sh /entrypoint.sh

USER perfuser
WORKDIR /home/perfuser
RUN mkdir code
ENV password=${password}
ENV PATH=/home/perfuser/.local/bin:$PATH

# Install gcc with spack  .. we leave default ubuntu 22.04 gcc i.e in /usr/bin alone since apps depends on it's stdlib
ARG gcc_version=10.2.0
ARG JOBS=4
ENV gcc_version=$gcc_version \
    gcc_spec="gcc@${gcc_version}+bootstrap+strip+binutils languages=c,c++,fortran,lto" \
    COMPILER_NAME=gcc \
    COMPILER_VERSION=$gcc_version \
    CC=/usr/bin/gcc \
    CXX=/usr/bin/g++ \
    FC=/usr/bin/gfortran \
    CPP=/usr/bin/cpp

RUN pip3 install --upgrade pip \
    && pip3 install setuptools-rust zipp==3.7.0 \
    && pip3 install jupyterhub \
    && python3 -m pip install jupyterlab notebook \
    && echo "export PATH=$HOME/.local/bin:$PATH" >> "$HOME/.bashrc"

 
#RUN spack external find hwloc ncurses gawk texinfo mpich \
# && spack compiler find

# build compiler and set defaults
# note the IFS to split the spec, spack can't tolerate a single-string spec with
# multiple flags components apparently
#RUN spack external find hwloc ncurses gawk texinfo mpich \
# && EXTRA_LANG=$(bash -c "[[ ${gcc_version} > 5 ]] && echo ',jit'" || true) \
# && spack spec --reuse ${gcc_spec}$EXTRA_LANG "^binutils@2.38:" \
# && spack mirror add develop https://binaries.spack.io/releases/develop \
# && spack buildcache keys --install --trust \
# && spack add ${gcc_spec} \
# && spack -v install --jobs $JOBS --deprecated \
# && spack compiler add \
# && spack config add "packages:all:compiler:[${COMPILER_NAME}@${COMPILER_VERSION}]" 

#WORKDIR /home/perfuser/code
#RUN git clone --recursive -b use_caliper https://github.com/jonesholger/RAJAPerf 

#prep Spack repo for raja_perf; initially populates spack_repo dir with repo.yaml and empty packages dir
# we copy scripts/spack_packages into that empty packages dir in the repo
#RUN spack repo create /home/perfuser/code/RAJAPerf/spack_repo raja_perf
#WORKDIR /home/perfuser/code/RAJAPerf
#RUN cp -r scripts/spack_packages/* spack_repo/packages/
#RUN spack repo add /home/perfuser/code/RAJAPerf/spack_repo/ 

# create host config file and build using it
#RUN spack dev-build -u hostconfig raja_perf@develop +caliper ^caliper@master ^mpich@4.0
#RUN mkdir build
#WORKDIR /home/perfuser/code/RAJAPerf/build
# assume there's only one host config file
#RUN cmake -C ../hc* ..
#RUN make -j $JOBS
    
## Install hatchet
#WORKDIR /home/perfuser/code
#RUN git clone https://github.com/LLNL/hatchet && \
#    cd hatchet && \
#    pip install llnl-hatchet && \
#    pip install -r requirements.txt
    

ENV SHELL=/usr/bin/bash

# This allows the running user to set the password on the container start

CMD /usr/bin/bash /welcome.sh && \
    echo "c.DummyAuthenticator.password = \"${password}\"" >> /home/perfuser/jupyterhub_config.py && \
    /usr/bin/bash /entrypoint.sh

