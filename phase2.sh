#!/bin/sh

# Paranoia mode
set -e
set -u

HOSTNAME="$(hostname)"

echo "phase2"

# autoriser l'acces des autres serveur au serveur CONTROL
if [ "$HOSTNAME" = "control" ]; then
    puppet cert sign --all
fi

echo "SUCCESS Phase 2."
