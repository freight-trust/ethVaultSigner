#!/bin/bash

. ./.env


if [[ ${version} != *"latest"* ]]; then
  echo "Latest version not running" >&2
  echo "Run it with ./init.sh" >&2
  exit 1
fi

