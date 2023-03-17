# 命令行开启nginx服务
- docker pull nginx
- cd /root
- mkdir path
- docker run -d -p 8088:80 --name web-server nginx
- docker cp web-server:/etc/nginx/nginx.conf /root/path/nginx.conf
- docker stop web-server
- docker rm web-server
- docker run -d -p 8088:80 -v /root/path/nginx.conf:/etc/nginx/nginx.conf:ro --name web-server nginx
- host-ip:8088  // 测试nginx是否开启成功