FROM ubuntu:16.04

RUN apt-get update && apt-get install -y wget zip apache2 php libapache2-mod-php php-mcrypt php-mysql libapache2-mod-php php7.0-mbstring

WORKDIR "deploy-test"

RUN mkdir ssmtp.conf && mkdir mysql && mkdir revaliases

RUN wget https://builds.piwik.org/piwik.zip && unzip piwik.zip && rm piwik.zip

RUN rm /var/www/html/index.html && mv piwik/* /var/www/html/

RUN chmod a+w /var/www/html/tmp
RUN chmod a+w /var/www/html/config

COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN a2enmod ssl
RUN a2ensite default-ssl.conf

CMD ["sh", "-c", "apachectl -e info -DFOREGROUND"]

