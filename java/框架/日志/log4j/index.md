日志是应用软件中不可缺少的部分，Apache的开源项目log4j是一个功能强大的日志组件,提供方便的日志记录。在apache网站：jakarta.apache.org/log4j 可以免费下载到Log4j最新版本的软件包

## 1. log4j输出级别
- latal(致命错误) > error (错误) > warn (警告) > info(普通信息) > debug(调试信息)
-  在 log4j.properties 的第一行中控制输出级别
  ```log4j
  log4j.rootCategory=INFO, CONSOLE ,LOGFILE
  ```
 
## 2. pattern中常用几个表达式
- %C 包名+类名 
- %d{YYYY-MM-dd HH:mm:ss} 时间 
- %L 行号
- %m 信息
- %n 换行