#!/bin/bash

# Setup Hashicorp Vault

export VAULT_ADDR='http://127.0.0.1:8200'

# Save the root token displayed after starting the server in a file called authFile.

vault kv put secret/ethsignerSigningKey value=<Private Key without 0x prefix>

ethsigner --chain-id=2018 --downstream-http-port=8590 hashicorp-signer --host=127.0.0.1 --port=8200 --auth-file=authFile --tls-enabled=false --signing-key-path=/v1/secret/data/ethsignerSigningKey
