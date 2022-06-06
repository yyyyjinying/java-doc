# 如何生成git本地密钥
查看是否有本地密钥
- pwd ~     // /Users/yyyyjinying
- ls ~/.ssh
- vim ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0sNOT9+QdkU2WKStJLSaAHghKYrQHljjJmWhjXP+TwmvrXXDBaOmt58RZJ6Xzw2ntOtkHqzGp1AqEcdzSgmY087Rp7KjvBxf8pftRg9RQwTV7CWvLNeflIq4v0roOyckch9RyIog0BrTOiET0sr6w3h8UyHYpeKIiXIISlJ6VokjHcTplmn6pTDf541UJ+zGviHJZSQAINSPJNt4ZNtNR6r9hfTPe1zfUqRePHPV9eeZtWWXUYw44zugC7QO9rZulOcduCO0bmZIIqjhR3rCY6EB4+FzpDB6EjZ9t3XTNuejL73ksJO7a6z94OiyAyox5corDPYNM+UXMrWlUo2hN yyyyjinying


# 检查现有的 SSH 密钥
- $ ls -al ~/.ssh   // Lists the files in your .ssh directory, if they exist
- git config --global --list        // 查看全局配置

```yml
Host github.com  
User xxxxx@xx.com  
Hostname ssh.github.com  
PreferredAuthentications publickey  
IdentityFile ~/.ssh/id_rsa  
Port 443
```