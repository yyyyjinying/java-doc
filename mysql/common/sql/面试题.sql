-- 找出没选过“黎明”老师的所有学生姓名
-- 第一步：找出黎明老师所授课的课程编号
select cno from c where cteacher='黎明';

-- 通过sc表查找cno=第一步中的结果的sno，这些sno就是选了黎明老师的学生编号
select sno from sc 
join
(select cno from c where cteacher='黎明') t
on
sc.cno=t.cno;

-- 将第二步中的sno去和s表中的sno做关联查询
select s.sname from s
join 
(
	select sno from sc 
join
(select cno from c where cteacher='黎明') t
on
sc.cno=t.cno
) t1
on
s.sno=t1.sno;



-- 列出2门以上（含2门）不及格学生姓名及平均成绩