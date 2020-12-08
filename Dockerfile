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
# php-fpm нужен для nginx (менеджер процессов fastCGI), php-mysql - вспомогательный пакет, который позволит PHP взаимодействовать с серверной частью БД.
#RUN		apt-get install -y php7.3 php-mysql php-fpm php-cli php-mbstring php-zip php-gda

RUN		apt-get install -y php-fpm php-mysql
#php-mbstring php-zip php-gd php-curl php-json php-gettext php-xml php-phpseclib



RUN		mkdir -p /var/lib/phpmyadmin/tmp && \
		mkdir /usr/share/phpmyadmin && \
		chown -R www-data:www-data /var/lib/phpmyadmin && \
		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
		tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz -C /usr/share/phpmyadmin --strip-components 1 && \

# необходимо заменить файл с конфигурациями по адресу /etc/nginx/sites-available/....com
# после этого, для активации нового серверного блока создаем символическую ссылку на новый файл
#конфигурации серверного блока
RUN		ln -s /etc/nginx/sites-available/my_config_nginx /etc/nginx/sites-enabled/ && \
		unlink /etc/nginx/sites-enabled/default
		
# перезагрузить Nginx
# systemctl reload nginx	 

EXPOSE	80 443

# можно использовать только одну CMD, остальные будут проигнорированы
CMD
