select ENAME from emp;

select empno,ename from emp;

-- 开发中不建议使用*
select * from emp;

-- 查询员工编号，姓名和年薪
-- 使用as 给字段取别名
select empno, ename, sal*12 as yearsal from emp;
select empno, ename, sal*12  yearsal from emp;
select empno, ename, sal*12 as '年薪' from emp;

-- 查询薪水是5000的员工
select empno,ename from emp where sal=5000;

-- 查询job是MANAGER的员工
select empno,ename from emp where job='manager';

-- 查询薪水不等于5000的员工
-- 建议使用<>
select empno,ename from emp where sal <> 5000;
select empno,ename from emp where sal != 5000;

-- 查询薪水为1600到3000的员工
select empno,ename from emp where sal>=1600 and sal<=3000;
select empno,ename from emp where sal between 1600 and 3000;

-- 查询津贴为空的员工
select empno,ename,comm from emp where comm is null;

-- 查询工作岗位为“MANAGER”并且薪水大于2500的员工
select empno,ename,job,sal from emp where job='manager' and sal>2500;

-- 查询出 job 为 SALESMAN 或者 job为MANAGER的员工：
select empno, ename ,job from emp where job='salesman' or job='manager';

-- 查询薪水大于1800，并且部门编号为20或30的员工
select empno,ename,sal,deptno from emp where sal>1800 and (deptno=20 or deptno=30);

-- 查询出Job是SALESMAN或者是MANAGER的员工
select empno, ename from emp where job in ('salesman','manager');

-- 查询出薪水不是1600和3000的员工
select empno, ename from emp where job not in (1600,3000);

-- 查询姓名以M开头的所有员工
select ename from emp where ename like 'm%';

-- 查询姓名以N结尾的所有员工
select ename from emp where ename like '%n';

-- 查询姓名中包含O的所有员工
select ename from emp where ename like '%o%';

-- 查询姓名中第二个字母是A的所有员工
select ename from emp where ename like '_A%';