# Object
getClass()方法:返回Class类型的对象;
void notify():唤醒在此对象监视器上等待的单个线程
void notifyAll():唤醒在此对象监视器上等待的所有线程
void wait():导致当前的线程等待
void wait(long timeout):导致当前的线程等待，(超过指定的时间量会唤醒)
protected native Object clone()：克隆对象，浅拷贝（必须实现Cloneable接口）
protected void finalize()：垃圾回收器准备释放内存的时候，会先调用finalize()；
# hashcode
实例对象运行时的内存地址；
hash算法：通过散列算法，变换成固定长度的输出，该输出就是散列值；
1.只能通过原文计算出hash值，而且每次计算都一样，不能通过hash值计算原文。2.原文的微小变化就能是hash值发生巨大变化。3.一个好的hash算法还能尽量避免发生hash值重复的情况，也叫hash碰撞。
# Hash摘要算法
MD5信息摘要算法：密码散列函数，可以产生出一个`128位`（16字节）的散列值（hash value），用于确保信息传输完整一致。
SHA 家族: SHA256,SHA512,
# ==和equals的区别
==可以比基础数据类型也可以比较引用数据类型，比较基础数据类型时比较的是具体的值，比较引用数据类型实际上比较的是内存地址;
equals是Object的一个方法，默认的实现就是 ==;
toString():把一个实例对象转化成一个可打印的字符串
finalize(): 垃圾回收器准备释放内存的时候，会先调用finalize();JVM还没有快到耗尽内存的地步，它是不会浪费时间进行垃圾回收的;Java 9过时；
clone()：克隆就是在内存里边赋值一个实例对象
