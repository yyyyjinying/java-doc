### centOS wget的安装和使用
- yum install wget

// 此命令常用于批量下载的情形，把所有需要下载文件的地址放到 filename.txt 中，然后 CentOS wget 就会自动为你下载所有文件了
-  wget -i filename.txt

## ps命令（Process Status）进程查看命令
- grep （global search regular expression(RE) and print out the line,全面搜索正则表达式并把行打印出来）是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。
- ps aux|grep redis 
ps aux | grep fCNL //查到fCNL的进程
kill -s 9 pid
`其中-s 9 制定了传递给进程的信号是９，即强制、尽快终止进程。`

  
### 防火墙
查看防火墙状态
- firewall-cmd --state
关闭防火墙
- systemctl stop firewalld.service
禁止开机启动防火墙
- systemctl disable firewalld.service 

重启防火墙
- firewall-cmd --reload

开启防火墙
- systemctl start firewalld

### redis
- docker pull redis
- docker run -itd --name redis-test -p 6379:6379 redis
- docker exec -it redis-test redis-cli
  或者
- docker exec -it redis-test /bin/bash
  可执行文件所在
- cd /usr/local/redis/bin
  
  列出所有key
- keys *
  列出匹配的key
- keys apple*

- info keyspace