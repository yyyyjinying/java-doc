## 数据表的增删改查
- 
```sql
    insert into emp (id,name,sex,birthday,salary) values
    (4,'james','male','1985-08-10',50000),
    (5,'marry','female','1987-06-15',30000),
    (6,'carter','male','1995-05-18',10000);
    -- 限定修改的数据，告诉mysql要修改name='james'的那条数据
    update emp set sex='male',salary=10000 where id=5;

  -- 创建一个新表，插入现有表中的数据  
insert into actor_name select first_name,last_name from actor; -- 插入查询结果

CREATE table actor_name (
    first_name varchar(45) not null comment '名字',
    last_name varchar(45) not null comment '姓氏')
select a.first_name,a.last_name from actor a;


CREATE TABLE IF NOT EXISTS t_actor as (select first_name,last_name from actor);

--- 创建唯一索引和普通索引 
sql语句：
alter table actor add unique uniq_idx_firstname(first_name);
alter table actor add index idx_lastname(last_name);

sqlite语句：
create unique index uniq_idx_firstname on actor(first_name);
create index idx_lastname on actor(last_name);
```





