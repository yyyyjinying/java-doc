## mac自带的快速截屏 commond + shift + 4
- pwd # 查看当前文件
- chgrp：更改文件属组
  - chgrp [-R] 属组名 文件名
- 更改文件属主，也可以同时更改文件属组  R表示递归
  - chown [–R] 属主名 文件名
  - chown [-R] 属主名：属组名 文件名
  - sudo chown -R yyyyjinying changgou 
- chmod：更改文件9个属性
  - chmod [-R] u=rwx,g=rx,o=r  test1    // 修改 test1 权限
  - chmod [-R] 754 test1  / r:4 w:2 x:1


### 重启Linux
- reboot
- su root // 切换root用户
- su linux // 切换普通用户
- lsb_release -a // 查看系统版本
- sudo apt-get install vim-gtk
- tar zxvf redis-3.0.0.gz //解压文件 
- apt install gcc
- cd redis-3.0.0 
- make
- make install PREFIX=/usr/local/redis
- cp /usr/local/tmp/redis-3.0.0/redis.conf /usr/local/redis/bin
- cd /usr/local/redis/bin
- ./redis-server redis.conf     // 开启redis服务
- ./redis-cli shutdown  // 关闭redis服务
- ./redis-cli    // 开启本地redis
  

  