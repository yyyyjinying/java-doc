### 查看ip
- ip adder  // en33
### 开启服务
- sudo systemctl start docker

### 开机自动启动
- sudo systemctl enable docker // 开机启动docker
- sudo docker update  --restart=always rabbit // docker启动开启rabbit

### docker 命令
- docker run // 创建一个新的容器并运行一个命令