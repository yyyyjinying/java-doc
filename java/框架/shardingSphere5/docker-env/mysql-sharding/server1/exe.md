docker run -d \
-p 3303:3306 \
-v /Users/yyyyjinying/demo-file/git/java-doc/java/框架/shardingSphere5/docker-env/mysql-sharding/server1/conf:/etc/mysql/conf.d \
-v /Users/yyyyjinying/demo-file/git/java-doc/java/框架/shardingSphere5/docker-env/mysql-sharding/server1/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
--name server-order-1 \
mysql:8.0.29

docker exec -it server-order-1 env LANG=C.UTF-8 /bin/bash
mysql -h 192.168.1.3 -P 3303 -u root -p