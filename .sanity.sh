#!/bin/sh

me=`basename "$0"`

if [ "$me" = ".sanity.sh" ];then
  echo >&2 "This script is not expected to be run separately."
  exit 1
fi

bold=$(tput bold)
normal=$(tput sgr0)

# Docker
hash docker 2>/dev/null || {
  echo >&2 "This script requires Docker but it's not installed."
  echo >&2 "Please Install the requirements."
  exit 1
}

# Docker Compose
hash docker-compose 2>/dev/null || {
  echo >&2 "This script requires Docker Compose"
  echo >&2 "Please Install the requirements."
  exit 1
}

# Java 11
hash java 2>/dev/null || {
  echo >&2 "This script requires Java JDK 11"
  echo >&2 "Please Install the requirements."
  exit 1

}

current_dir=${PWD##*/}
