## 一、创建数据库
- show databases; <!-- 查看数据库 -->
- create database database_name default character set utf8; <!--创建数据库-->
- show create database database_name; <!--查看创建好的数据库定义-->
- drop database database_name; <!--删除数据库-->
- use aaa; <!--选择当前数据库-->

## 数据库存储引擎
- 存储引擎提供不同的存储机制、索引技巧、锁定水平等功能；
    - InnoDB,MyISAM,Memory,Merge,Archive,Federated,CSV,BLACKHOLE等
    - show engines \G; <!--查看系统中所有的存储引擎-->
    - show variables like '%storage_engine%';<!--查看默认的存储引擎-->
    - alter table tableName engine = 存储引擎名;
    - InnoDB存储引擎 支持事务安全
    - MyISAM存储引擎 拥有较高的插入、查询速度、但不支持事务
  
## 数据表
  > 基本操作对象，数据存储的基本单位；行：记录，列：记录中的一个域；
  ```sql
    use ssaa;
    create table emp(
        id int(10) primary key AUTO_INCREMENT,
        name varchar(100) comment "备注",
        sex char(6),
        birthday date,
        salary float(10,2)
    );

    create table emp_01(
        id int(11) PRIMARY KEY AUTO_INCREMENT, -- 属性值自动增加
        name varchar(25),
        deptId int(11),
        salary float
    );

    create table emp_02(
        id int(11) NOT NULL, -- 非空约束
        name varchar(25) UNIQUE DEFAULT "11", -- 唯一性约束，允许有空值
        deptId int(11),
        salary float,
        PRIMARY KEY (id,deptId) -- 不允许有空值
    );
  ```
  ### 表查询
  - show tables;
  - describe emp; <!--简写：desc emp;-->
  - show create table <表名\G>; <!--加上’\G‘显示直观-->
  - drop table s_user; <!--删除表结构->
  - 
  ### 修改数据表
  - DROP TABLE table_name ; <!--删除数据表-->
  - delete from s_user；   <!-- 删除表中数据 -->
  - alter table emp1 character set utf8; <!--设置字符编码-->
  - alter table <旧表名> rename <新表名>; <!--修改表名-->
  - rename table <旧表名> to <新表名>; <!--修改表名-->
  - alter table <表名> modify <字段名> <数据类型>; <!--修改字段数据类型-->
  - alter table <表名> change <旧字段名> <新字段名> <新数据类型>; <!--修改字段名-->
  - alter table emp1 add age1 int(10) default 12 FIRST;
  -  - alter table emp1 add age2 int(10) default 12 AFTER username;
  - alter table <表名> drop <字段名>; <!--删除表字段-->
  <!-- 追加新的字段 -->
  - alter table <表名> add column <字段名> varchar(30) not null comment "注解" after "字段名";
  <!-- 在表中添加字段 -->
  - alter table `tb_permission` add column `p_tag` varchar(30) default null COMMENT "test" AFTER `url`;
  - alter table <表名> modify <字段1> <数据类型> FIRST|AFTER <字段2>;
  - alter table <表名> engine=<更改后的存储引擎名>;
  - 删除外键```sql
    create table tb_dept2(
        id int(11) PRIMARY KEY,
        name varchar(22),
        location varchar(50)
    );

    create table tb_emp(
        id int(11) PRIMARY KEY,
        name varchar(25),
        deptId int(11),
        salary float,
        constraint fk_emp_dept FOREIGN KEY (deptId) REFERENCES tb_dept2(id)
    );
    ```
- alter table tb_emp drop FOREIGN KEY fk_emp_dept;
- 外键约束不能跨引擎使用；
- alter table `tb_permission` add column `p_tag` varchar(30) default null COMMENT "test" AFTER `url`;

# join left join,right join, full join
join等价于inner join内连接抄，是返回两个表中都有的符合条件的行。
left join左连接，是返回左袭表知中所有的行及右表中符合条件的行。
right join右连接，是返回右表中所有的行及左表中符合条件的行。
full join全连接，是返回左表中所有的行及右表中所有的行，并按条件连接.
## where和having区别

