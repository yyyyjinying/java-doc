### 安装rabbitmq
<!-- 1.创建一个新的镜像 -->
- sudo docker pull rabbitmq:3.8.8-management
<!-- 2.创建一个新的容器 -->
- sudo docker run -d --hostname my-rabbit --name rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3.8.8-management
<!-- 3.查看容器是否创建 -->
- sudo docker ps 
<!-- 4.进入指定容器 -->
- sudo docker exec -it rabbit /bin/bash
<!-- 5.容器内部管理 -->
- rabbitmq-plugins enable rabbitmq_management
- 默认用户名和密码 guest


sudo docker exec -it c482cc76e2aa /bin/bash
rabbitmq-plugins enable rabbitmq_management
[
rabbit, [{tcp_listeners, [5672]}, {loopback_users, [“asdf”]}]}
]


### 在rabbitmq中安装插件
 // sftp连接远程服务器
- sftp -P 22 root@172.16.147.172
// 上传文件到远程服务器
- put /Users/yyyyjinying/desktop/rabbitmq_delayed_message_exchange-3.9.0.ez /usr/local/tmp 
// 远程服务器将文件cp到rabbitmq容器plugins中
- sudo docker cp rabbitmq_delayed_message_exchange-3.9.0.ez rabbit:/plugins
  // 进入容器内
- sudo docker exec -it rabbit /bin/bash
  // 安装插件
- rabbitmq-plugins enable rabbitmq_delayed_message_exchange
  // 查看
- 是否有exchange交换机中是否有x-delayed-message选项

<!-- docker的NAMES:/etc/rabbitmq -->

### 添加一个新的用户
- rabbitmqctl add_user admin admin // 创建账号 账号/密码 admin
- rabbitmqctl set_user_tags admin administrator // 设置用户角色
### 设置用户权限
- set_permissions [-p <vhostpath>] <user> <conf> <write> <read>
- rabbitmqctl set_permissions -p "/" admin ".*" ".*" ".*"
  // 用户 user_admin 具有/vhost1 这个 virtual host 中所有资源的配置、写、读权限
- rabbitmqctl list_users // 查看用户

# 容器和镜像的关系
docker 的镜像概念类似虚拟机的镜像。是一个只读的模板，一个独立的文件系统，包括运行容器所需的数据，可以用来创建新的容器。
docker利用容器来运行应用：docker容器是由docker镜像创建的运行实例。 
docker容器类似虚拟机，可以执行包含启动，停止，删除等。每个容器间是相互隔离的。容器中会运行特定的运用，包含特定应用的代码及所需的依赖文件。可以把容器看作一个简易版的linux环境（包含root用户权限，进程空间，用户空间和网络空间等）和运行在其中的应用程序。

 
## 镜像管理
docker images：列出本地所有镜像
docker search <IMAGE_ID/NAME>：查找image
docker pull  <IMAGE_ID> ： 下载image
docker push <IMAGE_ID>：上传image
docker rmi <IMAGE_ID>：删除image

## 容器管理
<!-- 查看容器 -->
### docker ps
- `-all,-a`列出所有容器，默认显示运行中的容器
- `--filter, -f`根据条件过滤显示内容
<!-- 创建容器 -->
### 创建容器
- docker run -d -p 6379:6379 --name="myredis" redis
### 进入容器
- docker exec -it myredis /bin/bash
### 创建指定容器的开机启动项
<!-- docker update  --restart=always <NAMES> -->
- docker update  --restart=always myredis
  