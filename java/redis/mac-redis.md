# 在mac中开启redis

- redis-server  # 开启redis服务
- redis-cli         # 开启redis客户端（必须先开启服务才能使用客户端）
- - quit        # 关闭Redis客户端的连接
- redis-cli shutdown        # 关闭redis服务

# 查看reids相关进程
- ps aux|grep redis

# 命令行快速查找对应文件 mdfind语句
- mdfind redis.conf