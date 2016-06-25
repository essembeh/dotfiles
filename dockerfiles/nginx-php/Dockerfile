FROM debian:jessie
MAINTAINER Sébastien MB <seb@essembeh.org>


RUN apt-get update && apt-get install -y \
	nginx-full php5-fpm php5-cli php5-mysql php5-curl php5-gd php5-gmp php5-json zip wget curl \
	&& rm -rf /var/lib/apt/lists/*

COPY default /etc/nginx/sites-available/

EXPOSE 80 443
VOLUME /var/www/html/

CMD ["bash", "-c", "service php5-fpm start && /usr/sbin/nginx -g 'daemon off;'"]
