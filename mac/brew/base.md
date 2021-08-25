### 安装brew国内
- /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
### cask安装mac系统的软件以及卸载
- brew install --cask firefox 
- brew uninstall firefox

- brew install redis
- 
- brew install  XXX 安装软件
- brew uninstall XXX  卸载软件
- brew list  列出已安装的软件
- brew search XXX 你不知道你安装的软件的名字， 那么你需要先搜索下, 查到包的名字。
- brew update     更新brew
- brew home       用浏览器打开brew的官方网站
- brew info   XXX      显示软件信息
- brew deps        显示包依赖
- brew outdated 会列出所有有新版本的程序
- brew upgrade 升级所有 当然也可以指定升级
- brew upgrade xxx 指定的升级的程序名
- #清理
- brew cleanup 清理不需要的版本及其安装缓存
- #更多命令详见
- - man brew

### 查看安装及配置文件位置
- Homebrew安装的软件会默认在/usr/local/Cellar/路径下
- redis的配置文件redis.conf存放在/usr/local/etc路径下

- brew services start redis
- redis-server /usr/local/etc/redis.conf
- redis-server
- ps axu | grep redis
- redis-cli -h 127.0.0.1 -p 6379
- redis-cli shutdown
- sudo pkill redis-server


    

    

    

    