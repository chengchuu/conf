#!/bin/bash
# bash ./docker-migrate.sh && bash ./docker-build.sh -r
set -e
echo "Build Docker ..."

# Define command-line flags
RUN_FLAG="RUN"
ENV_VARS=""
while [[ $# -gt 0 ]]; do
  case $1 in
    -r|--run)
      RUN_FLAG="RUN"
      shift
      ;;
    -b|--build)
      RUN_FLAG="BUILD"
      shift
      ;;
    *)
      echo "NONE!"
      shift
      ;;
  esac
done

# ProjectName
ProjectName="web"
# Port
visitPort="7414"
innerPort="7414"

# Stop
echo "Stop Docker Containers"
docker ps
docker ps|awk '{if (NR!=1) print $1}'| xargs docker stop

# Remove
echo "Remove Docker Containers"
docker ps -a -q
docker rm $(docker ps -a -q)

# Generate
randomVersion=${RANDOM}
combinedVersion="${ProjectName}:v${randomVersion}"
echo "Generate random version: ${combinedVersion}"

# Build
echo "Build Docker Image: ${combinedVersion}"
docker build -t ${combinedVersion} . -f ./Dockerfile

# Run
if [ ${RUN_FLAG} = "RUN" ]; then
  echo "Run Docker"
  echo "Environment variables: $ENV_VARS"
  echo "Running ..."
  docker run --name ${ProjectName} ${ENV_VARS} -d -p ${visitPort}:${innerPort} ${combinedVersion}
  echo "Complete, Visit: http://localhost:${visitPort}/feperf/ping"
else
  DATE_FORMAT=$(date +"%Y%m%d%H%M%S")
  REPOSITORY_TAGNAME="mazeyqian/${ProjectName}:v${DATE_FORMAT}-node"
  echo "DATE_FORMAT: ${DATE_FORMAT}"
  docker tag ${combinedVersion} ${REPOSITORY_TAGNAME}
  # docker push ${REPOSITORY_TAGNAME}
  echo "RUN_FLAG: ${RUN_FLAG}"
  echo "CURRENT_VERSION: v${DATE_FORMAT}"
  echo "REPOSITORY_TAGNAME: ${REPOSITORY_TAGNAME}"
  echo "All done."
fi
