## 一、创建数据库
- show databases; <!-- 查看数据库 -->
- create database database_name; <!--创建数据库-->
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
        id int,
        name varchar(100),
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
  ### 修改数据表
  - alter table <旧表名> rename <新表名>; <!--修改表名-->
  - alter table <表名> modify <字段名> <数据类型>; <!--修改字段数据类型-->
  - alter table <表名> change <旧字段名> <新字段名> <新数据类型>; <!--修改字段名-->
  - alter table emp1 add age1 int(10) default 12 FIRST;
  -  - alter table emp1 add age2 int(10) default 12 AFTER username;
  - alter table <表名> drop <字段名>; <!--删除表字段-->
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


  
