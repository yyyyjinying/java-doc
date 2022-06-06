# 虚拟机配置gitlab
参考如下文档：
- https://blog.csdn.net/GyaoG/article/details/113924368
- https://about.gitlab.cn/install/

# 修改
- vi /etc/gitlab/gitlab.rb
```yml
external_url "http://172.16.147.184:7070"
```
# 重置Gitlab
- gitlab-ctl reconfigure

# 执行重启Gitlab
- gitlab-ctl restart

### consoc7 firewall
- systemctl stop firewalld.service
- firewall-cmd --state // 查看防火墙状态
- firewall-cmd --zone=public --add-port=8080/tcp --permanent // 设置上端口8080
- firewall-cmd --reload // 重启防火墙
- firewall-cmd --zone=public --query-port=8080/tcp  // 检查是否生效

# 浏览器反问地址http://172.16.147.184:7070
- 没有初始化密码，操作忘记密码

## 忘记初始密码
- - gitlab-rails console -e production
- - user = User.where(id: 1).first
- - user.password = 'zhao123456'
- - user.password_confirmation = 'zhao123456'
- - user.save!
- - exit!

## 登录gitlab页面
- 1.创建group
- 2.在group分组下创建仓库
- 3.在uses中添加用户，
- 4.在指定的分组下，分配用户（对仓库的操作权限）；
- 5.用新建的用户重新登录
# 创建远程仓库
- git remote add origin http://172.16.147.184:7070/demo_group/vite_react_app.git
- git branch -M main. // 修改分支
- git push add origin main
- 7.提价代码，提示输入用户名和密码
  
# 测试用户
- root/zhao123456
- zhangsan/zhangsan1234