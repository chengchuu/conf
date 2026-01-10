#!/bin/bash
# bash ./docker-migrate.sh && bash ./docker-build.sh -r

echo "Start Build Docker"

# ProjectName
PROJECT_NAME="web"
# Port
VISIT_PORT="80"
INNER_PORT="80"
# Variates
DATE_FORMAT=$(date +"%Y%m%d%H%M%S")

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
    -h|--help)
      echo "Usage: docker-build.sh [OPTIONS] [ENV_VARS...]"
      echo "Build and run a Docker container for ${PROJECT_NAME}."
      echo ""
      echo "Options:"
      echo "  -r, --run     Run the Docker container after building (default)"
      echo "  -b, --build   Build the Docker image but do not run it"
      echo "  -h, --help    Print this help message and exit"
      echo ""
      echo "Environment variables:"
      echo "  Any additional arguments passed to the script will be passed as environment variables to the Docker container."
      echo ""
      exit 0
      ;;
    *)
      ENV_VARS="${ENV_VARS} -e $1"
      echo "Added environment variable: $1"
      shift
      ;;
  esac
done

echo "ENV_VARS: ${ENV_VARS}"

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

# Generate
RANDOM_VERSION=${DATE_FORMAT}
COMBINED_VERSION="${PROJECT_NAME}:v${RANDOM_VERSION}"
echo "Generate random version: ${COMBINED_VERSION}"

# Build
echo "Build Docker Image: ${COMBINED_VERSION}"
docker build -t "${COMBINED_VERSION}" . -f ./Dockerfile

# Run
if [ ${RUN_FLAG} = "RUN" ]; then
  echo "Run Docker"
  echo "Environment variables: ${ENV_VARS}"
  echo "Docker Running ..."
  echo "docker run --name \"${PROJECT_NAME}\" --restart unless-stopped ${ENV_VARS} -d -p \"${VISIT_PORT}:${INNER_PORT}\" -v \"VarLogWeb:/var/log/web\" \"${COMBINED_VERSION}\""
  docker run --name "${PROJECT_NAME}" \
    --restart unless-stopped \
    ${ENV_VARS} \
    -d \
    -p "${VISIT_PORT}:${INNER_PORT}" \
    -v "VarLogWeb:/var/log/web" \
    "${COMBINED_VERSION}"
  echo "Complete, Visit: http://localhost:${VISIT_PORT}/api/ping"
# fi
else
  REPOSITORY_TAGNAME="mazeyqian/${COMBINED_VERSION}-mazey"
  docker tag ${COMBINED_VERSION} ${REPOSITORY_TAGNAME}
  # docker push ${REPOSITORY_TAGNAME}
  echo "RUN_FLAG: ${RUN_FLAG}"
  echo "CURRENT_VERSION: v${RANDOM_VERSION}"
  echo "REPOSITORY_TAGNAME: ${REPOSITORY_TAGNAME}"
  echo "All done."
fi