- where和having都是为了完成数据的过滤，它们后面都是添加条件；
- where是在 group by之前完成过滤；
- having是在group by之后完成过滤；
- where 后面不可以写聚合函数

## select语句总结
一个的SQL语句如下：
```sql
    select 
        xxxx
    from
        xxxx
    where 
        xxxx
    group by
        xxxx
    having
        xxxx
    order by
        xxxx
```
以上关键字的顺序不能变，严格遵守
以上语句的执行顺序：

- from 将硬盘上的表文件加载到内存
- on
- join
- where:将符合条件的数据筛选出来。生成一张新的临时表
- group by :根据列中的数据种类，将当前临时表划分成若干个新的临时表
- having : 可以过滤掉group by生成的不符合条件的临时表
- select : 对当前临时表进行整列读取
- order by : 对select生成的临时表，进行重新排序，生成新的临时表
- limit : 对最终生成的临时表的数据行，进行截取
MySQL中语句的执行顺序

SQL语句执行顺序
```sql
from

on <on_condition>

<join_type> join <join_table>

where <where_condition>

group by <group_by_list>

<sum()、avg()等聚合函数>

having <having_condition>

select <select_list>

distinct

order by <order_by_condition>

over()  # 窗口函数

limit <limit_number>

```


## 子查询
定义：select 语句嵌套 select 语句被称为子查询；
注意：select子句可出现在select、from、where关键字后面，如下：
select … (select)…【使用较少，了解即可】
from …(select)…
where …(select)…

## 事务具有四个特征ACID
- 原子性（Atomicity），事务是最小单元，不可再分；
- 一致性（Consistency），事务要求所有的DML语句操作的时候，必须保证同时成功或同时失败；
- 隔离性（Isolation），一个事务不会影响其他事务的执行；
- 持久性（Durability），在事务完成之后，该事务对数据库所作的更改将持久地保存在数据库中，并不会被回滚；
  
### 会话的隔离级别：
- 查看： select @@tx_isolation;
- 修改级别： set global transaction isolation level 隔离级别
- - read uncommitted 读未提交
事务A和事务B，事务A未提交的数据，事务B可以读取，这里读取到的数据叫做“脏数据”，该级别最低，一般只是理论上存在，数据库的默认隔离级别都高于该级别。
- - read committed 读已提交
事务A和事务B，事务A提交的数据，事务B才可读取到，换句话说：对方事务提交之后的数据，当前事务才可读取到，可以避免读取“脏数据”，但是改级别会有“不可重复读”的问题，事务B读取一条数据，当事务A修改这条数据并提交后，事务B再读取这条数据时，数据发生了变化，即事务B每次读取的数据有可能不一致，这种情况叫做“不可重复读”。
- - repeatable read 重复读
MySQL默认的隔离级别是重复读，该级别可以达到“重复读”的效果，但是会有“幻读”的问题，即事务A读取数据，此时事务B修改了这条数据，但是事务A读取的还是之前的旧数据的内容，这样就出现了幻读。
- - serializable 串行化
事务A和事务B，事务A在操作数据库表中数据的时候，事务B只能排队等待，这样保证了同一个时间点上只有一个事务操作数据库，该级别可以解决“幻读”的问题。但是这种级别一般很少使用，因为吞吐量太低，用户体验不好。

## 索引和视图导出和导入
http://www.monkey1024.com/database/841
## 面试题
http://www.monkey1024.com/database/844


```sql
CREATE TABLE `test` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `task_id` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '任务id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin


CREATE TABLE `t_user`(
	`id` INT(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
	`name` varchar(25) NOT NULL COMMENT '名称',
	-- `date` datetime NOT NULL COMMENT '创建时间',
	PRIMARY key (id)
)ENGINE=InnoDB;

```





  
