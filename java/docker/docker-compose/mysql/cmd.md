# 命令行安装docker的mysql
- docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8
- docker exec -it mysql bash
- mkdir -p /root/sorf/mysql 
- cd /root/sorf/mysql
- docker cp mysql:/etc/mysql/conf.d ./
- touch mysql.cnf
- vi mysql.cnf
- 
```cnf
[client]
default-character-set=utf8mb4


[mysql]
default-character-set=utf8mb4

[mysqld]
init_connect='SET NAMES utf8mb4'
character-set-server=utf8mb4

```
默认执行当前docker-compose.yml
- docker compose up -d
# mysql -u root -p
- show variables like 'character%';
  
- docker run --name mysql -v /root/sorf/mysql/conf.d:/etc/mysql/conf.d -v /root/sorf/mysql/data/mysql:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8
- 查看数据库信息
- docker volume inspect mysqldata

- docker exec mysql sh -c 'exec mysqldump --all-databases -uroot -p"123456"' > /root/all-databases.sql
- docker exec -i mysql sh -c 'exec mysql -uroot -p"123456"' < /root/all-databases.sql
- docker exec -i mysql_container sh -c 'exec mysql -uroot -p"123456"' < ./all-databases.sql
<!-- - docker exec -i mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < /some/path/on/your/host/all-databases.sql -->