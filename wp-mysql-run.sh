#!/bin/bash

sudo docker run --name wp-mysql -v /var/wp-mysql/mysql-data:/var/lib/mysql -p 3306:3306 -d \
 --restart unless-stopped \
  mysql:8.0.29  --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci