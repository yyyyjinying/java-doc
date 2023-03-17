# 权限
- 访问权限
- 数据权限
# 认证
- 认证主体
- 认证信息
- 认证凭证信息

# 授权

# Shiro 
是一个功能强大且易于使用的Java安全框架，它执行
身份验证、授权、加密和会话管理。使用Shiro易于理解的API，
您可以快速轻松地保护任何应用程序—从最小的移动应用程序到最
大的web和企业应用程序。
Shiro是apache旗下一个开源框架，它将软件系统的安全认证相关
的功能抽取出来，实现用户身份认证，权限授权、加密、会话管
理等功能，组成了一个通用的安全认证框架。
## Subject即主体
外部应用与subject进行交互，subject记录了当前
操作用户，将用户的概念理解为当前操作的主体，可能是一个通过浏
览器请求的用户，也可能是一个运行的程序。	
Subject在shiro中是一个接口，接口中定义了很多认证授相关的方法，外部程序通
过subject进行认证授，而subject是通过SecurityManager安全
管理器进行认证授权

## SecurityManager即安全管理器
对全部的subject进行安全管理，
它是shiro的核心，负责对所有的subject进行安全管理。通过
SecurityManager可以完成subject的认证、授权等，实质上
SecurityManager是通过Authenticator进行认证，通过Authorizer进
行授权，通过SessionManager进行会话管理等。
SecurityManager是一个接口，继承了Authenticator, Authorizer, 
SessionManager这三个接口。
## Authenticator即认证器
对用户身份进行认证，Authenticator是一个接口，
shiro提供ModularRealmAuthenticator实现类，通过
ModularRealmAuthenticator基本上可以满足大多数需求，也可以
自定义认证器。

## Authorizer即授权器
用户通过认证器认证通过，在访问功能时
需要通过授权器判断用户是否有此功能的操作权限。

# Realm即领域
相当于datasource数据源，securityManager进行
安全认证需要通过Realm获取用户权限数据，比如：如果用户
身份数据在数据库那么realm就需要从数据库获取用户身份信息。
注意：不要把realm理解成只是从数据源取数据，在realm中还
有认证授权校验的相关的代码。

# sessionManager即会话管理
shiro框架定义了一套会话管理，它不依赖web容器的session，
所以shiro可以使用在非web应用上，
也可以将分布式应用的会话集中在一点管理，此特性可使它实现单点登录。

SessionDAO即会话dao，是对session会话操作的一套接口，
比如要将session存储到数据库，可以通过jdbc将会话存储到数据库。

CacheManager缓存管理
将用户权限数据存储在缓存，这样可以提高性能。
Cryptography密码管理
shiro提供了一套加密/解密的组件，方便开发。比如提供常用的散列、加/解密等功能。

# shiro中的认证
身份认证，就是判断一个用户是否为合法用户的处理过程。最
常用的简单身份认证方式是系统通过核对用户输入的用户名和口
令，看其是否与系统中存储的该用户的用户名和口令一致，来判
断用户身份是否正确

# shiro中认证的关键对象
`Subject：主体`
访问系统的用户，主体可以是用户、程序等，进行认证的都称为主体； 

`Principal：身份信息`
是主体（subject）进行身份认证的标识，标识必须具有`唯一性`，
如用户名、手机号、邮箱地址等，一个主体可以有多个身份，
但是必须有一个主身份（Primary Principal）。

`credential：凭证信息`
是只有主体自己知道的安全信息，如密码、证书等。

```shiro.xml
[users]
xiaochen=123
zhangsan=456
```
```java
//1.创建安全管理器对象
DefaultSecurityManager securityManager = new DefaultSecurityManager();
//2.给安全管理器设置realm
securityManager.setRealm(new IniRealm("classpath:shiro.ini"));
//3.SecurityUtils 给全局安全工具类设置安全管理器
SecurityUtils.setSecurityManager(securityManager);
//4.关键对象 subject 主体
Subject subject = SecurityUtils.getSubject();
//5.创建令牌
UsernamePasswordToken token = new UsernamePasswordToken("xiaochen","123");
subject.login(token);
System.out.println("认证状态: "+ subject.isAuthenticated());
subject.login(token);//用户认证
System.out.println("认证状态: "+ subject.isAuthenticated());

```


