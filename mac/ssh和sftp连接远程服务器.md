### ssh
- ssh root@121.37.162.252 (公网ip)
### sftp给远程服务器上传下载文件
- sftp -P 22 root@121.37.162.252  // sftp连接172.16.147.145
- sftp> get /var/www/fuyatao/index.php  /home/fuyatao/  // 下载文件
- put /Users/yyyyjinying/desktop/redis-3.0.0.tar.gz /usr/local/tmp // 上传文件到远程服务器
- 
你如果不知道远程主机的目录是什么样， pwd命令可以帮您查询远程主机的当前路径。查询本机当前工作目录 lpwd.
改变路径可以用cd ，改变本机路径可以用 lcd;
ls rm rmdir mkdir 这些命令都可以使用。同理调用本机都是加 l , 即 lls lrm.
要离开sftp，用exit 或quit、 bye 均可。详细情况可以查阅 man  sftp.

ps -ef |grep tomcat

### profile
- vim /etc/profile
- source /etc/profile
  
### iptables
- vim /etc/sysconfig/iptables
- cd /etc/sysconfig
- ls
- service iptables restart  // 重启防火墙
- service iptables status
- service iptables stop
- service iptables start
- chkconfig iptables off  //  永久关闭防火墙
- chkconfig iptables on  // 永久启动防火墙

当启动 iptables是报错误：iptables: No config file. 
1、输入以下命令：
 - iptables -P OUTPUT ACCEPT
 - service iptables save

### consoc7 firewall
- systemctl stop firewalld.service
- systemctl start firewalld.service
- firewall-cmd --state // 查看防火墙状态
- firewall-cmd --zone=public --add-port=8080/tcp --permanent // 设置上端口8080
- firewall-cmd --reload // 重启防火墙
- firewall-cmd --zone=public --query-port=8080/tcp  // 检查是否生效

### profile
export JAVA_HOME=/usr/local/jdk8
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export TOMCAT_HOME=/usr/local/tomcat
export CATALINA_HOME=/usr/local/tomcat

### tomcat
- 当你正常安装了jdk和tomcat，并且关闭了防火墙依然不能正常访问8080，需要配置云服务器的安全组8080端口（入口）