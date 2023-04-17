curl -s "https://get.sdkman.io" | bash
> cd ~
> vi .bash_profile
> $HOME/.sdkman/bin/sdkman-init.sh
> source .bash_profile
> sdk list java
> sdk install java 17.0.5-zulu
> sdk current java
> sdk home java 17.0.5-zulu
>
> 如果你不知道有多少个jdk可以使用如下查找
> ls /Users/yyyyjinying/.sdkman/candidates/java
> sdk use java 8.0.362-zulu
> java -version
>
# shift + command + .     可以快速切换查看隐藏文件