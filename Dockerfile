FROM ubuntu:16.04
MAINTAINER Saurabh Agrawal

#Install Nginx

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-add-repository -y ppa:nginx/stable \
    && apt-get update \
    && apt-get install geoip-database-extra libgeoip1 libnginx-mod-http-geoip wget gunzip -y \
    && cd /usr/share/GeoIP \
    && mv GeoIP.dat GeoIP.dat.bak \
    && wget https://dl.miyuru.lk/geoip/maxmind/country/maxmind.dat.gz \
    && gunzip maxmind.dat.gz \
    && mv maxmind.dat GeoIP.dat \
    && mv GeoIPCity.dat GeoIPCity.dat.bak \
    && wget https://dl.miyuru.lk/geoip/maxmind/city/maxmind.dat.gz \
    && gunzip maxmind.dat.gz \
    && mv maxmind.dat GeoIPCity.dat \
    && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

ADD data/www /data/www

RUN rm /etc/nginx/sites-enabled/default

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
