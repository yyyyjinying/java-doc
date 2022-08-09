# mac中tomcat安装
- 在/Users/yyyyjinying/sortware中解压apache-tomcat-8.5.79.tar.gz
- tar -zxf apache-tomcat-8.5.79.tar.gz
- cd /Users/yyyyjinying/sortware/apache-tomcat-8.5.79/bin
- ./startup.sh          // 后台运行
- ./shutdown.sh
- ./catalina.sh run     // 有日志打印输出
- ./catalina.sh stop
  
# mac配置.bash_profile环境变量
- sudo vi /Users/yyyyjinying/.bash_profile 
- PATH=$PATH:/Users/yyyyjinying/sortware/apache-tomcat-8.5.79/bin
- cd /Users/yyyyjinying
- source .bash_profile

# 测试
- http://localhost:8080/
# 命令行检测端口是否被占用（与linux系统不通）
- sudo lsof -i tcp:8080
- sudo kill -9 PID