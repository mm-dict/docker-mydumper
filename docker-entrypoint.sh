#!/bin/sh

set -e

echo "Starting mydumper for database ${MYSQL_DATABASE}"
exec mydumper -h "${MYSQL_HOST}" -u "${MYSQL_USER}" -p "${MYSQL_PASSWORD}" -B "${MYSQL_DATABASE}" -o /backup/export-$(date '+%Y%m%d-%H%M%S') -c
