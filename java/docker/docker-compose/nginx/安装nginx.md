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


