#!/bin/bash
# bash ./docker-build.sh -r
set -e
echo "Migrate Configurations ..."
# Migrate Dcockerfile & Conf
\cp -f ./conf/config/dockernode/Dockerfile ./
\cp -f ./conf/.dockerignore ./
\cp ./server/config/node-feperf-monitor-server/config.prod.js ./node-feperf-monitor-server/config/config.prod.js;
