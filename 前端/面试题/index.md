# == 与 equals的比较
== 对于基本类型来说是值比较，对于引用类型来说是比较的是引用；
而 equals 默认情况下是引用比较，只是很多类重新了 equals 方法，
比如 String、Integer 等把它变成了值比较，所以一般情况下 equals 比较的是值是否相等。

# 两个对象的 hashCode()相同，则 equals()也不一定为 true
hashCode()相等即两个键值对的哈希值相等，然而哈希值相等，并不一定能得出键值对相等。

# final 在 java 中有什么作用
- final 修饰的类叫最终类，该类不能被继承。
- final 修饰的方法不能被重写。
- final 修饰的变量叫常量，常量必须初始化，初始化之后值就不能被修改。
  
#  java 中的 Math.round(-1.5) 等于 -1

# String 属于基础的数据类型吗？
String 不属于基础类型，
基础类型有 8 种：
byte、boolean、char、short、int、float、long、double，而 String 属于对象。

# java 中操作字符串都有哪些类？它们之间有什么区别？
操作字符串的类有：String、StringBuffer、StringBuilder
String 和 StringBuffer、StringBuilder 的区别在于 String 声明的是不可变的对象，
每次操作都会生成新的 String 对象，然后将指针指向新的 String 对象，
而 StringBuffer、StringBuilder 可以在原有对象的基础上进行操作，所以在经常改变字符串内容的情况下最好不要使用 String。

StringBuffer 和 StringBuilder 最大的区别在于，StringBuffer
是线程安全的，而 StringBuilder 是非线程安全的，但 StringBuilder 的性能却高于 StringBuffer，
所以在单线程环境下推荐使用 StringBuilder，多线程环境下推荐使用 StringBuffer。

# String str="i"与 String str=new String("i")一样吗？
不一样，因为内存的分配方式不一样。String str="i"的方式，java 虚拟机会将其分配到常量池中；而 String str=new String("i") 则会被分到堆内存中。

# 字符串反转 reverse

# String 类的常用方法都有那些？
indexOf()：返回指定字符的索引。
charAt()：返回指定索引处的字符。
replace()：字符串替换。
trim()：去除字符串两端空白。
split()：分割字符串，返回一个分割后的字符串数组。
getBytes()：返回字符串的 byte 类型数组。
length()：返回字符串长度。
toLowerCase()：将字符串转成小写字母。
toUpperCase()：将字符串转成大写字符。
substring()：截取字符串。
equals()：字符串比较。

# 抽象类不一定要有抽象方法

# 普通类和抽象类有哪些区别？
普通类不能包含抽象方法，抽象类可以包含抽象方法。
抽象类不能直接实例化，普通类可以直接实例化。

# 抽象类能使用 final 修饰吗？
不能，定义抽象类就是让其他类继承的，如果定义为 final 该类就不能被继承，这样彼此就会产生矛盾，所以 final 不能修饰抽象类

# 接口和抽象类有什么区别？
实现：抽象类的子类使用 extends 来继承；接口必须使用 implements 来实现接口。
构造函数：抽象类可以有构造函数；接口不能有。
main 方法：抽象类可以有 main 方法，并且我们能运行它；接口不能有 main 方法。
实现数量：类可以实现很多个接口；但是只能继承一个抽象类。
访问修饰符：接口中的方法默认使用 public 修饰；抽象类中的方法可以是任意访问修饰符。

# 访问修饰符 public private protected

# java 中 IO 流分为几种
BIO：Block IO 同步阻塞式 IO，就是我们平常使用的传统 IO，它的特点是模式简单使用方便，并发处理能力低。
NIO：New IO 同步非阻塞 IO，是传统 IO 的升级，客户端和服务器端通过 Channel（通道）通讯，实现了多路复用。
AIO：Asynchronous IO 是 NIO 的升级，也叫 NIO2，实现了异步非堵塞 IO ，异步 IO 的操作基于事件和回调机制。

# Files的常用方法都有哪些？
Files.exists()：检测文件路径是否存在。
Files.createFile()：创建文件。
Files.createDirectory()：创建文件夹。
Files.delete()：删除一个文件或目录。
Files.copy()：复制文件。
Files.move()：移动文件。
Files.size()：查看文件个数。
Files.read()：读取文件。
Files.write()：写入文件。

#  Collection 和 Collections 有什么区别？
集合接口
java.util.Collection 是一个集合接口（集合类的一个顶级接口）。
它提供了对集合对象进行基本操作的通用接口方法。Collection接口在Java 类库中有很多具体的实现。
Collection接口的意义是为各种具体的集合提供了最大化的统一操作方式，其直接继承接口有List与Set。

工具类
Collections则是集合类的一个工具类/帮助类，其中提供了一系列静态方法，用于对集合中元素进行排序、搜索以及线程安全等各种操作。


#  List、Set、Map 之间的区别是什么？

说一下 HashMap 的实现原理？
HashMap概述：
HashMap是基于哈希表的Map接口的非同步实现。此实现提供所有可选的映射操作，
并允许使用null值和null键。此类不保证映射的顺序，特别是它不保证该顺序恒久不变。 

HashMap的数据结构：在java编程语言中，最基本的结构就是两种，
一个是数组，另外一个是模拟指针（引用），
所有的数据结构都可以用这两个基本结构来构造的，HashMap也不例外。HashMap实际上是一个“链表散列”的数据结构，即数组和链表的结合体。

当我们往Hashmap中put元素时,首先根据key的hashcode重新计算hash值,
根绝hash值得到这个元素在数组中的位置(下标),
如果该数组在该位置上已经存放了其他元素,那么在这个位置上的元素将以链表的形式存放,
新加入的放在链头,最先加入的放入链尾.如果数组中该位置没有元素,就直接将该元素放到数组的该位置上。

需要注意Jdk 1.8中对HashMap的实现做了优化,当链表中的节点数据超过八个之后,
该链表会转为红黑树来提高查询效率,从原来的O(n)到O(logn)

# 如何实现数组和 List 之间的转换？

List转换成为数组：调用ArrayList的toArray方法。
数组转换成为List：调用Arrays的asList方法。
Array可以容纳基本类型和对象，而ArrayList只能容纳对象。 


# 浅析Spring boot与Spring cloud 之间的关系
Spring boot 是 Spring 的一套快速配置脚手架，
可以基于spring boot 快速开发单个微服务，Spring Boot，看名字就知道是Spring的引导，
就是用于启动Spring的，使得Spring的学习和使用变得快速无痛。不仅适合替换原有的工程结构，更适合微服务开发。

Spring Cloud基于Spring Boot，为微服务体系开发中的架构问题，
提供了一整套的解决方案——服务注册与发现，服务消费，服务保护与熔断，网关，分布式调用追踪，分布式配置管理等。

Spring Cloud是一个基于Spring Boot实现的云应用开发工具；Spring boot专注于快速、方便集成的单个个体，
Spring Cloud是关注全局的服务治理框架；spring boot使用了默认大于配置的理念，很多集成方案已经帮你选择好了，
能不配置就不配置，Spring Cloud很大的一部分是基于Spring boot来实现