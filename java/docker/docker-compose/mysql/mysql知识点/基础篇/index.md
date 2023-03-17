



# Sql的分类

| 分类 | 全称                       | 说明                                                       | 查询语句 |
| ---- | -------------------------- | ---------------------------------------------------------- | -------- |
| DDL  | Data Definition language   | 数据定义语言，用来定义数据库对象（数据库表、字段、表）     |          |
| DML  | Data Manipulation language | 数据操作语言，用来对数据库表中的数据进行增删改             |          |
| DQL  | Data Query Language        | 数据查询语言，用来查询数据库表中的记录                     |          |
| DCL  | Data Control Language      | 数据控制语言，用来创建用户数据库用户，控制数据库的访问权限 |          |

## DDL

### 数据库相关的操作

主要的命令有create、alter、drop等，ddl主要是用在定义或改变表(table)的结构,数据类型，表之间的连接和约束等初始工作上，他们大多在建表时候使用。

```sql
# 查询数据库
show databases;

# 创建数据库
create database itcast;
create database if not exists itcast;

# 创建指定的字符集
create database if not exists iwo default charset utf8mb4;

# 删除数据库
drop database iwo;
drop database if exists iwo;

# 切换数据库
use iwo;

# 查看当前所在的数据
select database();

# 查看当前数据库中所有的表
show tables;
#查看表结构
DESC <表名>;
# 查看建表语句
show create table <表>;

# 数据类型
- unsigned 无符号
- 数值类型
- 字符类型
- - 定长字符串，变长字符串，blob二进制（音频视频图片，文件服务器）text文本类型
- 日期时间类型

# 创建员工表
create table `emp`(
	id int comment "编号",
  workno varchar(10) comment "姓名",
	gender char(1) comment "性别",
  age tinyint unsigned comment "年龄",
  idcard char(18) comment "身份证号",
  entrydate date comment "入职日期"
) comment "员工表";
# 添加一条数据
insert into employee(workno,gender,age,idcard,entrydate) values("赵晋英","男",12,"142201199203073818","2012-09-09");
# 修改表结构
#添加字段
alter table emp add nickname varchar(20) comment "昵称";
# 修改字段类型
alter table emp modify nickname varchar(22);
# 字段名和类型
alter table emp change nickname username varchar(30) comment "用户名称";
# 删除字段
alter table emp drop username;
# 修改表名
alter table emp rename to `employee`;
# 删除表,并重新创建表 只删除数据
truncate table employee;
# 删除表
drop table if exists employee;

```



# 约束条件:约束字段的规则

| 约束     | 描述                                       | 关键字      |
| -------- | ------------------------------------------ | ----------- |
| 非空约束 | 限制该字段不能为空                         | NOT NULL    |
| 唯一约束 | 保证字段是唯一，不重复                     | unique      |
| 主键约束 | 一行数据的唯一标识，非空且唯一             | primary key |
| 默认约束 | 未指定字段时，采用默认值                   | default     |
| 检查约束 | 保证字段满足某一条件                       | check       |
| 外键约束 | 让两张表建立联系，保证数据的一致性和完整性 | foreign key |

自动增长	auto_increment

```sql
create table `tb_user`(
	id int primary key auto_increment comment "id唯一标识",
  name varchar(20) NOT NULL unique comment "姓名",
  age int check(age > 0 && age <= 120) comment "年龄",
  `status` char(1) default "1" comment "状态",
  gender char(1) comment "性别"
) comment "用户表";

# 添加外键
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id);

# 删除外键
alter table emp drop foreign key fk_emp_dept_id;
```



# 外键约束

- 删除/更新行为

| 行为      | 说明                                                           |
| --------- | -------------------------------------------------------------- |
| NO ACTION | 检查是否有对应的外键，如果有就不允许删除和修改                 |
| RESTRICT  | 与NO ACTION行为一致                                            |
| CASCADE   | 检查是否有对应的外键，如果有就同时删除子表中相关外键的记录     |
| SET NULL  | 检查是否有对应的外键，如果有就将相关子表的外键字段值设置为NULL |

```sql
# 添加外键 cascade约束
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id) on update cascade on delete cascade;

# 添加外键 set null 约束
alter table emp add constraint fk_em_dept_id foreign key (dept_id) references dept(id) on update set null on delete set null;
```



# join left join,right join, full join
join等价于inner join内连接抄，是返回两个表中都有的符合条件的行。
left join左连接，是返回左袭表知中所有的行及右表中符合条件的行。
right join右连接，是返回右表中所有的行及左表中符合条件的行。
full join全连接，是返回左表中所有的行及右表中所有的行，并按条件连接.

