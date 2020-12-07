# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: droslyn <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/06 16:34:52 by droslyn           #+#    #+#              #
#    Updated: 2020/12/08 01:58:57 by droslyn          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# If you do not want to use the cache at all, you can use the --no-cache=true option on the docker build command.
# --publish 8000:8080

FROM	debian:buster

RUN 	apt-get update && apt-get upgrade -y && apt-get install -y nano wget gettext-base

RUN 	apt-get install -y nginx
RUN		apt-get install -y mariadb-server
#RUN		apt-get install -y php7.3 php-mysql php-fpm php-cli php-mbstring php-zip php-gda

#PHPMYADMIN
RUN		apt-get install -y php-mbstring php-zip php-gd php-curl php-json php-gettext php-xml php-phpseclib



RUN		mkdir -p /var/lib/phpmyadmin/tmp && \
		mkdir /usr/share/phpmyadmin && \
		chown -R www-data:www-data /var/lib/phpmyadmin
		 

EXPOSE	80 443

# можно использовать только одну CMD, остальные будут проигнорированы
CMD
