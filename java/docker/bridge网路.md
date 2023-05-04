# create
> docker network create --driver=bridge zjy-net
# connect网路到容器
> docker network connect zjy-net redis
> docker network connect zjy-net mysql
> docker network connect zjy-net oracle11g
> docker network connect zjy-net nacos
# 查看指定的网路下有哪些容器
> docker network inspect zjy-net
