# 什么是nginx
nginx("engine X")是一个高性能的http和反向代理服务器，特点是占有内存少，并发能力强，事实上nginx的并发能力确定，在同类型的网页服务器中表现较好；nginx专门为性能优化而开发，性能是其最重要的考量，实现上非常注重效率，能经受高负载的考验，有报告表明能支持高达
50000个并发连接数。
Nginx ("engine x") 是一款开源的，支持高性能、高并发的 Web 服务和代理服务软件。它是由俄罗斯人 Igor Sysoev 开发的，最初被应用在俄罗斯的大型网站 www.rambler.ru 上。后来作者将源代码以类 BSD 许可的形式开源出来供全球使用。因为它的稳定性、丰富的模块库、灵活的配置和低系统资源的消耗而闻名。目前，市场上还有很多的同类竞品，如大名鼎鼎的apache，Lighttpd。目前，Nginx的市场份额和域数量双双稳居世界第一，并以 4.12 亿的总数遥遥领先其它竞争对手。
2.代理服务器
（1） 正向代理：在客户端（浏览器）配置代理服务器，通过代理服务器访问浏览器；
（2）反向代理：其实客户端对代理是无感知的，因为客户端不需要任何配置就可以访问，我们只需要将请求发送到反向代理服务器，由反向代理服务器去`选择目标服务器`获取数据，在返回给客户端，此时反向代理服务器和目标服务器对外就是一个服务器，
暴漏的是代理服务器地址，隐藏了真实服务器ip地址。
3.负载均衡：单个服务器解决不了，我们增加服务器的数量，然后将请求分发到各个服务器上，将原先请求集中到单个服务的情况改为将请求分发到多个服务器上，将负载分发到不同的服务器，也就是我们所说的负载均衡；
4.动静分离：为了加快网站的解析速度，可以把动态页面和静态页面由不同的服务器来解析，加快解析速度。降低原来单个服务器的压力。
nginx可以提供的服务：
负载均衡 （反向代理）：日pv2000W以下，都可以直接用nginx做代理。
web cache（web 缓存）：缓存服务
web 服务：静态服务器。用来存放我们的静态资源，如图片、静态页面、js、css等。
nginx 的优点：
比其他服务器响应更快；高扩展，nginx的设计极具扩展性，他是由多个功能不同且耦合性极低的模块组成；单机支持并发极高，理论上支持10万的并发连接，nginx支持的并发连接和内存相关，超过10万也是可以的；低内存消耗，10000个非活跃的http keep-alive链接在nginx中仅仅消耗2.5M的内存；支持热部署，如不用停止服务就能重新加载配置文件；极具自由的BSD许可协议。我们不仅可以直接阅读nginx的源代码、还能用来修改升级；

