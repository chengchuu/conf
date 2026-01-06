# STAGE: Base
FROM node:10-buster as base-builder
WORKDIR /web

# Base
# RUN apt-get update && \
#     apt-get install -y curl vim gnupg ca-certificates

# Project Files
COPY ./node-feperf-monitor-server ./node-feperf-monitor-server
COPY ./node-koa-rain ./node-koa-rain
COPY ./server ./server
# Script
COPY ./webnode-docker-start.sh ./webnode-docker-start.sh
RUN chmod +x ./webnode-docker-start.sh

EXPOSE 3000 3224 7414

CMD ["/bin/bash", "/web/webnode-docker-start.sh"]
