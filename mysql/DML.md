## 数据表的增删改查
- 
```sql
    insert into emp (id,name,sex,birthday,salary) values
    (4,'james','male','1985-08-10',50000),
    (5,'marry','female','1987-06-15',30000),
    (6,'carter','male','1995-05-18',10000);
    -- 限定修改的数据，告诉mysql要修改name='james'的那条数据
    update emp set sex='male',salary=10000 where id=5;
    
```