# BSD协议
如果再发布的产品中包含源代码，则在源代码中必须带有原来代码中的BSD协议；
如果再发布的只是二进制类库/软件，则需要在类库/软件的文档和版权声明中包含原来代码中的BSD协议；
不可以用开源代码的“作者/机构的名字”或“原来产品的名字”做市场推广；
在常见的开源协议如BSD, GPL, LGPL,MIT等都是OSI批准的协议；
Apache License 2.0：它是对商业应用友好的许可。使用者也可以在需要的时候修改代码来满足需要并作为开源或商业产品发布/销售。BSD开源协议（Berkerley Software Distribution）：商业软件可以使用，也可以修改使用BSD协议的代码。MIT ( MIT license )：商业软件可以使用，也可以修改MIT协议的代码，甚至可以出售MIT协议的代码。MPL ( Mozilla Public License 1.1 )：商业软件可以使用，也可以修改MPL协议的代码，但修改后的代码版权归软件的发起者。CDDL (Common Development and Distribution License )：商业软件可以使用，也可以修改CDDL协议的代码。EPL (Eclipse Public License 1.0 )：商业软件可以使用，也可以修改EPL协议的代码，但要承担代码产生的侵权责任。GPL ( GNU General Public License )：商业软件不能使用GPL协议的代码。LGPL ( GNU Library or “Lesser” General Public License )：商业软件可以使用，但不能修改LGPL协议的代码。
# 配置文件解读
```conf
main{ #（全局设置）
    http{ #服务器配置
        upstream{} #（负载均衡服务器设置）
        server{ #（主机设置：主要用于指定主机和端口）
            location{} #（URL匹配的设置）
        }
    }
}
server继承自main，location继承自server，upstream即不会继承其他设置也不会被继承。
```
```conf
user ydlclass;
worker_processes 4;
worker_cpu_affinity 0001 0010 0100 1000;
error_log  /data/nginx/logs/error.log  crit;
pid        /data/nginx/logs/nginx.pid;
worker_rlimit_nofile 65535;
```
user nginx: 指定nginx进程使用什么用户启动;
worker_processes 4; : 指定启动多少进程来处理请求，一般情况下设置成CPU的核数，如果开启了ssl和gzip应该设置成与逻辑CPU数量一样甚至为2倍，可以减少I/O操作。使用grep ^processor/proc/cpuinfo | wc -l查看CPU核数。
worker_cpu_affinity 0001 0010 0100 1000;: 在高并发情况下，通过设置将CPU和具体的进程绑定来降低由于多核CPU切换造成的寄存器等现场重建带来的性能损耗。如worker_cpu_affinity 0001 0010 0100 1000; （四核）。
error_log logs/error.log;: error_log是个主模块指令，用来定义全局错误日志文件。日志输出级别有debug、info、notice、warn、error、crit可供选择，其中，debug输出日志最为最详细，而crit输出日志最少。
pid logs/nginx.pid;: 指定进程pid文件的位置。
我们可以使用ps -ef | grep nginx查看master和worker的进程，这里有一个master和四个worker：
# events模块
主要是nginx 和用户交互网络连接优化的配置内容
```conf
events{
  use epoll;
  worker_connections  65536;
}
```
use epoll;是使用事件模块指令，用来指定Nginx的工作模式。Nginx支持的工作模式有select、poll、kqueue、epoll、rtsig和/dev/poll。其中select和poll都是标准的工作模式，kqueue和epoll是高效的工作模式，不同的是epoll用在Linux平台上，而kqueue用在BSD系统中。对于Linux系统，epoll工作模式是首选。在操作系统不支持这些高效模型时才使用select。
worker_connections 65536;每一个worker进程能并发处理（发起）的最大连接数。
# http服务器
```conf
http{
  include       mime.types;
  default_type  application/octet-stream;
  #charset  gb2312;
  sendfile        on;
  keepalive_timeout  60s;
}
```
include是个主模块指令，实现对配置文件所包含的文件的设定，可以减少主配置文件的复杂度。该文件也在conf目录中。
default_type属于HTTP核心模块指令，这里设定默认类型为二进制流，也就是当文件类型未定义时使用这种方式。
charset gb2312; 指定客户端编码格式。
sendfile实际上是 Linux2.0+以后的推出的一个系统调用，web服务器可以通过调整自身的配置来决定是否利用 sendfile这个系统调用。sendfile是个比 read 和 write 更高性能的系统接口。 当 Nginx 是一个静态文件服务器的时候，开启 SENDFILE 配置项能大大提高 Nginx 的性能。 但是当 Nginx 是作为一个反向代理来使用的时候，SENDFILE 则没什么用。
Nginx 使用 keepalive_timeout 来指定 KeepAlive 的超时时间（timeout）。指定每个 TCP 连接最多可以保持多长时间。Nginx 的默认值是 75 秒，有些浏览器最多只保持 60 秒，所以可以设定为 60 秒。若将它设置为 0，就禁止了 keepalive 连接
# 虚拟主机配置详解
http服务上支持【若干虚拟主机】。每个虚拟主机对应一个server配置项，配置项里面包含该虚拟主机相关的配置。
```conf
server{
    listen 80 default;
    server_name www.ydlclass.com;
    index index.html index.htm index.php;
    root /data/www;

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)${
        expires      30d;
    }

    location ~ .*\.(js|css)?${
        expires      1h;
    }
}
```
listen 80; 监听端口，默认80，小于1024的要以root启动。可以为listen :80、listen 127.0.0.1:80等形式。
server_name www.ydlclass.com 用于设置虚拟主机服务名称，如：127.0.0.1 、 localhost 、域名[www.baidu.com | www.jd.com]，也可以进行正则匹配。
root /data/www 定义服务器的默认网站根目录位置。可以是linux的绝对路径（/xxx/xx），也可以是nginx安装目录的相对路径（html）。
index index.jsp index.html index.htm ：定义路径下默认访问的文件名，一般跟着root放。

