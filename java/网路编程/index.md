# ip
- 
# 端口
- 标示计算机特定的网络程序；

# 网络协议
- 传输层 tcp
- 网络层 ip 
  
# tcp和udp

# channel & buffer 
# selector
- 多线程版缺点
- - 内存占用高
- - 线程上下文切换成本高
- - 只适用连接少数的场景

# 线程池
- 可以限制线程的数量


# 如何读取文件位置
```java
// classes文件位置
String t= Thread.currentThread().getContextClassLoader().getResource("").getPath();
String p1 = Case01.class.getClassLoader().getResource("").getPath();
System.out.println(t);
// /Volumes/HIKVISION/git/backstage/gitee/jenkins-project/javaProject/springboot-03-mybatis-plus/target/classes/

```

# ByteBuffer