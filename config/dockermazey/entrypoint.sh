#!/bin/bash
set -e
echo "Starting Application ..."

echo "Waiting for DNS resolution of webnode ..."
until getent hosts webnode; do
  echo "webnode is unreachable - waiting ..."
  sleep 1
done

echo "Nginx config checking ..."
nginx -t

echo "Starting Supervisord ..."
exec "$@"
