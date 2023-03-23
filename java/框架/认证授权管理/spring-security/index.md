鼓励用户将长期凭据（即用户名和密码）交换为短期凭据（即会话、OAuth 令牌等）。短期凭证可以快速验证，而不会损失任何安全性。
JSON 网络令牌 (JWT)
JSON 网络签名 (JWS)
JSON 网络加密 (JWE)
JSON 网络密钥 (JWK)
Spring Security是一个提供身份认证、授权和针对常见攻击的保护的框架;
# 先决条件
以自包含的方式操作，因此您不需要在Java运行时环境中放置任何特殊的配置文件；
要求Java 8或更高版本的运行时环境；
# 认证 鉴权
- 认证Authentication：`验证当前访问的用户`是不是本系统中的用户。确定是哪一个具体的用户。
- 授权Authorization：经过认证，判断`当前登陆用户有没有权限`来执行某个操作;

起初，密码是以明文形式存储的，然后鼓励开发人员在通过单向散列(如SHA-256)运行密码后存储密码，散列密码将与他们输入的密码的散列进行比较；由于散列是单向的，并且在计算上很难猜测给定散列的密码，因此不值得花费精力来找出系统中的每个密码。为了打败这个新系统，恶意用户决定创建被称为彩虹表的查找表。他们不需要每次都猜测每个密码，而是计算一次密码并将其存储在一个查找表中。
为了降低彩虹表的有效性，开发人员被鼓励使用加盐密码，与仅使用密码作为哈希函数的输入不同，将为每个用户的密码生成随机字节(称为salt)。盐和用户密码将通过哈希函数运行，以产生唯一的哈希值。盐将以明文形式与用户密码一起存储。然后，当用户试图进行身份验证时，哈希后的密码将与存储的盐的哈希值和他们输入的密码进行比较。独特的盐意味着彩虹表不再有效，因为每个盐和密码组合的散列都是不同的。 
在现代，我们意识到加密哈希(如SHA-256)不再安全。原因在于，有了现代硬件，我们每秒可以执行数十亿次哈希计算。这意味着我们可以轻松地逐个破解每个密码。
现在鼓励开发人员利用自适应单向函数来存储密码；自适应单向函数示例包括bcrypt、PBKDF2、scrypt和argon2。
由于自适应单向函数是有意的资源密集型函数，因此为每个请求验证用户名和密码会显著降低应用程序的性能；鼓励用户将长期凭据(即用户名和密码)交换为短期凭据(例如会话和OAuth令牌等)。可以快速验证短期凭据，而不损失任何安全性。

# 密码存储配置

# 防范CSRF跨站请求伪造攻击 
CSRF攻击可能的原因是来自受害者网站的HTTP请求和来自攻击者网站的请求完全相同。这意味着无法拒绝来自邪恶网站的请求，只允许来自银行网站的请求。为了防止CSRF攻击，我们需要确保请求中有些东西是恶意站点无法提供的，这样我们就可以区分这两个请求。 
Spring提供了两种机制来抵御CSRF攻击: 
同步器令牌模式：The Synchronizer Token Pattern
在会话cookie上指定SameSite属性 
这两种保护都要求安全方法是等幂的

#  请求头设置
Cache-Control: no-cache, no-store, max-age=0, must-revalidate
Pragma: no-cache
Expires: 0 // 禁用缓存
X-Content-Type-Options: nosniff // 禁用内容嗅探
Referrer-Policy: same-origin // 同源策略

# 并发支持
在大多数环境中，安全性是以每个线程为基础存储的。这意味着当工作在一个新的线程上完成时，SecurityContext将丢失。

# 结构
客户端向应用程序发送请求，容器创建一个FilterChain，其中包含Filter实例和Servlet，它们应该根据请求URI的路径来处理HttpServletRequest。在Spring MVC应用程序中，Servlet是DispatcherServlet的一个实例。最多，一个Servlet可以处理单个HttpServletRequest和HttpServletResponse。但是，可以使用多个Filter:

