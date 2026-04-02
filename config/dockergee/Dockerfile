FROM nginx:1.28-alpine
WORKDIR /web
RUN mkdir -p /web/zbf
COPY ./conf/config/nginxgee /etc/nginx/conf.d
COPY ./x/zbf /web/zbf
EXPOSE 80
