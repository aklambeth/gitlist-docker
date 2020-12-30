FROM lsiobase/ubuntu:xenial 
RUN apt-get update
RUN apt-get install -y software-properties-common \
 && apt-add-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get -y install git nginx-full php7.4-fpm curl
ADD https://s3.amazonaws.com/gitlist/gitlist-master.tar.gz /var/www/
RUN cd /var/www; tar -zxvf gitlist-master.tar.gz
RUN chmod -R 777 /var/www/gitlist
RUN cd /var/www/gitlist/; mkdir cache; chmod 777 cache
WORKDIR /var/www/gitlist/
ADD config.ini /var/www/gitlist/
ADD nginx.conf /etc/
ADD www.conf /etc/php/7.4/fpm/pool.d/
RUN mkdir -p /repos/sentinel
RUN cd /repos/sentinel; git --bare init .

CMD service php7.4-fpm start; nginx -c /etc/nginx.conf


