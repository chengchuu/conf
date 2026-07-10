FROM nginx:1.28-alpine
WORKDIR /web
RUN mkdir -p /web/x /web/conf /web/zbf
COPY ./x /web/x
COPY ./conf /web/conf
COPY ./conf/config/nginxgee /etc/nginx/conf.d
COPY ./x/zbf /web/zbf
EXPOSE 80
