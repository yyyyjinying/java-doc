# 命令行安装docker的mysql
自动创建数据卷mysqldata以及本地磁盘映射
- docker run --name mysql -v /root/sorf/mysql/conf.d:/etc/mysql/conf.d -v mysqldata:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8
- 查看数据库信息
- docker volume inspect mysqldata

- docker exec mysql sh -c 'exec mysqldump --all-databases -uroot -p"123456"' > /root/all-databases.sql
- docker exec -i mysql sh -c 'exec mysql -uroot -p"123456"' < /root/all-databases.sql
- docker exec -i mysql_container sh -c 'exec mysql -uroot -p"123456"' < ./all-databases.sql
<!-- - docker exec -i mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < /some/path/on/your/host/all-databases.sql -->