FROM essembeh/nginx-php
MAINTAINER Sébastien MB <seb@essembeh.org>

RUN wget -q  https://github.com/FreshRSS/FreshRSS/archive/master.tar.gz -O - | tar -xz -C /var/www/
RUN chown -R www-data:www-data /var/www/
COPY default /etc/nginx/sites-available/

