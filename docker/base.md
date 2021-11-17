### 如果无法获取虚拟机IP
- sudo dhclient ens33
- ifconfig -a

### 开机启动
- sudo docker update  --restart=always kibana
- docker run // 创建一个新的容器并运行一个命令

### docker默认安装目录:/var/lib/docker
### docker安装redis
- sudo docker pull redis
  
- ### mac中，只有在docker服务启动了之后，才可以在终端使用docker命令
- systemctl restart docker
- docker ps // 列出正在运行的容器
- docker ps -a // 列出所有的容器
- docker images // 查看镜像
- // 删除镜像时，先删除容器，
- docker rm ID
- // 删除镜像
- docker rmi ID
- 
- - -i: 交互式操作
- - -t: 终端
- - /bin/bash：放在镜像名后的是命令，这里我们希望有个交互式 Shell，因此用的是 /bin/bash
- // 后台创建一个容器(但没有执行)
- sudo docker run -d -p 9200:9200 -p 9300:9300 --name elasticsearch elasticsearch
- docker ps -a // 查看创建的容器
- // 运行指定容器
- docker start elasticsearch
- docker ps // 查看运行容器
- sudo docker run -di --name=changgou_elasticsearch -p 9200:9200 -p 9300:9300 elasticsearch
### 安装docker的远程镜像
- vim /etc/docker/daemon.json
- sudo systemctl daemon-reload 
- sudo systemctl restart docker 
  
- docker images 来列出本地主机上的镜像。
- docker run -t -i ubuntu:15.10 /bin/bash  // 交互式 终端 
- tcp端口和udp端口
- docker exec -it storage /bin/bash
- cd /etc/nginx


### 安装docker
- sudo apt install curl
- sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
- docker -v

- // 查看当前启动的容器
- sudo docker ps
- -it // 以 交互模式启动  
- -p 8009:80 // 指将外部访问8009映射到内部的80端口
- -d // 附加进程方式启动  
- // 关闭容器的限时，如果超时未能关闭则用kill强制关闭，默认值10s，这个时间用于容器的自己保存状态
- docker stop -t=60 容器ID或容器名
- docker kill 容器ID或容器名 // 直接关闭容器
- docker rm [NAME/CONTAINER ID]  // 删除一个容器

### elasticsearch
- sudo docker pull elasticsearch:5.6.8 // 镜像下载
- // 安装es容器
- sudo docker run -di --name=changgou_elasticsearch -p 9200:9200 -p 9300:9300 elasticsearch:5.6.8
- // 登录容器
- sudo docker exec -it changgou_elasticsearch /bin/bash
- // 查看目录
- dir
- 进入config目录
- cd config
- vi elasticsearch.yml
- 
- // docker安装vim编辑器
- apt-get update
- apt-get install vim

- vi elasticsearch.yml
- - transport.host: 0.0.0.0
- - cluster.name: my-application
- - http.cors.enabled: true
- - http.cors.allow-origin: "*"
  
- sudo unzip elasticsearch-analysis-ik-5.6.8.zip
。 mac中，只有在docker服务启动了之后，才可以在终端使用docker命令
- docker ps // 列出正在运行的容器
- docker ps -a // 列出所有的容器
- docker images // 查看镜像
- // 删除镜像时，先删除容器，
- docker rm ID
- // 删除镜像
- docker rmi ID
- 
- - -i: 交互式操作
- - -t: 终端
- - /bin/bash：放在镜像名后的是命令，这里我们希望有个交互式 Shell，因此用的是 /bin/bash
- // 后台创建一个容器(但没有执行)
- sudo docker run -d -p 9200:9200 -p 9300:9300 --name elasticsearch elasticsearch
- docker ps -a // 查看创建的容器
- // 运行指定容器
- docker start elasticsearch
- docker ps // 查看运行容器
- sudo docker run -di --name=changgou_elasticsearch -p 9200:9200 -p 9300:9300 elasticsearch
### 安装docker的远程镜像
- vim /etc/docker/daemon.json
- sudo systemctl daemon-reload 
- sudo systemctl restart docker 
  
- docker images 来列出本地主机上的镜像。
- docker run -t -i ubuntu:15.10 /bin/bash  // 交互式 终端 
- tcp端口和udp端口
- docker exec -it storage /bin/bash
- cd /etc/nginx


### 安装docker
- sudo apt install curl
- sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
- docker -v

- // 查看当前启动的容器
- sudo docker ps
- -it // 以 交互模式启动  
- -p 8009:80 // 指将外部访问8009映射到内部的80端口
- -d // 附加进程方式启动 
- -e // 指定容器环境变量 
- // 关闭容器的限时，如果超时未能关闭则用kill强制关闭，默认值10s，这个时间用于容器的自己保存状态
- docker stop -t=60 容器ID或容器名
- docker kill 容器ID或容器名 // 直接关闭容器
- docker rm [NAME/CONTAINER ID]  // 删除一个容器

### elasticsearch
- sudo docker pull elasticsearch:5.6.8 // 镜像下载
- // 安装es容器
- sudo docker run -di --name=changgou_elasticsearch -p 9200:9200 -p 9300:9300 elasticsearch:5.6.8
- // 登录容器
- sudo docker exec -it changgou_elasticsearch /bin/bash
- // 查看目录
- dir
- 进入config目录
- cd config
- vi elasticsearch.yml
- 
- // docker安装vim编辑器
- apt-get update
- apt-get install vim

