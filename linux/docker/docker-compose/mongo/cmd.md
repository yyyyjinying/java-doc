# 副本集
# 分片集群
# mongo
- docker run --name mongo -d mongo:4.2.22
- docker exec -it mongo bash
- mongo
<!-- - 数据集
- /data/db
- /etc/mongo
- /etc/mongo/mongod.conf -->
# 拷贝容器中的配置及其数据集
- docker cp mongo:/data/db /root/sorf/mongo

## shell
- db     // 查看当前库
- use user    // 创建库
- 
模糊查询
- db.inventory.find({item:/journ/})
1:升序；-1:降序
- db.inventory.find().sort({qty:-1})
分页
- db.inventory.find().sort({qty:-1}).skip(3).limit(2)

# 配置副本集
```mongo
var config={
    _id:"rs",
    members:[
        {_id:0,host:"172.16.147.192:27017"},
        {_id:1,host:"172.16.147.192:27018"},
        {_id:2,host:"172.16.147.192:27019"},
    ]
}
rs.initiate(config);

副本服务执行如下命令可以查看集合文档
rs.secondaryOk();
```

