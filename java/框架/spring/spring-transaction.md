# spring事务管理
- 跨不同事务API的一致编程模型；
- 支持声明式事务管理: 不依赖Spring Framework事务API或任何其他事务API;
- 编程事务管理更简单；
- 集成了Spring的数据访问抽象；

Spring框架的事务支持模型的优点
全局事务允许您使用`多个事务资源`，通常是关系数据库和消息队列
应用服务器通过JTA管理全局事务，需要使用JNDI才能使用JTA；
重要的缺点是CMT与JTA和应用程序服务器环境绑定在一起
因为JTA事务是全局事务，可以征召任何事务资源；

在所有Spring事务设置中，应用程序代码不需要更改；

本地事务
特定于资源的，例如与JDBC连接关联的事务。
本地事务可能更容易使用，但有一个显著的缺点:它们不能跨多个事务资源工作;
另一个缺点是本地事务对编程模型具有侵入性;

- 允许应用程序开发人员在任何环境中使用一致的编程模型;
- Spring框架同时提供声明式和编程式事务管理;

Propagation[传播行为]：通常情况下，事务范围内的所有代码都在该事务中运行;
Isolation：该事务与其他事务的工作隔离的程度;
Timeout：该事务在超时并被底层事务基础设施自动回滚之前运行多长时间;
只读状态：当代码读取但不修改数据时，可以使用只读事务。 在某些情况下，如使用Hibernate时，只读事务可能是一种有用的优化;

TransactionStatus接口为事务代码提供了一种控制事务执行和查询事务状态的简单方法;


无论在Spring中选择声明式事务管理还是编程式事务管理，定义正确的TransactionManager实现都是绝对必要的。通常通过依赖注入来定义此实现;

1. define a JDBC DataSource；
2. DataSourceTransactionManager 引入dataSource事务管理

用事务同步资源
高级同步方法 
首选的方法是使用Spring最高级别的基于模板的持久性集成api，或者使用本地ORM api和支持事务的工厂bean或代理来管理本地资源工厂
Declarative Transaction Management - 声明式事务管理

Spring Framework的声明式事务管理是通过Spring面向方面编程(AOP)实现的由于事务方面的代码是随Spring Framework发行版一起提供的，并且可以以样板的方式使用，因此通常不需要理解AOP概念就可以有效地使用这些代码。
Spring框架的声明式事务管理可以在任何环境中工作
Spring框架提供了声明性回滚规则
pring框架允许您使用AOP自定义事务行为


编程式事务管理只有在只有少量事务操作时；
声明式事务管理通常使事务管理脱离业务逻辑，并且不难配置；

@TransactionalEventListener只适用于由PlatformTransactionManager管理的线程绑定事务。由ReactiveTransactionManager管理的响应式事务使用Reactor上下文而不是线程本地属性；

@EnableTransactionManagement和<tx:annotation-driven/>只在定义它们的同一个应用程序上下文中的bean上查找@Transactional。
方法上的@Transactional注释优先于在类级别上定义的事务设置;

PROPAGATION_NESTED:它仅适用于JDBC资源事务


​ 在其默认配置中，Spring框架的事务基础结构代码只在运行时、未检查的异常情况下标记事务进行回滚。 也就是说，当抛出的异常是' RuntimeException '的实例或子类时。 (默认情况下，' Error '实例也会导致回滚)。 事务方法抛出的已检查异常不会导致默认配置的回滚

# 事务传播
- PROPAGATION_REQUIRED
表示当前方法必须运行在事务中。如果当前事务存在，方法将会在该事务中运行。否则，会启动一个新的事务;
嵌套事务执行成功，父级事务异常，全部回滚；

- PROPAGATION_SUPPORTS
表示当前方法不需要事务上下文，但是如果存在当前事务的话，那么该方法会在这个事务中运行;
- PROPAGATION_MANDATORY
表示该方法必须在事务中运行，如果当前事务不存在，则会抛出一个异常
- PROPAGATION_REQUIRED_NEW (嵌套事务)
表示当前方法必须运行在它自己的事务中。一个新的事务将被启动。如果存在当前事务(父级事务)，在该方法执行期间，当前事务会被挂起。如果使用JTATransactionManager的话，则需要访问TransactionManager
嵌套事务执行成功，父级事务异常，则父级事务回滚；
嵌套事务执行异常，嵌套和父级事务全部回滚；

- PROPAGATION_NOT_SUPPORTED
表示该方法不应该运行在事务中。如果存在当前事务，在该方法运行期间，当前事务将被挂起。如果使用JTATransactionManager的话，则需要访问TransactionManager
- PROPAGATION_NEVER
表示当前方法不应该运行在事务上下文中。如果当前正有一个事务在运行，则会抛出异常
- PROPAGATION_NESTED
表示如果当前已经存在一个事务，那么该方法将会在`嵌套事务`中运行。嵌套的事务可以独立于当前事务进行单独地提交或回滚。如果当前事务不存在，那么其行为与PROPAGATION_REQUIRED一样。注意各厂商对这种传播行为的支持是有所差异的。可以参考资源管理器的文档来确认它们是否支持嵌套事务

无事务，还是执行不会回滚；
有事务，有异常就会回滚；
# 隔离级别
- ISOLATION_DEFAULT
使用后端数据库默认的隔离级别
- ISOLATION_READ_UNCOMMITTED	
`最低的隔离级别`，允许读取尚未提交的数据变更，可能会导致脏读、幻读或不可重复读
- ISOLATION_READ_COMMITTED
允许读取并发事务已经提交的数据，可以`阻止脏读`，但是幻读或不可重复读仍有可能发生
- ISOLATION_REPEATABLE_READ
对同一字段的多次读取结果都是一致的，除非数据是被本身事务自己所修改，可以`阻止脏读和不可重复读`，但幻读仍有可能发生
- ISOLATION_SERIALIZABLE
`最高的隔离级别`，完全服从ACID的隔离级别，确保阻止脏读、不可重复读以及幻读，也是最慢的事务隔离级别，因为它通常是通过完全锁定事务相关的数据库表来实现的

mybatis:
- 注解来指定 SQL 语句
- MyBatis映射器XML配置文件指定 SQL 语句

<context:component-scan/> 无法发现并注册映射器。映射器的本质是接口，为了将它们注册到 Spring 中，发现器必须知道如何为找到的每个接口创建一个 MapperFactoryBean。

