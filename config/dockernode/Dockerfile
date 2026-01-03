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
COPY ./docker-start.sh ./docker-start.sh
RUN chmod +x ./docker-start.sh

EXPOSE 80

CMD ["/bin/bash", "/web/docker-start.sh"]
