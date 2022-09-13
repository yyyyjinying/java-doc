# 中文参考手册
- https://docker_practice.gitee.io/zh-cn
# docker 安装docker
## 安装存储库
- sudo yum install -y yum-utils
- sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
## 安装 Docker 引擎
- sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
##  查看 Docker引擎版本
- yum list docker-ce --showduplicates | sort -r
- sudo yum install docker-ce-20.10.7 docker-ce-cli-20.10.7 containerd.io docker-compose-plugin
## 启动docker
- sudo systemctl start docker
## 是否成功
- sudo docker run hello-world   
### 开启服务
- sudo systemctl start docker
### 开机自动启动
- sudo systemctl enable docker // 开机启动docker
- sudo docker update  --restart=always rabbit // docker启动开启rabbit


# 镜像的相关内容
- 拉去远程仓库的镜像
- sudo docker pull name:TAG
- 默认拉去latest版本 
- 镜像是由若干层组成的，每层都有唯一ID，有相同层只会保留一个，减少存储空间。

# 镜像代理服务来加快镜像的获取
- --registry-mirror=proxy_url

# 查看景象
- docker images
- docker image ls
- 给镜像添加别名,方便调用
- docker tag df5de72bdb3b ub:latest
- 查看镜像的详细内容
- docker inspect ub
- 查看镜像的历史
- docker history ub 
- 搜索镜像
- docker search nginx
- 删除镜像
- docker rmi 镜像ID/name:tag
- docker rmi -f 镜像ID/name:tag   // 强制删除镜像即使有容器依赖镜像
- 镜像清理
- docker image prune
- -f 强制清理
- -a 删除无用的镜像

# 创建镜像
## 基于容器创建镜像
- docker commit -m "提交信息" -a "作者" 容器ID 镜像name:TAG
## 基于本地模版导入
## 基于Dockerfile创建镜像

# 存出镜像
<!-- save -->
- sudo docker save -o ubuntu_18.04.tar ubuntu:18.04
  
# 存入镜像
- sudo docker load < ubuntu_18.04.tar

# 上传镜像到docker hub仓库
- docker login
- 输入账号密码
- docker tag tu:0.1 <注册用户名zhaojinying>/tu
- docker push zhaojinying/tu
- docker pull zhaojinying/tu

# 创建容器
容器是镜像的一个运行实例，提供应用服务的组件，镜像是静态的只读文件；
- -t 分配一个伪终端
- -i 保持标准输入打开
- 查看所有的容器
- docker container ls
- docker ps -a
- sudo docker run -it ubuntu bash
- exit // 退出容器
- 删除一个容器
- docker rm id

# 查看容器日志
- -t 参数显示时间
- docker logs 130857a0e128 -t
- docker logs -f 130857a0e128

# 暂停/开始
- docker pause 130857a0e128
- docker unpause 130857a0e128

# stop
- docker stop 130857a0e128
- docker start 130857a0e128

# restart 先stop在start
- docker restart 130857a0e128

# 删除所有停止的容器
- docker container prune

# 在后台运行容器
- docker run -dit zhaojinying/tu
# 进入后台运行容器 
打开一个bash终端，不影响容器运行的情况下执行
- docker exec -it 3c66c696cb8a /bin/bash

# 删除运行中的容器
- docker rm -f 3c66c696cb8a
- 强制删除所有的容器
- docker rm -f $(docker ps -aq)

# 导出容器
- docker export -o test_tu.tar ce5
- docker export ce5 >test_tu01.tar
  
# 导入容器
- docker import test_tu.tar test/tu:v1.0

# 查看容器详情
- docker container inspect e62aab67197d

# cp指令
- docker cp data test:/temp

# diff命令查看容器内文件系统内的变更
- docker container diff 容器ID

# 查看端口映射
- docker container port e62aab67197d
  
# 重置
- docker update 

# 数据卷
## 快速在本地创建一个数据卷
- docker volume create -d local test1
- ls /var/lib/docker/volumes/
- - test1

## 数据卷容器
- docker volume ls
- docker volumn // 自动打开help
- docker volume create web-vol
- docker volume inspect web-vol
- ls /var/lib/docker/volumes/web-vol/_data  // 默认数据卷的存放位置
- 可以默认创建数据卷 web-vol1
- docker volume prune 删除无用的数据卷
- docker run -d -p 8086:80 --name web1 -v web-vol1:/usr/share/nginx/html nginx
- docker run -it -v /dbdata --name dbdata tu:0.1
- - docker run -it --volumes-from --name db1 tu:0.1
- - docker run -it --volumes-from --name db2 tu:0.1
- docker run参数-v的rw、ro详解

- docker volume create 数据卷名称
- docker volume inspect 数据卷名称。// 查看数据卷
- docker volume ls // 查看全部数据卷
- docker volume rm 数据卷名称
- docker run -d -P --name web --link db:db training/webapp python app.py
- - link name:alias


# sftp连接远程服务器
- sftp root@172.16.147.172
## 上传文件到远程服务器
- put /Users/yyyyjinying/desktop/rabbitmq_delayed_message_exchange-3.9.0.ez /usr/local/tmp 
## 在远程服务器将文件拷贝到docker容器
- docker cp a.html nginx-test:/data/www
# 在宿主机和容器之间交换文件
- docker cp tomcat-8808:/usr/local/tomcat/webapps/ROOT/index.html ./
- docker cp index.html tomcat-8808:/usr/local/tomcat/webapps/ROOT
