#!/bin/bash

# test

ethsigner --chain-id=5 --downstream-http-host=goerli.infura.io \
--downstream-http-path=/v3/d0e63ca5bb1e4eef2284422efbc51a56 --downstream-http-port=443 \
--downstream-http-tls-enabled file-based-signer --key-file=/mydirectory/keyFile \
--password-file=/mydirectory/passwordFile

curl -X GET http://127.0.0.1:8545/upcheck

curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":51}' http://127.0.0.1:8545
