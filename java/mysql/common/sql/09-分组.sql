-- 查询公司有哪些工作岗位
select distinct job from emp;

-- 查询公司工作岗位数量
select count(distinct job) from emp;

-- 去除部门编号deptno和工作岗位job重复的记录
select distinct deptno, job from emp;

-- 找出每个职位的最高薪水
select job,max(sal) as maxSal from emp group by job;

-- 计算每个工作岗位的最高薪水，并且按照由低到高进行排序
select job,max(sal) as maxSal from emp group by job order by maxSal;

-- 计算每个部门的平均薪水
select deptno,avg(sal) from emp group by deptno;

-- 计算出不同部门不同岗位的最高薪水
select deptno,job, max(sal) as maxSal from emp group by deptno,job;

-- 计算除了manager之外的每个工作岗位的最高薪水
select job,max(sal) as maxSal from emp where job<>'manager' group by job;

-- 找出每个工作岗位的平均薪水，要求显示平均薪水大于2000的
select job,avg(sal) from emp group by job having avg(sal)>2000;