```mysql
select m.dept_no,y.emp_no,s.salary from employees y join salaries s on y.emp_no=s.emp_no join dept_emp d on y.emp_no=d.emp_no join dept_manager m on d.dept_no=m.dept_no and d.emp_no<>m.emp_no;
```

## where和having区别

- where和having都是为了完成数据的过滤，它们后面都是添加条件；
- where是在 group by之前完成过滤；
- having是在group by之后完成过滤；
- where 后面不可以写聚合函数

# MySQL中语句的执行顺序

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
- select : 对当前临时表进行 
- order by : 对select生成的临时表，进行重新排序，生成新的临时表
- limit : 对最终生成的临时表的数据行，进行截取

SQL语句执行顺序

\```sql

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

\```

# 事务

事务是一组操作的集合，不可分割的工作单位，事务会把所有的工作作为一个整体一起向系统提交和撤销操作请求，这些操作要么同时失败，同时成功。

```msql
# 创建一张表
create table `account`(
	id int primary key auto_increment comment "主键ID",
	name varchar(10) comment "姓名",
	money int comment "余额"
) comment "账户表";

insert into account(name,money) values("张三",2000),("李四", 2000);
select * from `account`;

# 查看事务
select @@autocommit;

# 设置事务为手动提交 （0:手动；1:自动）
set @@autocommit=0;

select * from `account` where name="张三";

# 开启事务
start transaction;

update `account` set money=money-1000 where name="张三"; 
异常
update `account` set money=money+1000 where name="李四";

# 提交事务
commit;

# 回滚事务
rollback;


# 查看事务的隔离级别
select @@transaction_isolation;



```



# 分布式事务

1.使用场景

- 微服务架构（跨jv m进程产生分布式事务）
- 跨数据库实例，单个系统访问多个数据库实例
- 多个服务访问同一个数据库实例



# 存储引擎

存储引擎就是存储数据、建立索引、更新/查询数据等技术的实现方式 。存储引擎是基于表的，而不是 基于库的，所以存储引擎也可被称为表类型。我们可以在创建表的时候，来指定选择的存储引擎，如果 没有指定将自动选择默认的存储引擎。

```mysql
# 查询当前数据库支持的存储引擎
show engines;

# 创建表 my_myisam , 并指定MyISAM存储引擎
CREATE TABLE my_myisam(
	`id` INT,
	`name` VARCHAR(10)
)ENGINE = MYISAM;

CREATE TABLE my_memory(
	`id` INT,
	`name` VARCHAR(10)
)ENGINE = MEMORY;

```



## InnoDB

1.介绍

InnoDB是一种兼顾高可靠性和高性能的通用存储引擎，在 MySQL 5.5 之后，InnoDB是默认的 MySQL 存储引擎。

2.特点

- DML操作**遵循ACID**模型，支持**事务**；(原子性（Atomicity），一致性(Consistency)，隔离性(Isolation)， 持续性(Durability))
- **行级锁**，提高并发访问性能；
- 支持**外键FOREIGN KEY约束**，保证数据的完整性和正确性；

2.文件(存储的表结构，表数据，索引)

xxx.ibd：xxx代表的是表名，innoDB引擎的每张表都会对应这样一个表空间文件，存储该表的表结 构（frm-早期的 、sdi-新版的）、数据和索引。





# 索引

## 数据结构

二叉树

红黑树

b tree

b+tree

Hash

# 索引数据结构

b+tree

Hash



## 索引分类

主键索引:Key_name: PRIMARY

常规索引: Key_name: idx_user_name

唯一索引

全文索引



聚集索引

二级索引



# InnoDB主键索引的B+tree高度为多高呢?

n * 8 + (n + 1) * 6 = 16 * 1024

InnoDB 的指针占用6个字节;

InnoDB 的主键 bigint 占用8个字节；

n: 节点存储的key的数量；

n+1:每个节点下有n+1个指针；

一页是16k; 16*1024字节；

算出一个页中有多少个指针（1171）；

如果是1171个指针，就有1171个叶子结点，每个节点大小16k

1171*16=18736k

2千万条记录以上才需要分库分表；

# 索引语句

```sql
create table tb_user(
	id int primary key auto_increment comment '主键',
	name varchar(50) not null comment '用户名',
	phone varchar(11) not null comment '手机号',
	email varchar(100) comment '邮箱',
	profession varchar(11) comment '专业',
	age tinyint unsigned comment '年龄',
	gender char(1) comment '性别 , 1: 男, 2: 女',
	status char(1) comment '状态',
	createtime datetime comment '创建时间'
) comment '系统用户表';

INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('吕布', '17799990000', 'lvbu666@163.com', '软件工程', 23, '1','6', '2001-02-02 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('曹操', '17799990001', 'caocao666@qq.com', '通讯工程', 33,'1', '0', '2001-03-05 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('赵云', '17799990002', '17799990@139.com', '英语', 34, '1','2', '2002-03-02 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('孙悟空', '17799990003', '17799990@sina.com', '工程造价', 54,'1', '0', '2001-07-02 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('花木兰', '17799990004', '19980729@sina.com', '软件工程', 23,'2', '1', '2001-04-22 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('大乔', '17799990005', 'daqiao666@sina.com', '舞蹈', 22, '2','0', '2001-02-07 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status, createtime) VALUES ('露娜', '17799990006', 'luna_love@sina.com', '应用数学', 24,'2', '0', '2001-02-08 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('程咬金', '17799990007', 'chengyaojin@163.com', '化工', 38,'1', '5', '2001-05-23 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('项羽', '17799990008', 'xiaoyu666@qq.com', '金属材料', 43,'1', '0', '2001-09-18 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('白起', '17799990009', 'baiqi666@sina.com', '机械工程及其自动化', 27, '1', '2', '2001-08-16 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('韩信', '17799990010', 'hanxin520@163.com', '无机非金属材料工程', 27, '1', '0', '2001-06-12 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('荆轲', '17799990011', 'jingke123@163.com', '会计', 29, '1','0', '2001-05-11 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('兰陵王', '17799990012', 'lanlinwang666@126.com', '工程造价',44, '1', '1', '2001-04-09 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('狂铁', '17799990013', 'kuangtie@sina.com', '应用数学', 43,'1', '2', '2001-04-10 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('貂蝉', '17799990014', '84958948374@qq.com', '软件工程', 40,'2', '3', '2001-02-12 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('妲己', '17799990015', '2783238293@qq.com', '软件工程', 31,'2', '0', '2001-01-30 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('芈月', '17799990016', 'xiaomin2001@sina.com', '工业经济', 35,'2', '0', '2000-05-03 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('嬴政', '17799990017', '8839434342@qq.com', '化工', 38, '1','1', '2001-08-08 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('狄仁杰', '17799990018', 'jujiamlm8166@163.com', '国际贸易',30, '1', '0', '2007-03-12 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('安琪拉', '17799990019', 'jdodm1h@126.com', '城市规划', 51,'2', '0', '2001-08-15 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('典韦', '17799990020', 'ycaunanjian@163.com', '城市规划', 52,'1', '2', '2000-04-12 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('廉颇', '17799990021', 'lianpo321@126.com', '土木工程', 19,'1', '3', '2002-07-18 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('后羿', '17799990022', 'altycj2000@139.com', '城市园林', 20,'1', '0', '2002-03-10 00:00:00');
INSERT INTO tb_user (name, phone, email, profession, age, gender, status,createtime) VALUES ('姜子牙', '17799990023', '37483844@qq.com', '工程造价', 29,'1', '4', '2003-05-26 00:00:00');

```



SHOW INDEX FROM table_name ;

CREATE [ UNIQUE | FULLTEXT ] INDEX index_name ON table_name (index_col_name,... ) ;



DROP INDEX index_name ON table_name ;



```mysql
mysql> show index from tb_user\G;


```



# SQL性能分析

- 执行频次

- 慢查询日志

- profile

- explain



### SQL 执行频率

 ```mysql
 -- session 是查看当前会话 ;
 -- global 是查询全局数据 ;
 SHOW GLOBAL STATUS LIKE 'Com_______';
 ```



# 索引使用原则

- 联合索引

- 索引失效
- SQL提示
- 覆盖索引
- 前缀索引
- 单列 / 联合索引

我们可以查看到当前数据库到底是以查询为主，还是以增删改为主，从而为数据库优化提供参考依据。 如果是以增删改为主，我们可以考虑不对其进行索引的优化。 如果是以查询为主，那么就要考虑对数据库的索引进行优化了。 索引使用

- ### 范围查询

- ### 最左前缀法则

- ### 索引失效

  - 索引列运算

  - 字符串不加引号

  - 仅仅是尾部模糊匹配，索引不会失效。如果是头部模糊匹配，索引失效
  - or连接的条件，左右两侧字段都有索引时，索引才会生效
  - 如果MySQL评估使用索引比全表更慢，则不使用索引
  - - 因为MySQL在查询时，会评估使用索引的效率与走全表扫描的效率，如果走全表扫描更快，则放弃索引，走全表扫描。 因为索引是用来索引少量数据的，如果通过索引查询返回大批量的数据，则还不如走全表扫描来的快，此时索引就会失效。

- sql提示(多个索引可用时，用户可以指定使用哪个索引，不指定mysql会自动指定)

  - explain select * from tb_user use index(idx_user_pro) where profession = '软件工程';
  - use index    ： 建议索引
  - ignore index  ： 忽略指定的索引
  - force index  ：强制使用索引
  - 在业务场景中，如果存在多个查询条件，考虑针对于查询字段建立索引时，建议建立联合索引，而非单列索引。





# 存储过程

```sql
# 创建存储过程
create procedure p3()
begin
	declare score int default 1;
	declare result varchar(10);
	
	if score >= 85 then
		set result := '优秀';
	elseif score >= 60 then
		set result := '及格';
	else
		set result := '差';
	end if;
	select result;
end;

call p3;

create procedure p4(in score int, out result varchar(10))
begin
	if score >= 85 then
		set result := '优秀';
	elseif score >= 60 then
		set result := '及格';
	else
		set result := '差';
	end if;
end;

call p4(40,@result);
s
```



# 触发器





```msq
# 日志表 
create table user_log(
	id INT(11) NOT NULL auto_increment,
	operation varchar(20) not null COMMENT "操作类型：insert、update、delete",
	operation_time datetime not null comment "操作时间",
	operate_id int(11) not null comment "操作ID",
	operate_params varchar(500) comment "操作参数",
	PRIMARY KEY(id)
) comment "用户日志表" default CHARSET=utf8;


# 创建insert触发器
create TRIGGER `account_user_log`
	AFTER INSERT on `account` for EACH ROW
BEGIN
	INSERT INTO user_log(id,operation,operation_time,operate_id,operate_params) VALUES
	(null, "insert", NOW(), new.id, CONCAT("插入的记录是", "id=", new.id, "，name=", new.name,",money=",new.money));
END;

# 查看触发器
show triggers;

# 删除触发器
drop TRIGGER account_user_log;

# 触发触发器
insert into account(name,money) values("赵六",2000);

# 创建update触发器
create TRIGGER `account_update_log`
	AFTER UPDATE ON `account` FOR EACH ROW
BEGIN
	INSERT INTO user_log(id,operation,operation_time,operate_id,operate_params) VALUES
	(null, "update", NOW(), old.id, CONCAT("更新之前的记录是", "id=", old.id, "，name=", old.name,",money=",old.money,
	"更新之后的记录是", "id=", new.id, "，name=", new.name,",money=",new.money));
END;

# 触发更新
UPDATE account set name="张飞" where id=3;

# 触发更新操作
UPDATE account set money=money+200 where id < 3;

# 删除触发器
create TRIGGER `account_delete_log`
	AFTER DELETE ON `account` FOR EACH ROW
BEGIN
	INSERT INTO user_log(id,operation,operation_time,operate_id,operate_params) VALUES
	(null, "delete", NOW(), old.id, CONCAT("删除的记录是", "id=", old.id, "，name=", old.name,",money=",old.money));
END;

# 删除操作
DELETE from account where id=4;

# 查看表
select * from `user_log`;


```



# 锁

锁是计算机协调多个进程或线程并发访问某一资源的机制，在数据库中，橱窗痛的计算资源的((cpu,ram,i/o))的争用外，数据也是一种供许多用户共享的资源。

如何保证数据并发访问的一致性，有效性，是所有数据库必须解决的问题，锁冲突也是影响数据库并发访问性能的一个重要的因素。

全局锁：数据库中所有表；用处：

表级锁：每次操作锁定整张表；用处：

行级锁：每次操作锁定对应的行数据；用处：



# MySQL日志



### 查看所有的日志列表

```sql
show master logs;
```

### 查看master状态

即最后（最新）一个binlog日志的编号名称，及其最后一个操作事件pos结束点(Position)值

```sql
show master status;
```

### 日志查看

```sql
mysql>   show binlog events in 'binlog.000002'\G;
```



### 日志删除：

对于比较繁忙的业务系统，每天生成的binlog数据巨大，如果长时间不清理，将会占用大量磁盘空间。清理日志的方式有以下三种：

- reset master；  重置所有的日志，删除全部的binlog日志，删除后，日志编号从binlog.000001重新开始
- flush logs;    flush 刷新log日志，自此刻开始产生一个新编号的binlog日志文件

②purge master logs to 'binlig.******'  删除******编号之前的所有binlog日志

③purge master logs before 'yyyy-mm-dd hh24:mi:ss' 删除该时间之前产生的所有日志



## 1.二进制日志

- binlog日志与数据库文件在同目录中。

- 二进制日志（binlog）记录了所有的DDL语句和DML语句，但不包含查询语句。

- 作用：①灾难时的数据恢复；②MySQL的主从复制，MySQL8版本中默认开启

```sql
show variables like '%log_bin%';
```



日志格式：

二进制日志有三种日志格式，statement，row，mixed。

statement是基于SQL语句的日志记录，对数据进行修改的SQL都会记录在日志文件中

row是基于行的日志记录，记录的是每一行的数据变更，row是默认的日志格式

mixed是以上两种的混合，默认采用statement，特殊情况会自动切换row

```sql
show variables like '%binlog_format%';
```

# 查询日志

- 查询日志默认不开启

  在mysql.cn开启日志查询

```cnf
[mysqld]
……
general_log=1 # 开启

```

```sql
mysql> show variables like "%general%";
+------------------+---------------------------------+
| Variable_name    | Value                           |
+------------------+---------------------------------+
| general_log      | ON                              |
| general_log_file | /var/lib/mysql/4bcc6ae876d6.log |
+------------------+---------------------------------+
2 rows in set (0.01 sec)
```





# 主从复制

概述：主从复制是指将主数据库的DDL和DML操作通过二进制日志传到从库服务器中， 然后在从库上对这些日志重新执行，从而使得从库与主库数据保持一致。

支持链状复制：从库也可以作为其他从服务器的主库。

master/slave

MySQL复制的优点：

-  分散负载和读写分离。所有写入和更新在源服务器上。读取在一个或多个副本上。提高写入性能，同时提高读取速度。
- 数据安全：副本全局锁定来执行备份服务，而不损坏源数据。
- 分析：分析信息在副本上进行，而不会影响主服务器的性能。
- 远程数据分发——您可以使用复制来创建数据的本地副本以供远程站点使用，而无需永久访问源。

## 主从复制的原理

master主库在事务提交时，会将数据变更记录在二进制日志文件binlog中，

从库读取主库的二进制日志文件，写入到从库的中继日志relay log;

slave重做中继日志中的事件，将改变反映到自己的数据库中。



实践：

## 主库的.c n f配置

在 mysql/conf.d/mysql.cnf配置如下：

注意：

mysql服务id，保证整个集群环境中唯一，取值范围：1-2^32-1，默认：1

server-id=1

是否只读，1:只读；0:读写

read-only=0

```cnf
[client]
default-character-set=utf8mb4


[mysql]
default-character-set=utf8mb4

[mysqld]
init_connect='SET NAMES utf8mb4'
character-set-server=utf8mb4

# mysql服务id，保证整个集群环境中唯一，取值范围：1-2^32-1，默认：1
server-id=1
# 是否只读，1:只读；0:读写
read-only=0

# 忽略的数据，不需要同步的数据
#binlog-ignore-db=mysql
# 指定同步的数据库
#binlog-do-db=db01

```



### 主库的配置操作：

```sql
# 创建用户并设置密码
CREATE USER 'itcast'@'%' IDENTIFIED WITH mysql_native_password BY 'Root@123456';

# 为用户分配主从复制权限
GRANT REPLICATION SLAVE ON *.* TO 'itcast'@'%';

# 通过指令查看二进制日志坐标
show master status;

file: 从那个日志推送日志
postion: 哪个位置开始；
binlog_ignore_db: 指定不需要推送的数据库


```



## 从库的配置.cnf：

```cnf
# mysql服务id，保证整个集群环境中唯一，取值范围：1-2^32-1，默认：1
server-id=2
# 是否只读，1:只读；0:读写
read-only=1
```

### 从服务器配置:

```sql
# 副本与主服务器的日志读取
change replication source to source_host='172.16.147.194', source_user='itcast', source_password='Root@123456', source_log_file='binlog.000019', source_log_pos=664;

# 开启副本
start replica;

# 查看副本状态 \G格式
show replica status\G;

# 关闭
stop replica;




如果报错，uuid相等，是因为虚拟机在拷贝创建，需要手动删除相关的mysql数据卷，因为auto.cnf中时存放在/var/lib/mysql中的；
# 查看uuid
show variables like '%uuid%';
```
