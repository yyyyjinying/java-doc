如果不需要随请求发送body,选none；
# body所需的数据类型
form-data（表单类型）、urlencoded（URL编码）、raw（原始类型）、binary（二进制）或GraphQL（图形语言）；
# form-data（表单类型）
Content-Type: multipart/form-data
form-data和 x-www-form-urlencoded 这两种类型，Postman 将自动附加正确的Content-Type请求头参数；

Content-Type: application/json

# x-www-form-urlencoded urlencoded（URL编码)
Content-Type: application/x-www-form-urlencoded
概述：
x-www-form-urlencoded纸面翻译即所谓url格式的编码，是post的默认Content-Type，其实我觉得可以认为get和post的默认表单数据传递格式都一样，只是一个在url地址后面加 ？再加表单数据，另一个是把表单数据写在请求体內
用处：
get请求的请求体格式是什么？get请求是拼接在url后面请求的，一般如此username=tom&pwd=123，这样的格式叫查询参数，x-www-form-urlencoded也长这样，只是不添加到url后面；要知道post的默认数据传输格式就是x-www-form-urlencoded，所以为什么在post数据的时候需要把数据转为url格式（username=tom&pwd=123），一般使用qs库的qs.stringify()方法就能把json对象转换成url格式编码;
# 当传入参数是x-www-form-urlencoded,java后台接收
```java
@PostMapping("/efly/get")
@ResponseBody
public RespEntity getEFlyReturnPR(@RequestBody String cd) {
    System.out.println("接收到的x-www-form-urlencoded");
    System.out.println(cd);
    // id=2&name=3
    return new RespEntity(RespCode.CODE_200,cd);
}
@PostMapping("/efly/get")
@ResponseBody
public RespEntity getEFlyReturnPR(@RequestBody Map<String, String> params) {
    System.out.println("接收到的x-www-form-urlencoded");
    System.out.println(params);
    // [id=2]
    return respEntity=new RespEntity(RespCode.CODE_200,cd);
}
@PostMapping("/efly/get")
@ResponseBody
public RespEntity getEFlyReturnPR(@RequestParam Map<String, String> params) {
    System.out.println("接收到的x-www-form-urlencoded");
    System.out.println(params);
    // [id=2]
    return respEntity=new RespEntity(RespCode.CODE_200,params);
}
```

# raw（原始类型）
Content-Type: text | json | javascript | html | xml

# binary（二进制）
图片，视频，音频，文件

# Graph图型语言

# 请求头中的Authorization
标头是通用的 HTTP 认证框架的一部分。它可以与许多身份验证方案一起使用；
常见的身份认证方案：
Basic
See RFC 7617, base64-encoded credentials. More information below.

Bearer
See RFC 6750, bearer tokens to access OAuth 2.0-protected resources
`承载令牌来访问受OAuth 2.0保护的资源`
本规范描述了如何在HTTP中使用承载令牌请求访问OAuth 2.0保护的资源。任何一方拥有一个持票人令牌(简称“持票人”)就可以用它来获得访问权限相关资源(无需证明拥有密钥)。为了防止误用，不记名令牌需要在储存和运输中不被泄露。
Digest
See RFC 7616. Firefox 93 and later support the SHA-256 algorithm. Previous versions only support MD5 hashing (not recommended).

# Basic 身份验证
Authorization: Basic <credentials>
对于 "Basic" 身份验证，凭据首先将用户名和密码使用一个冒号（aladdin:opensesame）相结合，然后将生成的字符串编码为 base64（YWxhZGRpbjpvcGVuc2VzYW1l）;
Authorization: Basic YWxhZGRpbjpvcGVuc2VzYW1l
# Digest (文摘)身份验证
Authorization: Digest username=<username>,
    realm="<realm>",
    uri="<url>",
    algorithm=<algorithm>,
    nonce="<nonce>",
    nc=<nc>,
    cnonce="<cnonce>",
    qop=<qop>,
    response="<response>",
    opaque="<opaque>"

Authorization: <auth-scheme>  <authorization-parameters>
Authorization: 授权认证-方案 认证参数

# content-type
请求头中，content-type表示头,用于指示资源的原始媒体类型；
在响应中，content-type报头向客户端提供返回内容的实际内容类型；
请求(如POST或PUT)中，客户端告诉服务器实际发送的数据类型
Content-Type: text/html; charset=utf-8
Content-Type: multipart/form-data; boundary=something

字符集 
字符编码标准。不区分大小写，小写字母为佳。

边界 
对于多部分实体，边界指令是必需的。该指令由一组字符(不以空格结束)中的1到70个字符组成，已知通过电子邮件网关非常健壮。它用于封装消息的多个部分的边界。通常，标题边界在前面加上两个破折号，最终边界在末尾附加两个破折号。
```sql
POST /foo HTTP/1.1
Content-Length: 68137
Content-Type: multipart/form-data; boundary=---------------------------974767299852498929531610575

-----------------------------974767299852498929531610575
Content-Disposition: form-data; name="description"

some text
-----------------------------974767299852498929531610575
Content-Disposition: form-data; name="myFile"; filename="foo.txt"
Content-Type: text/plain

(content of the uploaded file foo.txt)
-----------------------------974767299852498929531610575--
```