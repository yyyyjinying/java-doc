create table emp(
    id int,
    name varchar(100),
    sex char(6),
    birthday date,
    salary float(10,2)
);

/*
	MySQL注释一
    点击小闪电会执行全部的或者是选中的sql语句
    快捷键ctrl+enter会执行当前sql语句
*/

-- MySQL注释方式二
insert into emp (id,name,sex,birthday,salary) values (1,'andy','male','1995-05-15',10000);

insert into emp values (2,'paul','male','1996-06-15',15000);
insert into emp values (3,'lucy','female','1998-07-11',8000);


-- 批量添加

insert into emp (id,name,sex,birthday,salary) values
(4,'james','male','1985-08-10',50000),
(5,'marry','female','1987-06-15',30000),
(6,'carter','male','1995-05-18',10000);


/*修改*/
-- 下面写法会将表中的数据全部修改，使用时一定要注意。
update emp set salary=3000;

-- 限定修改的数据，告诉mysql要修改name='james'的那条数据
update emp set salary=8000 where name='james';

-- 修改多个字段，使用,将字段隔开
update emp set sex='male',salary=10000 where id=5;

/*删除*/

delete from emp where name='lucy';

-- 将表中的数据全部删除
delete from emp;

truncate table emp;