# 
## 特设类
比如：Dictionary, Vector, Stack, 和 Properties 这些类用来存储和操作对象组。
缺少一个核心的，统一的主题；
## 集合框架
围绕一组标准接口设计。
java.util 包

两个接口派生而出：Collection 和 Map，又包含了一些子接口或实现类。
6个接口
5个抽象类
8个实现类

Collection 接口是一组允许重复的对象
Set 接口继承 Collection，集合元素不重复。
List 接口继承 Collection，允许重复，维护元素插入顺序

Map接口是键－值对象

Set、List 和 Map 可以看做集合的三大类：
List 集合是有序集合，集合中的元素可以重复，访问集合中的元素可以根据元素的索引来访问。
Set 集合是无序集合，集合中的元素不可以重复，访问集合中的元素只能根据元素本身来访问（也是集合里元素不允许重复的原因）。
Map 集合中保存 Key-value 对形式的元素，访问时只能根据每项元素的 key 来访问其 value。
