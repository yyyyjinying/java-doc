# http
http是无状态协议，每次请求都需要身份认证，账号密码每次都携带，太过麻烦，解决方案session，

# webstorage
webstorage 可保存的数据容量为5M。且只能存储字符串数据。
## webstorage 分为localStorage 和sessionStorage。
- localStorage 的生命周期是永久的，关闭页面或浏览器之后localStorage 中的数据也不会
消失。localStorage 除非主动删除数据，否则数据永远不会消失。
- sessionStorage 是会话相关的本地存储单元，生命周期是在仅在当前会话下有效。
sessionStorage 引入了一个“浏览器窗口”的概念，sessionStorage 是在同源的窗口中始终存在
的数据。只要这个浏览器窗口没有关闭，即使刷新页面或者进入同源另一个页面，数据依然
存在。但是sessionStorage 在关闭了浏览器窗口后就会被销毁。同时独立的打开同一个窗口
同一个页面，sessionStorage 也是不一样的。

# 分布式与集群的区别
将一套系统拆分成不同子系统部署在不同服务器上（这叫分布式）
署多个相同的子系统在不同的服务器上（这叫集群）
部署在不同服务器上的同一个子系统应做负载均衡。
分布式：一个业务拆分为多个子业务，部署在多个服务器上 。
集群：同一个业务，部署在多个服务器上 

# 单点系统架构
传统项目架构：传统项目分为三层架构，将业务逻辑层、数据库访问层、控制层放入在一个项目中。
优点:适合于个人或者小团队开发，不适合大团队开发。
# RPC远程调用
RPC 的全称是 Remote Procedure Call 是一种进程间通信方式。
它允许程序调用另一个地址空间（通常是共享网络的另一台机器上）的过程或函数，
而不用程序员显式编码这个远程调用的细节。即无论是调用本地接口/服务的还是远程的接口/服务，
本质上编写的调用代码基本相同。比如两台服务器A，B，一个应用部署在A服务器上，
想要调用B服务器上应用提供的函数或者方法，由于不在一个内存空间，不能直接调用，
这时候需要通过就可以应用RPC框架的实现来解决

# 什么是RestTemplate
RestTemplate 是从 Spring3.0 开始支持的一个 HTTP 请求工具;
```java
// 1.启动class中注入
@Bean
@LoadBalanced
RestTemplate restTemplate() {
    return new RestTemplate();
}
// 2. 使用类中引用
@Autowired
RestTemplate restTemplate;

public List<String> getOrderByUserList() {
    return restTemplate.getForObject("http://service-member/getUserList", List.class);
}	

```

# 什么是Feign
Feign是一个声明式的伪Http客户端，它使得写Http客户端变得更简单。使用Feign，只需要创建一个接口并注解。
它具有可插拔的注解特性，可使用Feign 注解和JAX-RS注解。Feign支持可插拔的编码器和解码器。
Feign默认集成了Ribbon，并和Eureka结合，默认实现了负载均衡的效果。
简而言之：
•	Feign 采用的是基于接口的注解
•	Feign 整合了ribbon
# 什么是openFeign
- 定义一个接口，并添加Feign的注解就可以调用注册中心的服务；





