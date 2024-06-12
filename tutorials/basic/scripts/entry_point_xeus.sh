#!/bin/bash 

# Enable strict mode.
set -euo pipefail
# The Jupyter command to launch
# JupyterLab by default
DOCKER_STACKS_JUPYTER_CMD="${DOCKER_STACKS_JUPYTER_CMD:=lab}"

# Temporarily disable strict mode and activate environment cling:
set +euo pipefail
# our use case doesn't require the following 
#if [[ -z "${JUPYTERHUB_API_TOKEN+x}" ]]; then
#    echo "WARNING: using start-singleuser.sh instead of start-notebook.sh to start a server associated with JupyterHub."
#    exec /usr/local/bin/start-singleuser.sh "$@"
#fi

# same with wrapper
wrapper=""
#if [[ "${RESTARTABLE}" == "yes" ]]; then
#    wrapper="run-one-constantly"
#fi

# our main reason we created this entrypoint file
source activate cling

# Re-enable strict mode:
set -euo pipefail
# shellcheck disable=SC1091,SC2086
# exec the final command:
#exec /usr/local/bin/start.sh ${wrapper} jupyter ${DOCKER_STACKS_JUPYTER_CMD} ${NOTEBOOK_ARGS} "$@"
# don't know yet how to pick up ${NOTEBOOK_ARGS}, so we trim down the call. 

# check if standard output is a tty, if it is then call start with $@; otherwise start jupyter lab
if [[ -t 1 ]]; then
  exec /usr/local/bin/start.sh "$@"
else
  exec /usr/local/bin/start.sh jupyter ${DOCKER_STACKS_JUPYTER_CMD} "$@"
fi
