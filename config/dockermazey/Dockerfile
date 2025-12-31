# STAGE: Go
FROM golang:1.23-alpine as go-builder
WORKDIR /gee
COPY ./go-gin-gee .
RUN go mod download
RUN go run scripts/init/main.go -copyData="config.json,database.db,index.tmpl"
RUN go build -o ./dist/api ./cmd/api/main.go

# STAGE: Base
FROM debian:bookworm-slim as base-builder
WORKDIR /web

# Base
RUN apt-get update && \
    apt-get install -y curl vim gnupg ca-certificates supervisor nginx

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
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN nginx -t

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

EXPOSE 80

# ENTRYPOINT ./api --config-path="data/config.json"
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
