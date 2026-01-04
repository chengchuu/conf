#!/bin/bash

# Stop
echo "Stop Docker Containers"
RUNNING_CONTAINERS=$(docker ps -q)
if [ -n "${RUNNING_CONTAINERS}" ]; then
  docker stop ${RUNNING_CONTAINERS}
else
  echo "No running containers to stop"
fi

# Remove
echo "Remove Docker Containers"
ALL_CONTAINERS=$(docker ps -a -q)
if [ -n "${ALL_CONTAINERS}" ]; then
  docker rm ${ALL_CONTAINERS}
else
  echo "No containers to remove"
fi
