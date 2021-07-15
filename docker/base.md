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