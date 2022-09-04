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
模糊查询你
- db.inventory.find({item:/journ/})
1:升序；-1:降序
- db.inventory.find().sort({qty:-1})
分页
- db.inventory.find().sort({qty:-1}).skip(3).limit(2)

