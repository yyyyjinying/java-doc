docker run -d \
-p 3302:3306 \
-v /Users/yyyyjinying/demo-file/git/java-doc/java/框架/shardingSphere5/docker-env/mysql-sharding/server/conf:/etc/mysql/conf.d \
-v /Users/yyyyjinying/demo-file/git/java-doc/java/框架/shardingSphere5/docker-env/mysql-sharding/server/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
--name server-order \
mysql:8.0.29

mysql -h 192.168.1.3  -P 3302 -u root -p