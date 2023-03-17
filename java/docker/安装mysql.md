# mysql安装
- docker pull mysql:8
- docker run -d --name mysql8-3306 -p 3306:3306 -e MYSQL_ROOT_PASSWORD='123456' mysql:8
- mysql -u root -p
- 123456
# 授权其他机器登陆 然后执行以下命令，授权完后直接就可以远程连接上。
mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; //赋予任何主机上以root身份访问数据的权限
mysql>FLUSH PRIVILEGES;
# 退出
- EXIT;

# navicat连接测试
- 172.16.147.184
- 123456

 ```yml
version: '3.1'
services:
  mysql:
    restart: always
    image: mysql:8
    container_name: mysql8-3306
    ports:
      - 3306:3306
    environment:
      MYSQL_ROOT_PASSWORD: mogu2018
    volumes:
      - ../data/mysql_data:/var/lib/mysql
    networks:
      - mogu

networks:
  mogu:
    external: true


 ```

 see https://docs.docker.com/compose/compose-file/