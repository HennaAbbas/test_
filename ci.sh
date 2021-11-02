#!/bin/bash -e

FAILURE=1

export APP_NAME="node-expel"
export APP_VERSION="$(git describe --tags 2>/dev/null)"


usage() {
   echo 'Usage: ./ci.sh <make target>'
   echo 'Make targets:'
   echo
   for i in $(awk '/^\w+:/ {gsub(":", ""); print $1}' Makefile); do
       echo $i ;
   done
   echo
}

could_not_acquire_tag() {
    echo Fatal: Could not acquire git tag
    exit $FAILURE
}

validate() {
  if [ $# -ne 1 ]; then
      usage
      exit $FAILURE
  fi

  if [ -z $APP_VERSION ]; then
      could_not_acquire_tag
  fi
}

MAKE_TARGET="$1"

validate "$@"
docker-compose run $APP_NAME $MAKE_TARGET
