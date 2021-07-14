## mac自带的快速截屏 commond + shift + 4
- pwd # 查看当前文件
- chgrp：更改文件属组
  - chgrp [-R] 属组名 文件名
- 更改文件属主，也可以同时更改文件属组  R表示递归
  - chown [–R] 属主名 文件名
  - chown [-R] 属主名：属组名 文件名
- chmod：更改文件9个属性
  - chmod [-R] u=rwx,g=rx,o=r  test1    // 修改 test1 权限
  - chmod [-R] 754 test1  / r:4 w:2 x:1

  