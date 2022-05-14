# docker 操作文件
// 拷贝文件到本地
- docker cp b0bcab97521c:conf/zoo.cfg zoo.cfg
 
// 拷贝本地到容器
- docker cp zoo.cfg b0bcab97521c:conf/zoo.cfg

## 安装docker-compose
- curl -L "https://github.com/docker/compose/releases/download/1.28.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 配置zookeeper集群
## 1.网络配置
docker network create -d bridge zk-net
## 2.创建文件夹
- mkdir /usr/local/docker/zookeeper/zk1
- mkdir /usr/local/docker/zookeeper/zk2
- mkdir /usr/local/docker/zookeeper/zk3
- mkdir /usr/local/docker/zookeeper/docker-compose.yml
- vi docker-compose.yml 

### 2.1配置docker-compose.yml
```yml
version: '3.7'

# 给zk集群配置一个网络，网络名为zk-net
networks:
  zk-net:
    name: zk-net

# 配置zk集群的
# container services下的每一个子配置都对应一个zk节点的docker container
services:
  zk1:
    # docker container所使用的docker image
    image: zookeeper
    hostname: zk1
    container_name: zk1
    # 配置docker container和宿主机的端口映射
    ports:
      - 2181:2181
      - 8081:8080
    # 配置docker container的环境变量
    environment:
      # 当前zk实例的id
      ZOO_MY_ID: 1
      # 整个zk集群的机器、端口列表
      ZOO_SERVERS: server.1=0.0.0.0:2888:3888;2181 server.2=zk2:2888:3888;2181 server.3=zk3:2888:3888;2181
    # 将docker container上的路径挂载到宿主机上 实现宿主机和docker container的数据共享
    volumes:
      - ./zk1/data:/data
      - ./zk1/datalog:/datalog
    # 当前docker container加入名为zk-net的隔离网络
    networks:
      - zk-net
  zk2:
    image: zookeeper
    hostname: zk2
    container_name: zk2
    ports:
      - 2182:2181
      - 8082:8080
    environment:
      ZOO_MY_ID: 2
      ZOO_SERVERS: server.1=zk1:2888:3888;2181 server.2=0.0.0.0:2888:3888;2181 server.3=zk3:2888:3888;2181
    volumes:
      - ./zk2/data:/data
      - ./zk2/datalog:/datalog
    networks:
      - zk-net

  zk3:
    image: zookeeper
    hostname: zk3
    container_name: zk3
    ports:
      - 2183:2181
      - 8083:8080
    environment:
      ZOO_MY_ID: 3 
      # server.A=B:C:D  A：是一个数字，表示这个是第几号服务器；B：是这个服务器的地址；C：follower和leader的服务器交换信息端口；D：，而这个端口就是用来执行选举时服务器相互通信的端口；
      ZOO_SERVERS: server.1=zk1:2888:3888;2181 server.2=zk2:2888:3888;2181 server.3=0.0.0.0:2888:3888;2181
    volumes:
      - ./zk3/data:/data
      - ./zk3/datalog:/datalog
    networks:
      - zk-net
```
- docker-compose up -d
  ![car](./imgs/11.png)
## 3.查看结果是否配置成功
- http://172.16.147.184:8081/commands/stats
- "server_state" : "follower",
- http://172.16.147.184:8082/commands/stats
- "server_state" : "follower",
- http://172.16.147.184:8083/commands/stats
- "server_state" : "leader",

