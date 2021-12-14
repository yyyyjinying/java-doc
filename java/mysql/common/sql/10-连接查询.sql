-- 显示每个员工信息，并显示所属部门名称
-- 笛卡尔乘积select e.ename, d.dname from dept d, emp e;

-- sql92语法
select e.ename,d.dname from emp e,dept d where e.DEPTNO=d.DEPTNO;

-- sql99语法
select e.ename,d.dname from emp e join dept d on e.deptno=d.deptno;


-- 找出员工所对应的工资等级，显示员工姓名、工资、工资等级
select e.ENAME,e.sal,s.grade from emp e join salgrade s on e.sal between s.losal and s.HISAL;

-- 查询员工的名称和员工对应的领导名称
select a.ename as leader,b.ENAME from emp a join emp b on a.EMPNO=b.MGR;

-- 找出每一个员工对应的部门名称，要求部门名称全部显示
select e.ename,d.dname from emp e right join dept d on e.deptno=d.deptno;

select e.ename,d.dname from dept d left join emp e on e.deptno=d.deptno;

-- 找出每一个员工对应的领导名，要求显示所有员工
select a.ename as leader,b.ENAME from emp a right join emp b on a.EMPNO=b.MGR;

-- 找出每一个员工对应的部门名称，以及该员工对应的工资等级，要求显示员工姓名、部门名称、工资等级

SELECT 
    e.ename, e.sal, d.dname,s.GRADE
FROM
    emp e
        JOIN
    dept d ON e.DEPTNO = d.DEPTNO
        JOIN
    salgrade s ON e.sal BETWEEN s.LOSAL AND s.HISAL;
