# if和distinct
select DISTINCT if(submit_time is not null, exam_id, null) AS MM from `exam_record`;
# count和date_format
null不计算
加了多个参数后，distinct id, name的意思是在结果集中，只有当字段id和name都不相同时才算一条记录；
问题拆分：
根据提交时间submit_time不为空筛选活跃的的人。知识点：select...from...where...
筛选每个月的平均活跃天数和总活跃人数：
根据月份来选择时间。知识点：date_format() 通过这个函数匹配'%Y%m'年份和月份；
计算用户平均活跃天数：
根据不同的日期且不同的用户ID统计每个月用户的总活跃天数。知识点：distinct、count()、date_format()
统计每个月用的总人数。知识点：distinct、count()
总天数/总人数得到每个月的用户平均活跃天数；
计算每月总活跃人数，直接统计每月不同的用户id数。知识点：count()、distinct
按照月份分组group by date_format(submit_time, '%Y%m') 知识点：group by ...
保留两位小数。 知识点：round(x,2)
```sql
select date_format(submit_time, '%Y%m') as month,
--  总的每月活跃用户数
COUNT(DISTINCT uid, date_format(submit_time, '%Y%m%d')) as sumactive,
ROUND(COUNT(DISTINCT uid, date_format(submit_time, '%Y%m%d'))/COUNT(DISTINCT uid), 2) as avg_active_days,
count(distinct uid) as mau
FROM exam_record
where submit_time is not null
and DATE_FORMAT(submit_time,"%Y")=2021
group by date_format(submit_time, '%Y%m')
```
# group
`在group中的字段可以显示，不在的报错，如果想显示使用聚合函数`
最新的Mysql版本，如果您运行结果出现错误：ONLY_FULL_GROUP_BY，意思是：对于GROUP BY聚合操作，如果在SELECT中的列，没有在GROUP BY中出现，那么这个SQL是不合法的，因为列不在GROUP BY从句中，也就是说查出来的列必须在group by后面出现否则就会报错，或者这个字段出现在聚合函数里面。
```sql
select 
-- DATE_FORMAT(submit_time,"%Y%m") as month,
coalesce(year_mon,'2021汇总') as submit_month,
-- t.year_mon, -- year在group年月字段中
-- t.days_month -- 天数不在group by中报错
count(question_id) as month_q_cnt,
round(count(question_id)/max(t.days_month),3) as avg_day_q_cnt

from (select question_id,
dayofmonth(last_day(submit_time)) as days_month,
date_format(submit_time,'%Y%m') as year_mon
from practice_record
where year(submit_time)=2021) as t
GROUP BY t.year_mon
with rollup
```
## coalesce
实例一：select coalesce(null,"carrot","apple")
返回结果：carrot
实例二：select coalesce(1,"carrot","apple")
返回结果：1
## WITH ROLLUP
此函数是`对聚合函数进行求和`，注意 with rollup是对 group by 后的第一个字段，进行分组求和。

# using
连接查询时如果是同名字段作为连接条件，using可以代替on出现（比on更好）
using 是针对同名字段（using(id)===on A.id=B.id）
```sql
select 
r.uid,
e.tag,
r.start_time,
if(r.submit_time is null, null, 1) as complete,
if(r.submit_time is null, 1, null) as incomplete,
concat_ws(':', date(start_time), tag) as aa -- 可以将多个字段合并成一个字段
from examination_info e
join exam_record r
on e.exam_id=r.exam_id
where year(r.start_time)=2021
```
# CONCAT和CONCAT_WS
SELECT CONCAT('My', 'S', 'QL');
-- 结果是MySQL
SELECT CONCAT_WS("_", "data", "frog", "study");
-- 结果是data_frog_study
concat_ws(':', date(start_time), tag) as aa -- 可以将多个字段合并成一个字段
# GROUP_CONCAT separator
GROUP_CONCAT separator可将查询结果用字符串连接变为一行,需配合使用GROUP BY
```sql
group_concat(distinct concat_ws(':', date(start_time), tag) SEPARATOR ';') as detail

select 
uid,
count(complete) as complete_cnt,
count(incomplete) as incomplete_cnt,
group_concat(distinct concat_ws(':', date(start_time), tag) SEPARATOR ';') as detail

from (select 
r.uid,
e.tag,
r.start_time,
if(r.submit_time is null, null, 1) as complete,
if(r.submit_time is null, 1, null) as incomplete
from examination_info e
join exam_record r
on e.exam_id=r.exam_id
where year(r.start_time)=2021) as exam_complete_rec
GROUP BY uid
having complete_cnt >= 1 and incomplete_cnt BETWEEN 2 and 4
order by incomplete_cnt DESC
```