# SecurityFilterChain
SecurityFilterChain中的安全过滤器通常是bean，但是它们是在FilterChainProxy而不是DelegatingFilterProxy上注册的。FilterChainProxy为直接向Servlet容器或DelegatingFilterProxy注册提供了许多优点。首先，它为Spring Security的所有Servlet支持提供了一个起点。因此，如果您试图排除Spring Security的Servlet支持的故障，在FilterChainProxy中添加一个调试点是一个很好的开始。 
其次，由于FilterChainProxy是Spring Security使用的核心，它可以执行被视为非可选的任务。例如，它清除SecurityContext以避免内存泄漏。它还应用了Spring Security的HttpFirewall来保护应用程序免受某些类型的攻击。 
此外，它在确定何时应该调用SecurityFilterChain方面提供了更大的灵活性。在Servlet容器中，Filter实例仅基于URL调用。然而，FilterChainProxy可以通过使用RequestMatcher接口基于HttpServletRequest中的任何东西来确定调用。

# 安全异常处理 
## ExceptionTranslationFilte
ExceptionTranslationFilte允许将AccessDeniedException和AuthenticationException转换为HTTP响应。

# 持久化了SecurityContext



在现代应用程序中不应该使用摘要身份验证，因为它被认为不安全。最明显的问题是必须以明文或加密或MD5格式存储密码。所有这些存储格式都被认为不安全。相反，您应该使用单向自适应密码散列(bCrypt、PBKDF2、SCrypt等)来存储凭据，摘要身份验证不支持这种散列。
Digest Authentication:摘要验证



AbstractUserDetailsAuthenticationProvider

public UserDetails loadUserByUsername(String username)
返回
UserDetails
比较密码
String presentedPassword = authentication.getCredentials().toString();
		if (!this.passwordEncoder.matches(presentedPassword, userDetails.getPassword())) {

UsernamePasswordAuthenticationToken result = UsernamePasswordAuthenticationToken.authenticated(principal,
				authentication.getCredentials(), this.authoritiesMapper.mapAuthorities(user.getAuthorities()));

成功后
successfulAuthentication

SecurityContext context = SecurityContextHolder.createEmptyContext();
		context.setAuthentication(authResult);
		SecurityContextHolder.setContext(context);
		this.securityContextRepository.saveContext(context, request, response);


# json web token
JWT实际上就是一个字符串，它由三部分组成，`头部`、`载荷`与`签名`
## Header
有最基本信息，{"typ":"JWT","alg":"HS256"}， 类型和签名算法；
## playload
存放有效信息,{"sub":"1234567890","name":"itlils","admin":true,"age":18}
## signature
签证信息,将 header (base64后的) + payload (base64后的) + secret(盐)，然后组合加密；
```java
hs256("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Iml0bGlscyIsImFkbWluIjp0cnVlLCJhZ2UiOjE4fQ==",secret);
```
最终的 Header.playload.signature 的jwt;

# Pre-Authentication Framework Classes 认证前框架类

# Http403ForbiddenEntryPoint
AuthenticationEntryPoint

# 什么是跨域
1什么是跨域问题：浏览器的同源策略，导致不能向其他域名发送异步请求。
2同源策略：具有相同的协议（protocol），主机（host）和端口号（port）
# CORS简介
跨域资源共享"（Cross-origin resource sharing）
CORS需要浏览器和服务器同时支持。目前，所有浏览器都支持该功能，IE 浏览器不能低于 IE10。它允许浏览器向跨源服务器，发出 XMLHttpRequest 请求，从而克服了 AJAX 只能同源使用的限制。整个 CORS 通信过程，都是浏览器自动完成，不需要用户参与。对于开发者来说，CORS 通信与同源的 AJAX 通信没有差别，代码完全一样。浏览器一旦发现 AJAX 请求跨源，就会自动添加一些附加的头信息，有时还会多出一次附加的请求，但用户不会有感觉。因此，实现 CORS 通信的关键是服务器。只要服务器实现了 CORS 接口，就可以跨源通信。
# CSRF是指跨站请求伪造（Cross-site request forgery)
是web常见的攻击之一;




方法安全性是通过使用MethodSecurityInterceptor来加强的


# Aouth2.0
授权码模式
先去认证服务器获取授权码，拿着授权码再去认证服务器获取登录令牌token
简化授权模式
密码模式
客户端模式

Authorize Endpoint 授权端点
token Endpoint token令牌端点
introspection Endpoint 校验端点
revocation Endpoint 撤销端点