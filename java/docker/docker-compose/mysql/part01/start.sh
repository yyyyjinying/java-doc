#!/bin/bash

docker compose stop
docker compose rm -f

rm -rf /root/sorf/mysql
mkdir -p /root/sorf/mysql/conf.d
mkdir -p /root/sorf/mysql/data

#rm -rf /root/sorf/nginx/conf
#mkdir -p /root/sorf/nginx/conf
#mkdir -p /root/sorf/nginx/templates
#mkdir -p /root/sorf/nginx/html
rm -rf /root/sorf/nginx/log
rm -rf /root/sorf/nginx/cache
mkdir -p /root/sorf/nginx/log
mkdir -p /root/sorf/nginx/cache

# 添加默认配置文件default.conf
# cp /root/sorf/default.conf /root/sorf/nginx/conf
# /root/sorf/nginx/templates/default.conf.template
docker compose up -d
#docker exec -i mysql_container sh -c 'exec mysql -uroot -p"123456"' < ./all-databases.sql