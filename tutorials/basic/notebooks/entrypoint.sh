#!/usr/bin/bash

# Broker args for the fluxuri, etc.
# Note we are not using these, keeping here in case we need
#export brokerOptions="-Scron.directory=/etc/flux/system/cron.d 
#  -Stbon.fanout=256 \
#  -Srundir=/run/flux \
#  -Sstatedir=/var/lib/flux \
#  -Slocal-uri=local:///run/flux/local \
#  -Slog-stderr-level=0 \
#  -Slog-stderr-mode=local"

/home/ubuntu/.local/bin/jupyterhub -f /home/ubuntu/jupyterhub_config.py

