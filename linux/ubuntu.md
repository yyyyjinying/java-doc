# ubuntu:18.04版本调试外部连接容器服务器，通过ssh远程联接 
- sudo ssh -p 10022 zjy@172.16.147.192
# 没有vim
## 安装vim
apt-get install vim
## 备份
cp sources.list sources.list_bak
## 替换源
- vim /etc/apt/sources.list

deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

- apt-get install net-tools
- netstat -tunlp

- sed -ri 's/session required  pam_loginuid.so/#session required   pam_loginuid.so/g' /etc/pam.d/sshd

- mkdir /root/.ssh
- ssh-keygen -t rsa
- cat /root/.ssh/id_rsa.pub >/root/.ssh/authorized_keys

- vi /run.sh
```sh
#!/bin/bash
/usr/sbin/sshd -D
```
- chmod +x run.sh

- docker commit fc1 sshd:ubuntu     // fc1为当前运行容器ID
- docker run -p 10022:22 -itd --name='ssh-server' sshd:ubuntu /run.sh
- 
- useradd zjy       // 添加zjy用户
- passwd 123456
- cat /etc/passwd |grep bash$       // 查看注册用户

- sudo ssh -p 10022 zjy@172.16.147.192   // 调试成功

# 相关知识点
- sshd命令是openssh套件中的核心程序
- sshd [参数]
- -D:以非后台守护进程的方式运行服务器
- -p:设置使用的端口号
# Ubuntu管理防火墙
- sudo ufw status
- sudo ufw allow 5000
- sudo ufw reload