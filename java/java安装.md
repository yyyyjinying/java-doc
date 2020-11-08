## 检查版本
`/usr/libexec/java_home -V`

> 1.8.0_201, x86_64:	"Java SE 8"	/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home

## 配置当前环境
即Mac下的.bash_profile 文件的路径是 /Users/YourMacUserName/.bash_profile
```
vi .bash_profile  #打开配置的文件

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home
export CLASSPAHT=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$JAVA_HOME/bin:$PATH:

source .bash_profile #当配置完成后运行，让配置生效
```

> 将"PATH=$PATH:$JAVA_HOME/bin"中的字符串“$PATH:$JAVA_HOME/bin”合并到原来已存在的PATH中；在原有PATH字符串后面加上“:$PATH:$JAVA_HOME/bin”，
>  PATH=$PATH:$JAVA_HOME/bin