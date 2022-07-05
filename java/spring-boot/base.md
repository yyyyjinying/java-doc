# Spring Boot 的特点
Spring Boot 具有以下特点：

1. 独立运行的 Spring 项目
Spring Boot 可以以 jar 包的形式独立运行，Spring Boot 项目只需通过命令“ java–jar xx.jar” 即可运行。
2. 内嵌 Servlet 容器
Spring Boot 使用嵌入式的 Servlet 容器（例如 Tomcat、Jetty 或者 Undertow 等），应用无需打成 WAR 包 。
3. 提供 starter 简化 Maven 配置
Spring Boot 提供了一系列的“starter”项目对象模型（POMS）来简化 Maven 配置。
4. 提供了大量的自动配置
Spring Boot 提供了大量的默认自动配置，来简化项目的开发，开发人员也通过配置文件修改默认配置。
5. 自带应用监控
Spring Boot 可以对正在运行的项目提供监控。
6. 无代码生成和 xml 配置
Spring Boot 不需要任何 xml 配置即可实现 Spring 的所有配置。

# mvn dependency:tree 查看依赖树
# 修改默认配置
- SpringBoot 默认使用以下 2 种全局的配置文件，其文件名是固定的。
- application.properties
- application.yml
- 可以在 Spring Boot 启动时被自动读取，修改 Spring Boot 自动配置的默认值

# YAML 
全称 YAML Ain't Markup Language，它是一种以数据为中心的标记语言，比 XML 和 JSON 更适合作为配置文件。

YAML 的语法如下：
使用缩进表示层级关系。
缩进时不允许使用 Tab 键，只允许使用空格。
缩进的空格数不重要，但同级元素必须左侧对齐。
大小写敏感。
