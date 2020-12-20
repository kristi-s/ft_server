FROM	debian:buster

RUN 	apt-get update && apt-get upgrade -y && apt-get install -y wget gettext-base &&\
		apt-get install -y nginx && \
		apt-get install -y mariadb-server

RUN		apt-get install -y php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-zip

WORKDIR /var/www/droslyn
RUN		wget https://wordpress.org/latest.tar.gz && \
		tar -xf latest.tar.gz && rm -f latest.tar.gz 

COPY	/srcs/wp-config.php wordpress
RUN		chown -R www-data:www-data wordpress && \
 		chmod 775 -R wordpress && \
 		chmod 664 wordpress

WORKDIR /var/www
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
		tar -xf phpMyAdmin-5.0.4-all-languages.tar.gz && \
		mv phpMyAdmin-5.0.4-all-languages /var/www/droslyn/phpmyadmin && \
		rm -f phpMyAdmin-5.0.4-all-languages.tar.gz

WORKDIR /var/www/droslyn
COPY	/srcs/config.inc.php /var/www/droslyn/phpmyadmin

COPY	/srcs/nginx.conf /etc/nginx/sites-available/droslyn
RUN		ln -s /etc/nginx/sites-available/droslyn /etc/nginx/sites-enabled/ && \
		rm -f /etc/nginx/sites-enabled/default && \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-subj "/C=ru/ST=Moscow/L=Moscow/O=no/OU=no/CN=droslyn" \
		-keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

RUN service mysql start \
    && mysql -u root \
	&& mysql --execute="CREATE DATABASE wp_base; \
						GRANT ALL PRIVILEGES ON wp_base.* TO 'root'@'localhost'; \
						FLUSH PRIVILEGES; \
						UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='root';"

COPY	/srcs/start.sh .	 

EXPOSE	80 443

CMD sh start.sh
