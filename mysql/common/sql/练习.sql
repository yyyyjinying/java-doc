-- 取得每个部门最高薪水的人员名称
select e.ename,t.maxSal  from emp e
join
(select deptno, max(sal) as maxSal from emp group by deptno) t
on
e.deptno = t.deptno
where e.sal=t.maxSal;

-- 哪些人的薪水在部门平均薪水之上
select e.ename,e.sal,t.deptno,t.avgSal from emp e
join
(select  deptno, avg(sal) as avgSal from emp group by deptno) t
on
e.deptno=t.deptno
where e.sal>t.avgSal;

-- 取得部门中（所有人的）平均薪水等级
select t.deptno,t.avgSal,s.GRADE from  salgrade s
join
(select  deptno, avg(sal) as avgSal from emp group by deptno) t
on 
t.avgSal between s.LOSAL and s.HISAL;

-- 不用max函数，取得最高薪水
select ename, sal from emp order by sal desc limit 0,1;

-- 取得平均薪水最高的部门的部门编号
-- 方法一：
select  deptno, avg(sal) as avgSal from emp group by deptno
having avgSal=
(select max(t.avgSal) from 
(select  deptno, avg(sal) as avgSal from emp group by deptno) t);

-- 方法二：
select deptno,avg(sal) as avgSal from emp group by deptno order by avgSal desc limit 0,1;

-- 取得平均薪水最高的部门的部门名称
select d.dname,d.deptno  from dept d
join
(select deptno,avg(sal) as avgSal from emp group by deptno order by avgSal desc limit 0,1) t
on
d.deptno=t.deptno;

-- 求平均薪水的等级最低的部门的部门名称
select d.dname from dept d
join
(
	select t.deptno,min(t.GRADE) as minGrade from 
		(
		select s.grade,t.deptno  from salgrade s
		join
		(select  deptno, avg(sal) as avgSal from emp group by deptno) t
		on
		t.avgSal between s.losal and s.hisal
		) t
) t1
on d.deptno=t1.deptno;

-- 取得比普通员工（员工编号没有在mgr上出现的）的最高薪水还要高的经理人姓名
SELECT 
    e.ename
FROM
    emp e
        JOIN
    (SELECT DISTINCT
        (mgr) AS mgr
    FROM
        emp
    WHERE
        mgr IS NOT NULL) t ON e.empno = t.mgr
WHERE
    e.sal > (SELECT 
            MAX(sal) AS maxSal
        FROM
            emp
        WHERE
            empno NOT IN (SELECT DISTINCT
                    (mgr)
                FROM
                    emp
                WHERE
                    mgr IS NOT NULL));


-- 取得每个薪水等级有多少员工
select t.grade, count(t.empno) as totalEmp  from 
(select e.empno,s.GRADE from emp e
join 
salgrade s
on
e.sal between s.LOSAL and s.HISAL) t
group by t.grade;

-- 列出受雇日期早于其直接上级的所有员工编号、姓名
select a.empno, a.ENAME from emp a
join
emp b
on a.mgr=b.EMPNO
where
a.HIREDATE < b.HIREDATE;

-- 列出至少有5个员工的部门名称

select d.dname from dept d
join
(select e.DEPTNO, count(e.EMPNO) from emp e group by e.DEPTNO having count(e.EMPNO) >= 5) t
on
d.deptno=t.deptno;

-- 列出最低薪水大于1500的工作及从事此工作的雇员人数
select job, min(sal) as minSal, count(*) as totalEmp from emp group by job having min(sal) > 1500;

-- 列出在部门“SALES”工作的员工的姓名
select e.ename from emp e
where e.deptno=(
select deptno from dept where DNAME='sales');

-- 求部门名称中带“S”字符的部门员工的工资合计、部门人数
select d.dname, count(e.empno) as totalEmp, sum(e.sal) as totalSal from emp e
right join 
dept d
on e.deptno=d.DEPTNO
where d.DNAME like '%s%'
group by d.dname;



-- 取得每个部门最高薪水的人员名称
-- 哪些人的薪水在部门平均薪水之上
-- 取得部门中（所有人的）平均薪水等级
-- 不用max函数，取得最高薪水
-- 取得平均薪水最高的部门的部门编号
-- 方法一：

-- 取得平均薪水最高的部门的部门名称
-- 求平均薪水的等级最低的部门的部门名称
-- 取得比普通员工（员工编号没有在mgr上出现的）的最高薪水还要高的经理人姓名
-- 取得每个薪水等级有多少员工
-- 列出受雇日期早于其直接上级的所有员工编号、姓名
-- 列出至少有5个员工的部门名称
-- 列出最低薪水大于1500的工作及从事此工作的雇员人数
-- 列出在部门“SALES”工作的员工的姓名
-- 求部门名称中带“S”字符的部门员工的工资合计、部门人数











