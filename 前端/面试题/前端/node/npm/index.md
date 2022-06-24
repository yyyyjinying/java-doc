# npm包 ^和~的区别
~1.1.2，表示>=1.1.2 <1.2.0
^1.1.2 ，表示>=1.1.2 <2.0.0
^0.2.3 ，表示>=0.2.3 <0.3.0
^0.0，表示 >=0.0.0 <0.1.0
# nvm切换node
- nvm use default
- npm i pnpm -g
- pnpm i eslint-config-standard eslint-plugin-import eslint-plugin-promise eslint-plugin-node eslint -D
-  sudo pnpm i husky
-  npx husky install
-  pnpm husky add .husky/pre-commit "pnpm run lint"
# pnpm
## 本质上他是一个包管理工具，和npm/yarn没有区别，主要优势在于
- 包安装速度极快
- 磁盘空间利用效率高