- vi elasticsearch.yml
- - transport.host: 0.0.0.0
- - cluster.name: my-application
- - http.cors.enabled: true
- - http.cors.allow-origin: "*"
  
- sudo unzip elasticsearch-analysis-ik-5.6.8.zip
- mv elasticsearch ik // 修改名称    
- sudo docker cp ./ik changgou_elasticsearch:/usr/share/elasticsearch/plugins
#### (2)IK分词器测试
- http://172.16.147.158:9200/_analyze?analyzer=ik_smart&pretty=true&text=我是程序员
- http://172.16.147.158:9200/_analyze?analyzer=ik_max_word&pretty=true&text=我是程序员
### (2)安装kibana容器
- sudo docker pull docker.io/kibana:5.6.8
- sudo docker run -it -d --name kibana --restart=always -p 5601:5601 kibana:5.6.8
- sudo docker run -it -d -e ELASTICSEARCH_URL=http://172.16.147.158:9200 --name kibana --restart=always -p 5601:5601 kibana:5.6.8

http://172.16.147.159:5601/app/kibana#/management?_g=()
### 动态更新容器配置
- sudo docker update  --restart=always kibana
sudo docker stop kibana
sudo docker rm kibana
sudo docker run -it -d -e ELASTICSEARCH_URL=http://172.16.147.158:9200 --name kibana --restart=always -p 5601:5601 kibana:5.6.8


## ip 192.168.200.14  // N108-5.0
## 虚拟机 IP 172.16.147.133  // 172.16.147.138

## 重启nginx
- sudo docker exec -it storage bash
- ps -ef|grep nginx  // 查看进程
- 重启 /etc/nginx/sbin/nginx -s reload
- vi /etc/nginx/conf/nginx.conf

## 文件服务器重新替换IP  
- ifconfig 查看mac系统的IP - eno:inet 192.168.200.15
- ifconfig 查看ubuntu的ip - ens33:inet
- 替换 fdfs_client.conf中的IP地址
- 拷贝执行
sudo docker stop storage && sudo docker stop tracker && sudo docker rm storage && sudo docker rm tracker && sudo docker run -d --name tracker --net=host morunchang/fastdfs sh tracker.sh && sudo docker run -d --name storage --net=host -e TRACKER_IP=172.16.147.141:22122 -e GROUP_NAME=group1 morunchang/fastdfs sh storage.sh && sudo docker update --restart=always tracker &&
 sudo docker update --restart=always storage

### 安装FastDFS
- docker pull morunchang/fastdfs
- docker run -d --name tracker --net=host morunchang/fastdfs sh tracker.sh
- docker run -d --name storage --net=host -e TRACKER_IP=172.16.147.138:22122 -e GROUP_NAME=group1 morunchang/fastdfs sh storage.sh
- docker update --restart=always tracker
- docker update --restart=always storage
- reboot // 重启测试
- sudo docker ps
- 
- docker exec -it storage  /bin/bash
- vi /etc/nginx/conf/nginx.conf
- exit
- docker restart storage

- su
- 123
- $
- exit
docker run -d --name storage --net=host -e TRACKER_IP=172.16.147.133:22122 -e GROUP_NAME=group1 morunchang/fastdfs sh storage.sh
http://172.16.147.133/
docker run -d --name storage --net=host -e TRACKER_IP=172.16.147.133:22122 -e GROUP_NAME=group1 morunchang/fastdfs sh storage.sh

### Ubuntu管理防火墙
- sudo ufw status
- sudo ufw allow 5000
- sudo ufw reload
  
### 网络适配器
- bridged（桥接模式）、NAT（网络地址转换模式）和host-only（主机模式）
- NAT模式
  - 使用NAT模式，就是让虚拟机借助NAT（网络地址转换）功能，通过宿主机器所在的网络来访问公网。也就是说，使用NAT模式可以实现在虚拟系统里访问互联网。NAT模式下的虚拟机的TCP/IP配置信息是由VMnet8虚拟网络的DHCP服务器提供的，因此IP和DNS一般设置为“自动获取”，因此虚拟系统也就无法和本局域网中的其他真实主机进行通讯。采用NAT模式最大的优势是虚拟系统接入互联网非常简单，你不需要进行任何其他的配置，只需要宿主机器能访问互联网即可。如果你想利用VMWare安装一个新的虚拟系统，在虚拟系统中不用进行任何手工配置就能直接访问互联网，建议你采用NAT模式。Nat模式中使用Vmnet8虚拟交换机，此时虚拟机可以通过主机“单向访问”网络上的其他主机，其他主机不能访问虚拟机。
- 桥接模式
  - 在这种模式下，使用VMnet0虚拟交换机，虚拟操作系统就像是局域网中的一台独立的主机，与宿主计算机一样，它可以访问网内任何一台机器。在桥接模式下，可以手工配置它的TCP/IP配置信息（IP、子网掩码等，而且还要和宿主机器处于同一网段），以实现通过局域网的网关或路由器访问互联网；还可以将IP地址和DNS设置成“自动获取”。如果你想利用VMWare在局域网内新建一个服务器，为局域网用户提供Web或网络服务，就应该选择桥接模式。在桥接模式中，使用VMnet0虚拟交换机，此时虚拟机相当与网络上的一台独立计算机与主机一样，拥有一个独立的IP地址。LAN1、LAN2、CentOS7.5虚拟机1、CentOS7.5虚拟机2四个操作系统可以相互访问
- 仅主机模式
  - 在host-only模式中，虚拟机只能与虚拟机、主机互访，但虚拟机和外部的网络是被隔离开的，也就是不能上Internet