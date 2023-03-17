# String
本质：final修饰的字符数组，private final char value[];c/c++语言是很不同的，其不可变性（string.replace("a","b")只会生成新的String）;
String对象值是不可变的，一切操作都不会改变String的值，而是通过构造新的字符串来实现字符串操作;
实例1:
String s1 = "hello";String s2 = "hello",基于重复使用String的情况比更改String的场景更多的前提下，Java把String设计为不可变，保持数据一致性，使得同个字面量的字符串可以引用同个String对象，重复利用已存在的String对象
# 存储原理
由于String对象的不可变特性，在存储上也与普通的对象不一样。我们都知道对象创建在 堆 上，而String对象其实也一样，不一样的是，同时也存储在 常量池 中。处于堆区中的String对象，在GC时有极大可能被回收；而常量池中的String对象则不会轻易被回收，那么则可以重复利用常量池中的String对象。也就是说， 常量池是String对象得以重复利用的根本原因 。常量池不轻易垃圾回收的特性，使得常量池中的String对象可以一直存在，重复被利用
## 常量池中创建String对象只有两种:
1.双引号构造字符串对象、2.String对象的intern()方法；其他方法都是在堆区创建对象。每次在常量池创建String对象前都会检查是否存在相同的String对象，如果是则会直接返回该对象的引用，而不会重新创建一个对象；
问题1:String s = new String("abc"),这句代码创建了几个对象？"abc"在常量池中构造了一个对象，new String()方法在堆区中又创建了一个对象，所以一共是两个。问题2:s=="abc"的结果是false。两个不同的对象，一个位于堆中，一个位于常量池中；问题3: s.substring(0,2).intern()=="ab" intern方法在常量池中构建了一个值为“ab"的String对象，"ab"语句不会再去构建一个新的String对象，而是返回已经存在的String对象。所以结果是true；
# 字符串拼接：
1.使用StringBuilder进行修改、拼接等操作来初始化字符串是更加高效率的做法。StringBuffer和StringBuilder的接口一致，但StringBuffer对操作方法都加上了synchronize关键字，保证线程安全的同时，也付出了对应的性能代价。单线程环境下更加建议使用StringBuilder；
2.编译器会把"ab"+"cd"+"fg"直接优化成"abcdefg" ，与String s1 = "abcdefg"; 是等价的。这种优化也就减少了拼接时产生的消耗。甚至比使用StringBuilder更加高效；
3.字面量直接拼接会合成一个字面量;s2 = "hollo" + s1;(默认采用StringBuilder)

# 代码单元和代码点
在一个字符串中，当我们调用String.length() 方法时，返回的是代码单元的数目， String.charAt() 返回也是对应下标的代码单元。这在正常情况下并没有什么问题。而如果允许输入特殊字符时，这就有大问题了。要获得真正的代码点数目，可以调用 String .codePointCount 方法；要获得对应的代码点，可调用 String.codePointAt 方法。以此来兼容拓展的字符集。一个字符为一个代码点，一个char称为一个代码单元。一个代码点可能占据一个或两个代码单元。若允许输入特殊字符，则必须使用代码点为单位来操作字符串。

编码表与二进制对比；
```java
// 常量池中
String a = "123";
String b = "123";
// 开辟新的堆内存中，引用不同
String c = new String("123");
String d = new String("123");
System.out.println(a == b); true
System.out.println(c == d); false
```
