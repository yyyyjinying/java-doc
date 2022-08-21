#!/bin/bash

docker compose stop
docker compose rm -f

rm -rf /root/sorf/mysql
mkdir -p /root/sorf/mysql/conf.d
mkdir -p /root/sorf/mysql/data

rm -rf /root/sorf/redis
mkdir -p /root/sorf/redis/conf
mkdir -p /root/sorf/redis/data

docker compose up -d
#docker exec -i mysql_container sh -c 'exec mysql -uroot -p"123456"' < ./all-databases.sql