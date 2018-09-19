#!/bin/sh

set -e

# if command starts with an option, prepend mydumper
if [ "${1:0:1}" = '-' ]; then
  set -- mydumper "$@"
fi

echo "Executing $@..."
exec "$@"