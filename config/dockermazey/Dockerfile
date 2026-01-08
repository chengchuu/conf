# STAGE: Go
FROM golang:1.23-bookworm as go-builder
WORKDIR /gee
# Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc libc6-dev libsqlite3-dev
ENV CGO_ENABLED=1 \
    GO111MODULE=on
COPY ./go-gin-gee .
RUN go mod download && \
    go run scripts/init/main.go -copyData="config.prd.json,database.db,index.tmpl"
RUN go build -o ./dist/api ./cmd/api/main.go

# STAGE: Base
FROM debian:bookworm-slim as base-builder
WORKDIR /web

# Dependencies
RUN apt-get update && \
    apt-get install -y curl vim tzdata gnupg ca-certificates supervisor nginx && \
    update-ca-certificates

# All Project Files
COPY . .

# Create Directories
RUN mkdir -p /web/log \
    /var/log/web \
    /var/log/supervisor \
    /var/log/nginx \
    /var/log/app \
    /var/www/html

# Nginx
RUN rm -rf /etc/nginx/sites-enabled/* \
    && rm -rf /etc/nginx/sites-available/* \
    && rm -rf /etc/nginx/conf.d/* \
    && rm -f /etc/nginx/nginx.conf
COPY ./conf/config/dockermazey/nginx.conf /etc/nginx/nginx.conf
# RUN nginx -t

# Node.js
# RUN apt update && \
#     apt install -y nodejs && \
#     apt-get install -y npm

# Go Service
COPY --from=go-builder /gee/dist/api /web/api
COPY --from=go-builder /gee/data /web/data
RUN chmod +x ./api

# Supervisor
RUN rm -rf /etc/supervisor/conf.d/*
COPY ./conf/config/supervisormazey/*.conf /etc/supervisor/conf.d/

# Entrypoint Script
COPY ./conf/config/dockermazey/entrypoint.sh /web/entrypoint.sh
RUN chmod +x /web/entrypoint.sh

EXPOSE 80

# ENTRYPOINT ./api --config-path="data/config.json"
ENTRYPOINT ["/web/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
