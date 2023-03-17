# 分布式配置:
流量控制和服务降级:流量控制，断路和系统自适应保护与阿里哨兵 
服务注册和发现:实例可以注册到Alibaba nacos，客户端可以使用spring管理的bean发现实例。支持Ribbon，客户端负载平衡器通过Spring Cloud Netflix
使用阿里巴巴nacos作为数据存储 
事件驱动:构建与Spring Cloud Stream RocketMQ Binder连接的高度可伸缩的事件驱动微服务 
消息总线:使用Spring Cloud Bus RocketMQ链接分布式系统的节点 
分布式事务:支持具有高性能和易于使用的分布式事务解决方案 
Dubbo RPC:通过Apache Dubbo RPC扩展Spring Cloud服务对服务调用的通信协议

# CAP
CAP： C：一致性>Consistency;  A：可用性>Availability; P：分区容错性>Partition tolerance;

# 什么是网关?
统一管理微服务请求，权限控制、负载均衡、路由转发、监控、安全控制黑名单和白名单等；
# 接口
开发API接口和内网API接口，内网API接口用于局域网，
为内部服务器提供服务。开放API接口用于对外部合作单位提供接口调用，需要遵循Oauth2.0权限认证协议；
# Ribbon
# Gateway
#  Stream
Kafka及RabbitMQ
# OpenFeign
Feign是一个声明性的Web服务客户端。它使编写Web服务客户端变得更容易。要使用Feign，我们可以将调用的服务方法定义成抽象方法保存在本地添加一点点注解就可以了，不需要自己构建Http请求了，直接调用接口就行了，不过要
# Spring Cloud的版本
些版本的名字采用了伦敦地铁站的名字，，根据字母表的顺序来对应版本时间顺序例如Angel是第一个版本，Brixton是第二个版本。 当Spring Cloud的发布内容积累到临界点或者一个重大BUG被解决后，会发布一个"service leases"版本，简称SRX版本，比如Greenwich.SR2就是Spring Cloud发布的Greenwich版本的第2个SRX版本。目前Spring Cloud的
最新版本是Hoxton。