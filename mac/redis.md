### Ubuntu系统中安装redis相关的命令
- reboot
- su root // 切换root用户
- su linux // 切换普通用户
- lsb_release -a // 查看系统版本
- sudo apt-get install vim-gtk
- tar zxvf redis-3.0.0.gz //解压文件 
- apt install gcc
- cd redis-3.0.0 
- make
- make install PREFIX=/usr/local/redis
- cp /usr/local/tmp/redis-3.0.0/redis.conf /usr/local/redis/bin
- cd /usr/local/redis/bin
- ./redis-server redis.conf     // 开启redis服务
- ./redis-cli shutdown  // 关闭redis服务
- ./redis-cli    // 开启本地redis

### 安装集群redis
- yum install ruby -y // sudo apt-get install ruby // ruby -v // 后面需要用到 ruby 脚本
- yum install rubygems -y  // 安装 ruby 包管理器
- sftp> put redis-3.0.0.gem /usr/local/tmp
- gem install redis-3.0.0.gem // 脚本需要 ruby 其他包,所以安装这个 redis.gem
- mkdir reids-cluster // 在/usr/local 中新建 redis-cluster 文件夹
- cp -r bin ../redis-cluster/redis01 // 把之前安装好的 redis/bin 复制到 redis-cluster 中并起名为 redis01
- rm -rf dump.rdb // 删除掉 redis01 中 dump.rdb 数据库文件
- vi redis.conf // 修改 redis01 中端口号为 7001, 找到 port 后面修改为 7001
- 去掉 cluster-enabled yes 前面的注释
- cp -r redis01 redis02
- cp -r redis01 redis03
- cp -r redis01 redis04
- cp -r redis01 redis05
- cp -r redis01 redis06  // 把 redis01 文件夹在复制 5 份,分别起名为 redis02,redis03,redis04,redis05,redis06
- vim redis01/redis.conf // port 7001
- vim redis02/redis.conf // port 7002
- vim redis03/redis.conf // port 7003
  ……
- /usr/local/tmp/redis-3.0.0/src# cp *.rb /usr/local/redis-cluster

- vim startall.sh  // 执行批量命令
cd redis01 
./redis-server redis.conf 
cd ..
cd redis02 
./redis-server redis.conf 
cd ..
cd redis03 
./redis-server redis.conf 
cd ..
cd redis04 
./redis-server redis.conf 
cd ..
cd redis05 
./redis-server redis.conf 
cd ..
cd redis06 
./redis-server redis.conf 
cd ..

- chmod +x startall.sh // 给当前脚本文件设置执行权限（属主，属组，其他）
- ./startall.sh // 批量执行脚本
- ps aux|grep redis // 查看redis执行进程
- 开启集群
- ./redis-trib.rb create --replicas 1 172.16.147.156:7001 172.16.147.156:7002 172.16.147.156:7003 172.16.147.156:7004 172.16.147.156:7005 172.16.147.156:7006
- cd redis01
- ./redis-cli -p 7001 -c // 必须选择7001端口 -c集群客户端

### 重启redis集群
- ./shutdown.sh
- ./rm.sh
- ./startall.sh
- 172.16.147.156
- ./redis-trib.rb create --replicas 1 172.16.147.156:7001 172.16.147.156:7002 172.16.147.156:7003 172.16.147.156:7004 172.16.147.156:7005 172.16.147.156:7006


 
