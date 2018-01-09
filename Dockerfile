FROM debian:stable
MAINTAINER Antonio Manuel Jiménez Martínez <homomagnus@gmail.com>

RUN apt-get update && apt-get -y install apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork
RUN apt-get update && apt-get -y install php php-mysql libapache2-mod-php && apt-get clean && rm -r /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

EXPOSE 80
EXPOSE 443

RUN rm /var/www/html/index.html
COPY contenedores/index.php /var/www/html/
COPY contenedores/index.php /var/www/html/status/

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
