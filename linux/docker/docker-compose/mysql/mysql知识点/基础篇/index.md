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
# 删除表,并重新创建表 
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
```
