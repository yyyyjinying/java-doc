- redis-cli
# 常用命令
## key
- keys * // 查找所有符合给定模式pattern（正则表达式）的 key 
- keys *i* 
- keys i??
## exists 
- exists k1 // 判断k1是否存在
1 如果key存在
0 如果key不存在

## type
- type k1 // 查看数据的数据类型
  
## del
- del k1 // 删除key

## expire 
- set my "hello"
- expire my 10 // 设置key的过期时间
- ttl my // 查看key剩余的过期时间  如果key不存在或者已过期，返回 -2; 如果key存在并且没有设置过期时间（永久有效），返回 -1 ;

1 如果成功设置过期时间。
0 如果key不存在或者不能设置过期时间。

## select 
- select 0 // 默认库 select 切换库

## dbsize
- dbsize // 查看库中有多少个key

## flushdb
- flushdb // 清空当前库
## flushall
- flushall // 删除所有数据库里面的所有数据

## set
- set <key> <value>
将键key设定为指定的“字符串”值。
如果 key 已经保存了一个值，那么这个操作会直接覆盖原来的值，并且忽略原始类型。
当set命令执行成功之后，之前设置的过期时间都将失效

## get
- get <key>
返回key的value。如果key不存在，返回特殊值nil。
如果key的value不是string，就返回错误，因为GET只处理string类型的values。

## append
- append k1 aa // 在尾部追加
如果 key 已经存在，并且值为字符串，那么这个命令会把 value 追加到原来值（value）的结尾。 如果 key 不存在，
那么它将首先创建一个空字符串的key，再执行追加操作，这种情况 APPEND 将类似于 SET 操作。

## strlen
- strlen k1 // 返回key的string类型value的长度。如果key对应的非string类型，就返回错误。

## setnx
- setnx k1 bb // 如果key不存在设置值，这种情况下等同SET命令

## incr
- incr a // 自动加一
## decr 
- decr b // 自动减一

## incrby
自定自增步长
## decrby 
指定自减步长

原子操作：不会被线程调度机制打断的操作；

redis: 但线程+多路IO复用
java中的i++不是原子操作

## mset
- mset k1 a k2 b k3 c // 

## mget 
- mget k1 k2 k3

## msetnx

## getrange
- set k1 english
- getrange k1 0 3 // 

## setrange
- setrange k1 0 333 // 这个命令的作用是覆盖key对应的string的一部分，从指定的offset处开始，覆盖value的长度

## setex
setex age 20 value20 // 设置key的同时设置过期时间

## getset 
- getset name zhao // 设置key同时返回值

字符串的最大长度512M

# redis list底层是一个双向链表
## lpush/rpush
- lpush <key> v1 v2 v3
- rpush <key> v11 v22 v33

## lpop/rpop 值在健在，值完键完
- lpop <key>
- rpop <key>

## rpoplpush <key1><key2>
key1列表右边吐出一个值，从key2列表的左边插入值；
## lrange 
- lrange <key> <start><end> // 按索引下标获得元素从左到右

## lindex
- lindex <key> index // 按照索引下标获取元素（从左到右）

## llen
- llen key // 获取列表的长度 

## lrem 
- lrem k2 3 v111. // 删除key中3个值 v111

## linsert
- linsert k2 after v22 v111.  // 在key中的v22值后面插入值
- linsert k2 before v22 v111。 // 在key中的v22值的前面插入值

## lset
- lset k2 0 v2  // 在指定的index处替换值

## sadd
- sadd k3 v1 v2 v3 v2
添加一个或多个指定的member元素到集合的 key中.指定的一个或者多个元素member 如果已经在集合key中存在则忽略.

## smembers 
- smembers k3
- 返回key集合所有的元素
  
## sismember
- sismember k3 v1
返回成员 member 是否是存储的集合 key的成员

## scard
- scard k3
集合元素的数量

## smove 
- smove k4 k5 v1
将member从source集合移动到destination集合中

## spop
- spop key

## srem

## sdiff
- sdiff k1 k2
k1的差集

## sunion 
- sunion k1 k2

## sinter
- sinter k1 k2

## hset
- hset k1 age 12 name zhao
设置 key 指定的哈希集中指定字段的值
## hmset 
- hmset k1 sex man
修改key值
## hsetnx 
- hsetnx grade 123
存在值设置不成功返回0，设置不存在的key值返回1；

## hincrby 
- hincrby k1 age 1
- hincrby k1 age -2
增加 key 指定的哈希集中指定字段的数值;
## HINCRBYFLOAT
- HINCRBYFLOAT mykey field 0.1
只对浮点数生效

## hstrlen
- hstrlen k1 sex 
返回指定key值的字符串长度


## hget
- hget key field

## hgetall
- hgetall key
返回 key 指定的哈希集中所有的字段和值

## hkeys 
- hkeys k1  // 哈希集中所有的字段名

## hvals
- hvals k1 // 哈希集中所有字段的值

## hlen 
- hlen k1 // 哈希集中字段的数量

redis的五大数据结构讲解

