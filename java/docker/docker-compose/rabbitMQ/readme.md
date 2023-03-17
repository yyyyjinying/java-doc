# docker配置rabbitmq
运行守护进程 
关于RabbitMQ需要注意的一件重要的事情是，它根据所谓的“节点名”存储数据，默认为主机名。这意味着在Docker中，我们应该为每个守护进程显式地指定-h/——hostname，这样我们就不会得到一个随机的主机名，并且可以跟踪我们的数据:

- docker run -d --hostname my-rabbit -p 15672:15672 -p 5672:5672 --name some-rabbit -e RABBITMQ_DEFAULT_USER=root -e RABBITMQ_DEFAULT_PASS=123456 rabbitmq:3.8.8-management