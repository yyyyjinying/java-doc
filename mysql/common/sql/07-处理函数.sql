-- 查询员工姓名，将员工姓名全部转换成小写
select lower(ename) as ename from emp;

-- 查询员工姓名，将员工姓名全部转换为大写
select upper(ename) as ename from emp;

-- 查询并显示所员工姓名的第二个字母
select substr(ename,2,1) from emp;

-- 查询员工姓名中第二个字母为A的所有员工
select ename from emp where substr(ename,2,1)='A';
select ename from emp where ename like '_A%';

-- 取得员工姓名长度
select ename,length(ename) as nameLength from emp;

-- 查询员工姓名及补助，如果补助为Null设置为0
select ename, ifnull(comm,0) as comm from emp;

-- 查询员工总薪水
select ename, (sal+comm) as totalSal from emp;
select ename, (sal+ ifnull(comm,0)) as totalSal from emp;

-- 没有补助的员工，每月补助100，求员工的年薪
select ename, (sal + ifnull(comm,100))*12 as yearSal from emp;

-- 匹配工作岗位，当为MANAGER时，薪水上调10%，当为SALESMAN时，薪水上调50%，其它岗位薪水不变。

SELECT 
    ename,
    sal,
    job,
    (CASE job
        WHEN 'manager' THEN sal * 1.1
        WHEN 'salesman' THEN sal * 1.5
        ELSE sal
    END) AS newSal
FROM
    emp;
    
-- 取得工作岗位为manager的所有员工
select ename,job from emp where job=trim('   manager   ');

-- 查看员工薪水保留1位小数
select round(sal,1) as sal from emp;

select round(10.25,1);

-- rand()
select rand();
-- 生成多个随机数
select rand(), sal from emp;
-- 生成0~100之间的随机数
select round(rand()*100), sal from emp;

-- 查询出1981-12-03入职的员工
select empno,ename,hiredate from emp where hiredate='1981-12-03';

-- 使用str_to_date()函数查询02-20-1981年入职的员工
select empno,ename,hiredate from emp where hiredate=str_to_date('02-20-1981','%m-%d-%Y');

-- 查询员工的入职日期，以'10-12-1980'的格式显示到窗口中
select date_format(hiredate,'%m-%d-%Y') as hiredate from emp;