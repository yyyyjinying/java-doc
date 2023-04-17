# java key store Java密钥库
jks 是java key store 的简称，也就是java 常用的证书文件. jks 证书文件一般包含私钥以及签名的cert一起组成的. 要生成jks 可以使用java 的keytool工具 以及openssl 来完成，没有特殊需求的情况先，可以只用这两个工具就可以了；
```shell
# 使用 "keytool -help" 获取所有可用命令
> keytool -help
```
> keytool -genkeypair -help
> keytool -genkeypair -alias mytest -keyalg RSA -keypass mypass -keystore mytest.jks -storepass mypass
> 生成密钥对 - 要处理的条目的别名 - 密钥算法名称 - 密钥口令 - 密钥库名称 - 密钥库口令
> 生成的mytest.jks证书中包含我们的密钥 ：公钥和私钥。
> keytool -list -v -keystore mytest.jks 查看JKS中生成的证书的详细信息
3.如果要导出cer证书。则利用“keytool -alias test -exportcert -keystore mytest.jks -file test.cer”，导出证书，并可以双击打开证书查看证书信息。
4.执行如下命令：keytool -list -rfc -keystore mytest.jks -storepass 你的密码
生成密钥对
选项:
 -alias <alias>                  要处理的条目的别名
 -keyalg <keyalg>                密钥算法名称
 -keysize <keysize>              密钥位大小
 -sigalg <sigalg>                签名算法名称
 -destalias <destalias>          目标别名
 -dname <dname>                  唯一判别名
 -startdate <startdate>          证书有效期开始日期/时间
 -ext <value>                    X.509 扩展
 -validity <valDays>             有效天数
 -keypass <arg>                  密钥口令
 -keystore <keystore>            密钥库名称
 -storepass <arg>                密钥库口令
 -storetype <storetype>          密钥库类型
 -providername <providername>    提供方名称
 -providerclass <providerclass>  提供方类名
 -providerarg <arg>              提供方参数
 -providerpath <pathlist>        提供方类路径
 -v                              详细输出
 -protected                      通过受保护的机制的口令
