#1.Base Image
FROM alpine:3.12
MAINTAINER AndyWong <andywongfly@gmail.com@gmail.com>

#2.aliyun source
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

#3.Add nginx
RUN apk add nginx
COPY ./conf.d/default.conf /etc/nginx/conf.d/
COPY ./nginx.conf /etc/nginx/
RUN mkdir -p /data/www
COPY ./index.html /data/www/index.html

#4.Expose volumes
VOLUME ["/data","/etc/nginx/cert"]

#5.Expose
EXPOSE 80

#6.data
WORKDIR /data

CMD ["nginx", "-g", "daemon off;"]