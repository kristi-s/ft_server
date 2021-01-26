# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: droslyn <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/26 15:33:26 by droslyn           #+#    #+#              #
#    Updated: 2021/01/26 15:39:22 by droslyn          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	debian:buster

RUN 	apt-get update && apt-get -y upgrade && apt-get install -y wget && \
		apt-get install -y nginx && \
		apt-get install -y mariadb-server

RUN		apt-get install -y php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-zip

WORKDIR /var/www/droslyn
RUN		wget https://wordpress.org/latest.tar.gz && \
		tar -xf latest.tar.gz && rm -f latest.tar.gz 

COPY	/srcs/wp-config.php wordpress
RUN		chown -R www-data:www-data wordpress

WORKDIR /var/www
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
		tar -xf phpMyAdmin-5.0.4-all-languages.tar.gz && \
		mv phpMyAdmin-5.0.4-all-languages /var/www/droslyn/phpmyadmin && \
		rm -f phpMyAdmin-5.0.4-all-languages.tar.gz

WORKDIR /var/www/droslyn
COPY	/srcs/config.inc.php /var/www/droslyn/phpmyadmin
COPY	/srcs/autoindex_change.sh /var/www/droslyn

COPY	/srcs/droslyn /etc/nginx/sites-available/droslyn
COPY	/srcs/copy /etc/nginx/file
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
