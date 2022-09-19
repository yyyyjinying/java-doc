



# Sql的分类

| 分类 | 全称                       | 说明                                                       | 查询语句 |
| ---- | -------------------------- | ---------------------------------------------------------- | -------- |
| DDL  | Data Definition language   | 数据定义语言，用来定义数据库对象（数据库表、字段、表）     |          |
| DML  | Data Manipulation language | 数据操作语言，用来对数据库表中的数据进行增删改             |          |
| DQL  | Data Query Language        | 数据查询语言，用来查询数据库表中的记录                     |          |
| DCL  | Data Control Language      | 数据控制语言，用来创建用户数据库用户，控制数据库的访问权限 |          |

## DDL

### 数据库相关的操作

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

| 行为      | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| NO ACTION | 检查是否有对应的外键，如果有就不允许删除和修改               |
| RESTRICT  | 与NO ACTION行为一致                                          |
| CASCADE   | 检查是否有对应的外键，如果有就同时删除子表中相关外键的记录   |
| SET NULL  | 检查是否有对应的外键，如果有就将相关子表的外键字段值设置为NULL |

```sql
# 添加外键 cascade约束
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id) on update cascade on delete cascade;

# 添加外键 set null 约束
alter table emp add constraint fk_em_dept_id foreign key (dept_id) references dept(id) on update set null on delete set null;
```



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
select @result;
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
