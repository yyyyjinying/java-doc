# redis
- docker run --name redis -d -p 6379:6379 redis
- host 172.16.147.192
- port 6379

- docker exec -it redis bash
- /data# redis-cli
- keys *

# 使用配置文件conf启动
- cd /root
下载
- redis-7.0.4.tar.gz
解压
- tar -zxvf redis-7.0.4.tar.gz
- cd redis-7.0.4
- mkdir -p /root/sorf/redis/conf
- mkdir -p /root/sorf/redis/data
- cp redis.conf /root/sorf/redis/conf
- rm -rf redis-7.0.4  redis-7.0.4.tar.gz
挂在文件映射和本地数据存储，使用自定义配置文件启动redis
- docker run -d -p 6379:6379 -v /root/sorf/redis/conf:/usr/local/etc/redis -v /root/sorf/redis/data:/data --name redis redis:7.0.4 redis-server /usr/local/etc/redis/redis.conf
- 默认的配置是支持远程连接的，而自定义需要手动开启远程连接权限
```redis.conf
# 修改bind
bind 0.0.0.0
#修改peotected-mode yes为no 或者注视掉
#peotected-mode yes
```
- docker exec -it 40fcabf31ca4 bash
- /data# redis-cli
- keys *
重启启动容器服务
- docker restart redis

# 数据库类型
redis是内存型数据库，可以持久化到硬盘中，支持数据类型（string，list,set,Zset,hash）
单线程，单进程，异步处理，线程安全的；
分布式锁
单个虚拟机使用java多线程的Synchronized
多个虚拟机的 redis

# redis启动
- 默认在redis-server方式启动，默认配置
- 
内存 - 读写快
硬盘 - 数据持久化


