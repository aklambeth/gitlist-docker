FROM docker.io/lsiobase/alpine.nginx
ADD https://github.com/klaussilveira/gitlist/releases/download/1.0.2/gitlist-1.0.2.tar.gz /var/www/
RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	php7-ctype && \
 echo "**** unpack gitlist 1.0.2 ****" && \
 cd /var/www; tar -zxvf gitlist-1.0.2.tar.gz && \
 rm gitlist-1.0.2.tar.gz; \
 mkdir -p /repos/empty-repository; \
 cd /repos/empty-repository; \
 git init --bare
WORKDIR /config
COPY root/ /
EXPOSE 80 443
VOLUME /config
