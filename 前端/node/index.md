# mac的node版本升级
- sudo npm cache clean -f

使用node的包管理器
- sudo npm install -g n

查看node的所有版本
- npm view node versions

升级到最新版本
- sudo n latest
 
升级到稳定版本
- sudo n stable
 
升级到具体版本号
- sudo n xx.xx
## node 文件加载的过程

## nvm \ npm \ nrm 
node version manager
node package manager
npm resource manager
### 参考博客
- https://www.cnblogs.com/J-Nemo/p/11449059.html
## npm
- npm view node versions
- nvm ls
- nvm install 8.14.0 // 安装v8.14.0版本的node.js。
- nvm use 8.14.0
- nrm use npm
- npm login
- npm publish
- npm config set registry "http://^^^"
  
## n 安装和切换node版本
- sudo npm i -g n
- n -V
- n ls
- n xx.xx.x (xx.xx.x 为要安装的版本号)
- n lastest
- n stable
- n rm xx.xx.x
- n use xx.xx.x
- n use xx.xx.x a.js

# nvm use --delete-prefix v15.14.0 --silent
