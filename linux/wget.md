# wget命令解释
Wget主要用于下载文件，在安装软件时会经常用到，以下对wget做简单说明。

1、下载单个文件：wget http://www.baidu.com。命令会直接在当前目录下载一个index.html的文件

2、将下载的文件存放到指定的文件夹下，同时重命名下载的文件，利用-O：wget -O /home/index http://www.baidu.com

3、下载多个文件：首先，创建一个file.txt文件，写入两个url（换行），如http://www.baidu.com;然后，wget -i file.txt;命令执行后会下载两个两个文件。

4、下载时，不显示详细信息，即在后台下载：wget -b http://www.baidu.com。命令执行后会，下载的详细信息不会显示在终端，会在当前目录下生成一个web-log记录下载的详细信息。

5、下载时，不显示详细信息，同时将下载信息保存到执行的文件中（同4）：wget -o dw.txt http://www.baidu.com

6、断点续传：wget -c http://www.baidu.com

7、限制下载的的速度：wget --limit-rate=100k -O zfj.html http://www.baidu.com

8、测试是否能正常访问：wget --spider http://www.baidu.com

9、设置下载重试的次数：wget --tries=3 http://www.baidu.com

10、下载一个完整的网站，即当前页面所依赖的所有文件：wget --mirror -p --convert-links -P./test http://localhost

　　--mirror:打开镜像选项

　　-p:下载所有用于显示给定网址所必须的文件

　　--convert-links：下载以后，转换链接用于本地显示

　　-P LOCAL_DIR：保存所有的文件或目录到指定的目录下

11、下载的过程中拒绝下载指定类型的文件:wget --reject=png --mirror -p --convert-links -P./test http://localhost

12、多文件下载中拒绝下载超过设置大小的文件：wget -Q5m -i file.txt

　　注意：此选项只能在下载多个文件时有用，当你下载一个文件时没用。

13、从指定网站中下载所有指定类型的文件：wget -r -A .png http://www.baidu.com

14、wget下载时，某些资源必须使用--no-check-certificate http://www.baidu.com

15、使用wget实现FTP下载：wget --file-user=USERNAME --file-password=PASSWORD url