#!/bin/sh

set -e

echo "Starting mydumper for database ${MYSQL_DATABASE}"

if [ "$MYDUMPER_DAEMON" = "true" ]
then
	cmd="mydumper -v 3 --daemon -h "${MYSQL_HOST}" -u "${MYSQL_USER}" -p "${MYSQL_PASSWORD}" -B "${MYSQL_DATABASE}" -o /backup -c"
else
	cmd="mydumper -v 3 -h "${MYSQL_HOST}" -u "${MYSQL_USER}" -p "${MYSQL_PASSWORD}" -B "${MYSQL_DATABASE}" -o /backup/export-$(date '+%Y%m%d-%H%M%S') -c"
fi
exec $cmd
