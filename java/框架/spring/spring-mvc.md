# vo po dto
相互转换
userPO = new userPO("a", "b");
userDTO = new userDTO();
- BeanUtils.copyProperties(userPO, userDTO);

@ResponseBody
prossor="application/json;chatset=utf8"
JSONArrys.toJSONString(..);
或者
@ResponseBody
+ 配置json的转换器

json转化器
- fastJSON的maven依赖；
- 配置json的转换器
返回json不走视图解析器；

# 全局异常处理
```java
classs BaseExpection implement RuntimeExpection{

}

// service
throw new BAseException("业务异常");
```

# javaweb过滤器和spring-mvc拦截器
过滤器是servlet容器支持；
拦截器是spring-mvc容器支持；

# 重定向和转发
response.sendRedirect();
forward

# 源码分析
DispatcherServlet


# 跨域
服务器不存在跨域；所以代理服务器解决跨域；

