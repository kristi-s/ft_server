#!/bin/bash
service nginx start
service mysql restart
service php7.3-fpm start
cp /var/www/html/index.nginx-debian.html /var/www/droslyn
bash
