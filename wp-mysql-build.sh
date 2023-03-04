#!/bin/bash

MYSQL_ROOT_PASSWORD=thisisadummyRooTpassword!99887
MYSQL_DATABASE=wp_docker
MYSQL_USER=wp_user
MYSQL_PASSWORD=thisIsaDummyPassword!34534

sudo docker run --name wp-mysql -v /var/wp-mysql/mysql-data:/var/lib/mysql -v tempwpfiles:/docker-entrypoint-initdb.d -p 3306:3306 -d \
 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
 -e MYSQL_DATABASE=$MYSQL_DATABASE \
 -e MYSQL_USER=$MYSQL_USER \
 -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  mysql:8.0.29  --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
