#1.Base Image
FROM alpine:3.12
MAINTAINER AndyWong <andywongfly@gmail.com@gmail.com>

#2.aliyun source
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# ensure www-data user exists
RUN set -x \
	&& addgroup -g 82  -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data

# Environments
ENV TIMEZONE            Asia/Shanghai
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M
ENV COMPOSER_ALLOW_SUPERUSER 1

#3.ADD-PHP-FPM
# Mirror mirror switch to Alpine Linux - http://dl-4.alpinelinux.org/alpine/
RUN apk update \
	&& apk upgrade \
	&& apk add \
		curl \
		tzdata \
		php7-fpm\
	    php7 \
	    php7-dev \
	    php7-apcu \
	    php7-bcmath \
	    php7-xmlwriter \
	    php7-ctype \
	    php7-curl \
	    php7-exif \
	    php7-iconv \
	    php7-intl \
	    php7-json \
	    php7-mbstring\
	    php7-opcache \
	    php7-openssl \
	    php7-pcntl \
	    php7-pdo \
	    php7-mysqlnd \
	    php7-mysqli \
	    php7-pdo_mysql \
	    php7-pdo_pgsql \
	    php7-phar \
	    php7-posix \
	    php7-session \
	    php7-xml \
	    php7-simplexml \
	    php7-mcrypt \
	    php7-xsl \
	    php7-zip \
	    php7-zlib \
	    php7-dom \
	    php7-redis\
	    php7-tokenizer \
	    php7-gd \
		#php7-mongodb \
		php7-fileinfo \
		php7-zmq \
		php7-memcached \
		php7-xmlreader \
 	&& cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
	&& echo "${TIMEZONE}" > /etc/timezone \
	&& apk del tzdata \
 	&& rm -rf /var/cache/apk/*

# https://github.com/docker-library/php/issues/240
# https://gist.github.com/guillemcanal/be3db96d3caa315b4e2b8259cab7d07e
# https://forum.alpinelinux.org/forum/installation/php-iconv-issue

RUN mkdir -p /usr/local/var/log/php7/
RUN mkdir -p /usr/local/var/run/
COPY ./php-fpm.conf /etc/php7/
COPY ./www.conf /etc/php7/php-fpm.d/
COPY ./zz-docker.conf /etc/php7/php-fpm.d/

# Set environments
RUN sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
	sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
	sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
	sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
	sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini


#4.Expose volumes
VOLUME ["/usr/local/var/log/php7", "/var/run/"]

#5.Expose
EXPOSE 9000

#6.data
WORKDIR /data

CMD ["/usr/sbin/php-fpm7","--nodaemonize","-R"]
