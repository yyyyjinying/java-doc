# 将准备好的iso映像系统拖入，选择安装方法的框中安装
![car](./imgs/1.jpg)
# 默认的linux最小化安装是没有ifconfig的，需要安装ifconfig
- yum install ifconfig
- 如果没有安装包
- yum search ifconfig
- yum install net-tools.x86_64 -y
- ifconfig
- ifconfig ens33
- ssh root@172.16.147.193

# 防火墙
`查看防火墙是否开启`
- firewall-cmd --list-ports
`添加防火墙端口`
- firewall-cmd --zone=public --add-port=8081/tcp --permanent
- firewall-cmd --zone=public --add-port=8082/tcp --permanent
`重启防火墙`
- firewall-cmd --reload