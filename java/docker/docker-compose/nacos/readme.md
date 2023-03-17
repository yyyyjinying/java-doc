nacos/nacos-server:v2.2.0
# 执行
- docker run -d -p 8848:8848 -e MODE=standalone -e PREFER_HOST_MODE=hostname --name nacos nacos/nacos-server:v2.2.0
- docker cp nacos:/home/nacos/conf/application.properties ./
- docker cp nacos:/home/nacos/conf/mysql-schema.sql ./
  
- docker run -d -p 8848:8848 -e MODE=standalone -e PREFER_HOST_MODE=hostname -v /Users/yyyyjinying/sortware/nacos/application.properties:/home/nacos/conf/application.properties -v /Users/yyyyjinying/sortware/nacos/mysql-schema.sql:/home/nacos/conf/mysql-schema.sql --name nacos nacos/nacos-server:v2.2.0
  
- docker-compose -f nacos-standalone-docker-compose.yaml up -d
- 查看
- http://127.0.0.1:8848/nacos/

# docker文件夹
docker -v 映射文件可以在本地没有文件夹的情况新建并建立联系；
文件的映射需要一一对应，本地没有和容器中没有两者必须同时存在；


application.properties         mysql-schema.sql