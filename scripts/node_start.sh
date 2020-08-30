#!/bin/bash

set -e

PUBLIC_KEYS_DIR=${BESU_PUBLIC_KEY_DIRECTORY:=/opt/besu/public-keys/}
NODE_KEY_FILE="${PUBLIC_KEYS_DIR}node_pubkey"

rm -rf /opt/besu/database

# write pub key for making other nodes able to connect to node
/opt/besu/bin/besu $@ public-key export --to="${NODE_KEY_FILE}"

p2pip=`awk 'END{print $1}' /etc/hosts`

# run node on network named (replace for custom net)
/opt/besu/bin/besu $@ --network=${NETWORK}
