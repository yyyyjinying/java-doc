-- 找出薪水比公司平均薪水高的员工，要求显示员工名和薪水
SELECT 
    ename, sal
FROM
    emp
WHERE
    sal > (SELECT 
            AVG(sal) AS avgSal
        FROM
            emp);
            
-- 找出每个部门的平均薪水，并且要求显示平均薪水的薪水等级
SELECT 
    s.GRADE, t.job, t.avgSal
FROM
    salgrade s
        JOIN
    (SELECT 
        job, AVG(sal) AS avgSal
    FROM
        emp
    GROUP BY job) t ON t.avgSal BETWEEN s.losal AND s.hisal;
    
-- 查询出job为MANAGER和SALESMAN的员工
select ename,job from emp where job='manager' or job='salesman';
select ename,job from emp where job in ('manager','salesman');
-- 使用union
select ename,job from emp where job='manager'
	union
select ename,job from emp where job='salesman';

-- 取前5个员工信息
select * from emp limit 0,5;

-- 找出工资排名在前5的员工
select * from emp order by sal desc limit 0,5;

-- 找出工资排名在[ 3-9 ]的员工
select * from emp order by sal desc limit 2,7;