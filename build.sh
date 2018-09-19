#!/bin/sh

set -e

_latestVersion='0.9.5'
_hubImage='xfrocks/mydumper'
_hubImageWithTag="$_hubImage:$_latestVersion"

docker build . \
  --build-arg MYDUMPER_VERSION="$_latestVersion" \
  -t "$_hubImage" \
  -t "$_hubImageWithTag"

while true
do
  read -p "Push $_hubImage and $_hubImageWithTag? [yN]" yn
  case $yn in
    [Yy]* ) break;;
    * )
      exit 0;;
  esac
done
docker push "$_hubImage:latest"
docker push "$_hubImageWithTag"
