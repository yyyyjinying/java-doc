-- 按照薪水由小到大排序
select ename,sal from emp order by sal;

-- 取得job为MANAGER的员工，按照薪水由小到大排序
select ename,sal,job from emp where job='manager' order by sal;

-- 手动指定按照薪水由小到大排序
select ename,sal from emp order by sal asc;

-- 手动指定按照薪水由大到小排序
select ename, sal from emp order by sal desc;

-- 按照 job 和薪水倒序排序
select ename, sal, job from emp order by job desc, sal desc;

-- 按照薪水升序排序，不建议使用，不明确
select * from emp order by 6;
