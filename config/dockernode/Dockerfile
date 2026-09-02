FROM node:10-buster as base-builder
ENV TZ=Asia/Shanghai
WORKDIR /web
COPY ./node-koa-rain /web/node-koa-rain
COPY ./server /web/server
RUN mkdir -p /web/node-koa-rain/temp \
    /web/server/temp
COPY ./conf/config/dockernode/docker-entrypoint.sh /web/docker-entrypoint.sh
RUN chmod +x /web/docker-entrypoint.sh
EXPOSE 3000 3224
ENTRYPOINT ["/web/docker-entrypoint.sh"]
