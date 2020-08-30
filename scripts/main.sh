#!/bin/bash -u

#

. ./.env
. ./.sanity.sh

PARAMS=""

displayUsage()
{
echo -e "\033[31;3m███████████████████████"
echo -e "\033[31;3m██ GOVERNANCE SIGNER ██"
echo -e "\033[31;3m███████████████████████"
sleep 2
echo -e "\n"
  echo "You can select the consensus mechanism to use.\n"
  echo "Usage: ${me} [OPTIONS]"
  echo "    -c <mainnet|testnet|other> : the network you want to connect to
                                       on your network, default is MAINNET"
  echo "    -e                       : setup"
  echo "    -s                       : test ethsigner with local rpcnode"
  exit 0
}

#mainnet='mainnet'
eth='mainnet' #
rinkeby='testnet' # 

composeFile="docker-compose"

while getopts "hesc:" o; do
  case "${o}" in
    h)
      displayUsage
      ;;
    c)
      algo=${OPTARG}
      case "${algo}" in
        mainnet|testnet|other)
          export NETWORK="${algo}"
          export RPC_API="${!algo}"
          export CLIENT_VERSION="${BESU_VERSION}"
          composeFile="${composeFile}_poa"
          ;;
        ethash)
          ;;
        *)
          echo "Error: Unsupported consensus value." >&2
          displayUsage
      esac
      ;;
    e)
      elk_compose="${composeFile/docker-compose/docker-compose_elk}"
      composeFile="$elk_compose"
      ;;
    s)
      if [[ $composeFile == *"poa"* ]]; then
        signer_compose="${composeFile/poa/poa_signer}"
        composeFile="$signer_compose"
      else
        echo "Error: Unsupported consensus value." >&2
        displayUsage
      fi
      ;;
    *)
      displayUsage
    ;;
  esac
done
