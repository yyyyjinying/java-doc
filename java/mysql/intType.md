## 数值类型
- tinyint
- smallint
- mediumint
- int
- integer
- bigint
- float
- double
- decimal

## 日期和时间类型
- DATE 年月日
- TIME 时分秒
- YEAR 年
- DATETIME 年月日时分秒
- TIMESTAMP 时间戳
  

## 字符串类型
- CHAR 固定字符
- VARCHAR 可变字符
- TINYBLOB 255二进制
- TINYTEXT
- BLOB  二进制长文本数据
- TEXT 长文本
- MEDIUMTEXT 中等长文本
- LONGBLOB  二进制极大
- LONGTEXT  极大文本
  

# 锁
锁是在执行多线程时用于强行限定资源访问的同步机制，数据库锁根据锁的粒度可分为行级锁，表级锁和页级锁
行级锁
行级锁是mysql中粒度最细的一种锁机制，表示只对当前所操作的行进行加锁，行级锁发生冲突的概率很低，其粒度最小，但是加锁的代价最大。行级锁分为共享锁和排他锁。
特点：

开销大，加锁慢，会出现死锁；锁定粒度最小，发生锁冲突的概率最大，并发性也高；
实现原理：
InnoDB行锁是通过给索引项加锁来实现的，这一点mysql和oracle不同，后者是通过在数据库中对相应的数据行加锁来实现的，InnoDB这种行级锁决定，只有通过索引条件来检索数据，才能使用行级锁，否则，直接使用表级锁。特别注意:使用行级锁一定要使用索引