# location 常见的配置项：
=表示匹配uri时必须做到完全匹配
~表示匹配URI时是字母大小写敏感的
~*表示匹配URI时是忽略字母大小敏感的
^~表示匹配uri时只需满足前缀匹配即可
匹配的优先顺序，= > ^~（匹配固定字符串，忽略正则）> ~* > / 

以root方式设置资源路径,语法 root path ，默认 root html，可以在http、server、location模块中配置。
```conf
location ^~ /backend {
	root /data/www/backend
}
```
如果url为 /backend/index/test.html则会返/data/www/backend/backend/index/test.html这个文件;

以alias方式设置资源路径:
```conf
location ^~ /backend {
	alias /data/www/backend
}
```
如果url为 /backend/index/test.html则会返回/data/www/backend/index/test.html文件
`alias会将location后的url部分丢弃掉，而root不会。`
# try_files
该配置项可以配置在server、location模块。try_files后边会跟若干路径，nginx会尝试按照顺序访问每一个path，如果可以有效的读取，就直接访问当下path资源，否则继续向下访问，如果都读取不到就重定向到uri参数上
```conf
try_files /a/b.html $uri $uri/index.html $uri.html @other;
location @other {
    proxy_pass http://backend
}
```
$uri是一个变量，他就是具体的url，对一/js/app.aa11d15b.js这个请求，首先会访问/data/www/ui/js/app.aa11d15b.js这个资源，当然存在，就直接返回了，而其他的路由资源会使用index.html：
```conf
location / {
    root /data/www/ui;
    try_files $uri $uri/ $uri/index.html $uri.html /index.html;
}
```
# 对图片开启gzip压缩
在http模块中添加如下内容：
```conf
http {
    gzip on;
    gzip_min_length 1k;
    gzip_buffers    4 16k;
    gzip_http_version 1.1;
    gzip_comp_level 5;
    gzip_types image/png;
    gzip_vary on;
}
```
gzip on;使用"gzip on;"参数来启用压缩，默认是关闭的。

gzip_min_length 1k;gzip压缩的最小文件，小于设置值的文件将不会压缩#指定Nginx服务需要向服务器申请的缓存空间的个数*大小，默认32 4k|16 8k;

gzip_buffers 4 16k;设置压缩缓冲区大小，此处设置为4个16K内存作为压缩结果流缓存

gzip_http_version 1.1;启用压缩功能时，协议的最小版本，默认HTTP/1.1

gzip_comp_level 5;压缩比例由低到高从1到9，默认为1。但需要注意的是压缩比设置的越高就会越消耗CPU的资源，因此在生产环境中我们会设置该参数的值在3~5之间，最好不要超过5，因为随着压缩比的增大的确会降低传输的带宽成本但发送数据前会占用更多的CPU时间分片。

gzip_types image/png;指明仅对哪些类型的资源执行压缩操作；默认为gzip_types text/html，不用显示指定，否则出错。

gzip_vary on;该指令用于设置在使用Gzip功能时是否发送带有“Vary: Accept-Encoding”头域的响应头部。该头域的主要功能是告诉接收方发送的数据经过了压缩处理。开启后的效果是在响应头部添加了Accept-Encoding: gzip，这对于本身不支持Gzip压缩的客户端浏览器是有用的。
# 反向代理解决跨域
我们的实现逻辑很简单，就是将以/api为前缀的uri全部反向代理到真正的后端服务即可
将前端发送的以api打头的url全部代理到，后端8080端口：
前端访问的接口：http://192.168.111.200:80/api/host
后端的接口：http://192.168.111.200:8080/host
```conf
方法一
location ^~ /api/ {
    rewrite ^/api(.*)$ $1 break;
    proxy_pass http://127.0.0.1:8080;
}
方法二
location ^~ /api/ {
    proxy_pass http://127.0.0.1:8080/;
}
```
location中的rewirte：

rewrite break：url重写后，直接使用当前资源，不再执行location里余下的语句，完成本次请求，地址栏url不变；rewrite last：url重写后，马上发起一个新的请求，再次进入server块，重试location匹配，超过10次匹配不到报500错误，地址栏url不变；rewrite redirect：返回302临时重定向，地址栏显示重定向后的url

