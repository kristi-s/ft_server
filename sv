# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: droslyn <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/06 16:34:52 by droslyn           #+#    #+#              #
#    Updated: 2020/12/08 22:44:25 by droslyn          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# If you do not want to use the cache at all, you can use the --no-cache=true option on the docker build command.
# --publish 8000:8080

FROM	debian:buster

RUN 	apt-get update && apt-get upgrade -y && apt-get install -y nano wget gettext-base

RUN 	apt-get install -y nginx
RUN		apt-get install -y mariadb-server
# php-fpm нужен для nginx (менеджер процессов fastCGI), php-mysql - вспомогательный пакет, 
#который позволит PHP взаимодействовать с серверной частью БД.
# php-cli - command line interface	
# php-mbstring - нужен для работы с разными кодировками
# php-gd - графическая библиотека
# php-cURL - библиотека для передачи данных по протоколам HTTP, FTP, HTTPS

RUN		apt-get install -y php-fpm php-mysql php-cli php-curl  php-gd php-mbstring php-zip
#php7.3 php-json php-gettext php-xml php-phpseclib
WORKDIR /var/www/droslyn
RUN		wget https://wordpress.org/latest.tar.gz && \
		tar -xf latest.tar.gz && rm -f latest.tar.gz && \
		rm -f wordpress/wp-config.php
COPY	/srcs/wp-config.php wordpress
RUN		chown -R www-data:www-data wordpress && \
		chmod 755 -R wordpress && \
		chmod 644 wordpress

RUN		mkdir -p /var/lib/phpmyadmin/tmp && \
		mkdir /usr/share/phpmyadmin && \
		chown -R www-data:www-data /var/lib/phpmyadmin && \
		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
		tar -xf phpMyAdmin-5.0.4-all-languages.tar.gz -C /usr/share/phpmyadmin --strip-components 1 && \
		rm -f phpMyAdmin-5.0.4-all-languages.tar.gz
COPY	/srcs/config.inc.php /var/www/droslyn/phpmyadmin
# необходимо заменить файл с конфигурациями по адресу /etc/nginx/sites-available/....com
# после этого, для активации нового серверного блока создаем символическую ссылку на новый файл
#конфигурации серверного блока

COPY	/srcs/nginx.conf /etc/nginx/sites-available/nginx.conf

RUN		ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

RUN		unlink /etc/nginx/sites-enabled/default
		# rm -f /etc/nginx/sites-enabled/default

RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-subj "/C=ru/ST=Moscow/L=Moscow/O=no/OU=no/CN=droslyn" \
		-keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
COPY	/srcs/start.sh .

	
# перезагрузить Nginx
# systemctl reload nginx	 

EXPOSE	80 443

# можно использовать только одну CMD, остальные будут проигнорированы
CMD bash start.sh







192.168.99.102