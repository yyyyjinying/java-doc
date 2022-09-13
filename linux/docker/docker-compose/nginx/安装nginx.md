# 前端打包
- yum install -y unzip zip
- zip -q -r dist.zip ./dist
<!-- - cd dist && zip -q -r dist.zip * -->
- stfp root@127.16.147.192
- put /Volumes/HIKVISION/git/backstage/gitee/jenkins-project/webApp/teacher/dist.zip /root/sorf/nginx/html
- cd /root/sorf/nginx/html
- unzip -v dist.zip
- unzip dist.zip
- 
# docker 配置nginx
## 获取临时配置文件
- https://hub.docker.com/_/nginx
- docker run --name tmp-nginx-container -d nginx:1.23.1
- docker cp tmp-nginx-container:/etc/nginx/nginx.conf /root/sorf/nginx.conf
- docker cp tmp-nginx-container:/etc/nginx/conf.d/default.conf /root/sorf/default.conf
- docker rm -f tmp-nginx-container

# nginx.conf 与 default.conf的关系,default.conf可以通过default.conf.template模版文件控制
```nginx.conf
include /etc/nginx/conf.d/*.conf;
```
## nginx的相关配置
- 配置文件
- /etc/nginx/nginx.conf
- 静态文件
- /usr/share/nginx/html
- 日志文件
- /var/log/nginx
- 缓存文件
- /var/cache/nginx
## 配置文件模版
从nginx1.19开始，有一个新的配置文件，叫配置模板，
模板会在nginx启动前提取环境变量，
默认路径是：/etc/nginx/templates/default.conf.template，
如果配置了默认文件，
nginx将会把这个配置文件输出到：/etc/nginx/conf.d/default.conf；
最终default.conf会被加载到nginx.conf中，
在nginx.conf中最后有一句话：include /etc/nginx/conf.d/*.conf；

# 安装nginx
<!-- 获取nginx镜像 -->
- docker pull nginx  
<!-- 创建nginx容器 -->
- docker run --name nignx-test -d -p 80:80 --restart=always nginx

- docker exec -it nignx-test bash
- whereis nginx
- nginx: /usr/sbin/nginx /usr/lib/nginx /etc/nginx /usr/share/nginx

- exit
<!-- 创建文件夹   -->
- mkdir -p /usr/local/nginx
<!-- 获取容器中的文件做数据卷映射 -->
- docker cp nignx-test:/etc/nginx/nginx.conf /usr/local/nginx/conf
- docker cp nignx-test:/etc/nginx/conf.d/default.conf /usr/local/nginx/conf
- docker cp nignx-test:/var/log/nginx /usr/local/nginx/logs
- docker cp nignx-test:/usr/share/nginx/html /usr/local/nginx/html

<!-- 删除旧的，重新创建带数据卷的容器 -->
- docker run -d -p 80:80 --name nginx-test -v /usr/local/nginx/logs:/var/log/nginx -v /usr/local/nginx/html:/usr/share/nginx/html -v /usr/local/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /usr/local/nginx/conf/default.conf:/etc/nginx/conf.d/default.conf nginx

- 修改nginx集群
```conf
 http {
    upstream nginxcluster{
        server 172.16.147.185:3333;
        server 172.16.147.185:4444;
        server 172.16.147.185:5555;
    }

    location / {
        proxy_pass http://nginxcluster;
    }
}
```

# nginx.conf的配置文件组成
- /etc/nginx/nginx.conf
第一部分
从配置文件开始到events块之间的内容，主要会设置一些影响nginx服务器整体
运行的配置指令
```conf
# nginx服务器并发处理服务的关键配置，值越大，支持的并发处理量越大；
worker_processes 1;

```
第二部分events块
events块涉及的指令主要影响nginx服务器与用户的网络连接
比如：worker connections 1024; 支持的最大连接数

第三部分 http块
配置最频繁的部分
http块也可以包括http全局块、server块；
```conf

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

   upstream nginxcluster{
        server 172.16.147.184:1806;
        server 172.16.147.184:1807;
   }

   server {
       listen:      80;
       server_name  172.16.147.184;

       location / {
           root html;
           proxy_pass http://172.16.147.184:1806;
           index index.html index.htm;
       }

       location / {
            proxy_pass http://nginxcluster;
        }
   }
   include /etc/nginx/conf.d/*.conf;
}


```
# 模拟nginx本地代理
<!-- host -->
- http://172.16.147.184/ www.123.com

location / {

}
<!-- 路径中有/vvv/ -->
location ~ /vvv/ {

}
## location的指令说明
 location [= | ~ | ~* | ^~] uri {}
1、=:用于不含正则表达式的uri前，要求请求字符串与uri严格匹配，如果匹配成功，就停止继续向下搜索并立即处理该请求。
2、~：用于表示uri包含正则表达式，并区分大小写；
3、^*:用于表示uri包含正则表达式，并不区分大小写；
4、^~:用于表示uri包含不包含正则表达式，要求nginx服务器找到标示uri和请求字符串匹配度最高的
location后，立即使用此location处理请求，而不是使用location块中的正则uri和请求字符串做匹配；

# nginx分配服务的策略
- 第一种方式： 轮询（默认）：每次请求按时间顺序逐一分配到不同的后端服务器。如果后端服务器down掉，能自动剔除。
- 第二种方式： weight代表权重默认1，权重越高，被分配的客户端越多。
- 第三种方式： ip hash 每个请求按访问IP的hash结果分配，这个样每个访客固定访问一个后端服务器，可以解决session共享的问题；
- fair方式 ： 按后端服务器的响应时间来分配请求，响应时间短的优先分配；

# nginx动静分离
1、 什么是动静分离
把动态和静态的请求分开，nginx处理静态页面，tomcat处理动态页面；
动静分离的两种实现方案：
把静态文件独立成单独的域名，放在独立的服务器上；
把静态和动态的文件混在一起，通过nginx分开；

http状态码：
HTTP 304 ：说明无需再次传输请求的内容，也就是说可以使用缓存的内容；
HTTP 403：代表客户端错误，指的是服务器端有能力处理该请求，但是拒绝授权访问；
HTTP 401 ：Unauthorized代表客户端错误，指的是由于缺乏目标资源要求的身份验证凭证，发送的请求未得到满足。
HTTP 404： Not Found

# 负载均衡
- upstream

# 什么是nginx的高可用
- 需要两台nginx服务器
- 需要keepalived
- 需要虚拟IP

# 准备工作
两台虚拟机

# keepalived.conf
```conf
vrrp_instance VI_1 {
    state MASTER  			#主为MASTER 备为BACKUP
    interface ens33  		#ens33为绑定的网卡名，此处请根据现实情况更改
    virtual_router_id 2 	#虚拟路由ID，负责相同虚拟IP的keepalived集群最好定义为相同的id
    priority 101 			#优先级，MASTER的优先级必须比BACKUP的高
    advert_int 2
    authentication {
        auth_type PASS 
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.11.96  		#虚拟IP
    }
}

```