# 为后端工程做负载均衡
我们的后端工程压力太大，可能需要将后端工程部署在多台服务器上，此时就需要使用负载均衡了
nginx 的负载均衡功能依赖于 ngx_http_upstream_module模块。upstream 模块应该放于http{}标签内。
```conf
upstream backend {
    ip_hash; 
    server backend1.example.com;
    server backend2.example.com:8080;
    server 127.0.0.1:8080;
    server backup2.example.com:8080;
}
```
# nginx分配服务的策略
- 第一种方式： `轮询`（默认）：每次请求`按时间顺序逐一分配`到不同的后端服务器。如果后端服务器down掉，能自动剔除。
- 第二种方式： weight代表权重默认1，`权重越高`，被分配的客户端越多。
- 第三种方式： ip hash 每个`请求按访问IP的hash结果分配`，这个样每个访客固定访问一个后端服务器，可以解决session共享的问题；
- fair方式 ： 按后端服务器的`响应时间`来分配请求，响应时间短的优先分配；
round robin 轮询 （默认） 按时间顺序依次将请求分配到各个后台服务器中，挂掉的服务器自动从列表中剔除;
weight 轮询权重 weight的值越大分配到的访问概率越高，主要用于后端每台服务器性能不均衡的情况下，或在主从的情况下设置不同的权值，达到合理有效的地利用主机资源。
ip_hash：每个请求按访问IP的哈希结果分配，使来自同一个IP的访客固定访问一台后端服务器，并且可以有效解决动态网页存在的session共享问题。
url_hash：按访问的URL的哈希结果来分配请求，使每个URL定向到同一台后端服务器，可以进一步提高后端服务器缓存的效率。Nginx本身不支持url_hash，需要安装Nginx的hash软件包。
fair算法：可以根据页面大小和加载时间长短智能地进行负载均衡，根据后端服务器的响应时间来分配请求，响应时间短的优先分配。Nginx本身不支持fair，要安装upstream_fair模块才能使用。

java -jar ydl-nginx.jar --server.port=8081
```conf
upstream ydlclass {
    server 127.0.0.1:8080 weight 10;
    server 127.0.0.1:8081 weight 20;
}
location ^~ /api/ {
    proxy_pass http://ydlclass/;
}
```
# 其他的跨域问题
一个典型的不同的项目之间进行访问的问题，这必然存在跨域问题
根据我们学习过的知识要解决跨域问题。其实，只需要在客户端发送【预检请求】时指定对应的响应头即可，nginx可以很方便的给响应增加一些首部信息，方法如下，在：
```js
mounted(){
    axios.get('http://192.168.111.200/api/host').then(res=>{
      this.host = res.data
    })
  }
```
```conf
location ^~ /api/ {
    add_header 'Access-Control-Allow-Origin' '*';
	add_header 'Access-Control-Allow_Credentials' 'true';
	add_header 'Access-Control-Allow-Headers' 'Authorization,Accept,Origin,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
	add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS,PUT,DELETE,PATCH';
    proxy_pass http://ydlclass/;
}
```
# nginx监控
```conf
#设定查看Nginx状态的地址   
location = /status {  
  stub_status on;   	#表示开启stubStatus的工作状态统计功能。
  access_log off;
  allow 192.168.10.100; # 访问控制 allow/deny
  allow 172.29.73.0/24;
  deny all;
}
```
我们可以访问/status查看当前nginx的状态;
# 列出目录 autoindex
```conf
location ^~ /file {
    root   /data/www;
    autoindex on;
    autoindex_exact_size off;
    autoindex_localtime on;
    charset utf-8,gbk;
}
```
autoindex on;运行列出目录内容。另外两个参数最好也加上去。
autoindex_exact_size off; 默认为on，显示出文件的确切大小，单位是bytes。改为off后，显示出文件的大概大小，单位是kB或者MB或者GB。
autoindex_localtime on; 默认为off，显示的文件时间为GMT时间。改为on后，显示的文件时间为文件的服务器时间。
# 什么是nginx的高可用
- 需要两台nginx服务器
- 需要keepalived
- 需要虚拟IP
- # keepalived.conf
```conf
vrrp_instance VI_1 {
    state MASTER  			#主为MASTER 备为BACKUP
    interface ens33  		#ens33为绑定的网卡名，此处请根据现实情况更改
    virtual_router_id 2 	#虚拟路由ID，负责相同虚拟IP的keepalived集群最好定义为相同的id
    priority 101 			#优先级，MASTER的优先级必须比BACKUP的高
    advert_int 2
    authentication {
        auth_type PASS 
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.11.96  		#虚拟IP
    }
}

```



