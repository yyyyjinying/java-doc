-- 取得薪水的合计
select sum(sal) as sumSal from emp;

-- 取得总共薪水（工资+补助）合计
select sum(sal + ifnull(comm,0)) as totalSal from emp;

select sum(comm) as totalComm from emp;

-- 取得平均薪水
select avg(sal) as avgSal from emp;

-- 取得最高薪水
select max(sal) as maxSal from emp;

-- 取得最晚入职的日期
select max(hiredate) as lastHiredate from emp;

-- 取得最低薪水
select min(sal) as minSal from emp;

-- 取得最早入职日期
select min(hiredate) as firstHiredate from emp;

-- 取得所有员工数
select count(*) from emp;

-- 取得补助不为空的员工数
select count(comm) from emp;

-- 统计没有补助的员工数
select count(*) from emp where comm is null;

-- sum、avg、max、min、count这些函数可以一起使用：
select  count(*),sum(sal),avg(sal),max(sal),min(sal) from emp;


