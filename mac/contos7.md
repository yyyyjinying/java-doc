### 查看ip
- vi /etc/sysconfig/network-scripts/ifcfg-ens33
```js
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=ens33
UUID=b67047c1-4b91-4857-a933-11405005d60c
DEVICE=ens33
ONBOOT=yes
```
- systemctl restart network.service
- ping 192.168.1.5 // 看是否能拼通
- 如果能拼通查询ens33
- ifconfig ens33
- ip addr show dev ens33

# 防火墙
`查看防火墙是否开启`
- firewall-cmd --list-ports
`添加防火墙端口`
- firewall-cmd --zone=public --add-port=8081/tcp --permanent
- firewall-cmd --zone=public --add-port=8082/tcp --permanent
`重启防火墙`
- firewall-cmd --reload
### 开启服务
- sudo systemctl start docker

### 开机自动启动
- sudo systemctl enable docker // 开机启动docker
- sudo docker update  --restart=always rabbit // docker启动开启rabbit

### docker 命令
- docker run // 创建一个新的容器并运行一个命令