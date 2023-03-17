```yml
dubbo:
  application:
    name: demo-provider
  protocol:
    name: dubbo
    port: -1
  registry:
    address: zookeeper://${zookeeper.address:127.0.0.1}:2181
server:
  port: 8087
```
${key:default_value} 这种表达方式是通过key来获取value，如果获取不到就使用后面默认值
java -jar -zookeeper.address=172.16.0.36 xxx.jar