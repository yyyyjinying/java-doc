# 解压缩
- tar -xzvf /Users/yyyyjinying/Downloads/logstash-8.6.1-darwin-x86_64.tar.gz ./解压到目标地址
- cd bin 下为执行指令

# cp
cp -rf aaa ./bbb.  //深拷贝文件夹

# 查看文件
- ls -l     // 查看文件以及详细权限信息
- ls -a -l  // 查看包括隐藏文件的详细权限信息
- 
# mac配置hosts
- vim /etc/hosts
172.16.147.182      redis
172.16.147.182      rabbitmq
172.16.147.182      solr
172.16.147.182      zipkin
172.16.147.182      sentinel
172.16.147.182 mysql
172.16.147.182 nacos
127.0.0.1      mogu_monitor
127.0.0.1      mogu_web
127.0.0.1      mogu_search
127.0.0.1      mogu_admin
127.0.0.1      mogu_sms
127.0.0.1      mogu_gateway
# Mac系统上查看端口占用和释放端口
- sudo lsof -i tcp:8080
- sudo kill -9 PID
# mac配置.bash_profile环境变量
- sudo vi  /Users/yyyyjinying/.bash_profile 
- export JMETER_HOME=/Users/yyyyjinying/apache-jmeter-5.4.1
- export PATH=$JAVA_HOME/bin:$PATH:.:$JMETER_HOME/bin:$PATH
- export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JMETER_HOME/lib/ext/ApacheJMeter_core.jar:$JMETER_HOME/lib/jorphan.jar:$JMETER_HOME/lib/logkit-2.0.jar
- cd /Users/yyyyjinying
- source .bash_profile
## 常见命令
- sudo -i // 切到root用户
- exit // 退出root用户到普通用户
- 
- sudo su // 切到root用户
- sudo su - yyyyjingying // 切换到yyyyjinying用户 
- sudo mkdir test && cd test
- sudo echo hello world >> text.txt
- // 查看信息
- ls -l
- touch hello.text
- vim world.text
- zip -r dist.zip ./
## mac自带的快速截屏 commond + shift + 4
- pwd # 查看当前文件
- chgrp：更改文件属组
  - chgrp [-R] 属组名 文件名
- chmod：更改文件9个属性
  - chmod [-R] u=rwx,g=rx,o=r  test1    // 修改 test1 权限
  - chmod [-R] 754 test1  / r:4 w:2 x:1
## 用来更改某个目录或文件的用户名和用户组
- chown -R root:root /tmp/tmp1  // 就是把tmp下的tmp1下的所有文件的属组都改成root和root。
- 更改文件属主，也可以同时更改文件属组  R表示递归
  - chown [–R] 属主名 文件名
  - chown [-R] 属主名：属组名 文件名
- sudo chmod -R 777 文件夹名


### 重启Linux
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

- cp -rf * ../  // * 复制所有文件

  

  