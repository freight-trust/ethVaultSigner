#!/bin/bash 

echo -ne "EthSigner Connecting to Goerli Testnet..."

ethsigner --chain-id=5 --downstream-http-host=goerli.infura.io \
--downstream-http-path=/v3/d0e63ca5bb1e4eef2284422efbc51a56 --downstream-http-port=443 \
--downstream-http-tls-enabled multikey-signer --directory=/Users/me/project
