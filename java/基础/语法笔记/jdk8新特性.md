# Java8特性
1. 接口默认方法
​ 在JDK8之前，接口不能定义任何实现，这意味着之前所有的JAVA版本中，接口制定的方法是抽象的，不包含方法体。从JKD8开始，添加了一种新功能-默认方法。默认方法允许接口方法定义默认实现，而所有子类都将拥有该方法及实现。

​ 默认方法的主要优势是提供一种拓展接口的方法，而不破坏现有代码。假如我们有一个已经投入使用接口，需要拓展一个新的方法，在JDK8以前，如果为一个使用的接口增加一个新方法，则我们必须在所有实现类中添加该方法的实现，否则编译会出现异常。如果实现类数量少并且我们有权限修改，可能会工作量相对较少。如果实现类比较多或者我们没有权限修改实现类源代码，这样可能就比较麻烦。而默认方法则解决了这个问题，它提供了一个实现，当没有显示提供其他实现时就采用这个实现。这样新添加的方法将不会破坏现有代码
```java
public interface Animal {
    public static int numname = 1;
    static int numage = 1;
    public static final String name="aaa";

    // 静态变量
    int NUM = 1;

    static void eat(){
        System.out.println("eat");
    }

    // 抽象方法
    void say();

    // 默认方法可以有方法体
    default void play(){
        System.out.println("play");
    }


    class Dog implements Animal {

        @Override
        public void say() {
            System.out.println("say");
        }

        @Override
        public void play() {
            Animal.super.play();
            System.out.println("override play");
        }
    }

    static void main(String[] args) {
        Dog dog = new Dog();
        dog.say();
        dog.play();

    }
}
```

2. 函数式接口
​ 函数式接口在Java中是指：有且仅有一个抽象方法的接口

​ 函数式接口，即适用于函数式编程场景的接口。而Java中的函数式编程体现就是Lambda，所以函数式接口就是可以适用于Lambda使用的接口。只有确保接口中有且仅有一个抽象方法，Java中的Lambda才能顺利地进行推导。

接下来给大家介绍几个常用的函数式接口，在我们接下来要学习的Lamdba表达式中大量使用。

```java
@FunctionalInterface
public interface Consumer<T> {
    void accept(T t);
}
@FunctionalInterface
public interface Predicate<T> {

    boolean test(T t);
}
@FunctionalInterface
public interface Function<T, R> {
    R apply(T t);
}
和我们的普通接口一样，每个接口代表一种能力，需要子类去实现，因为它们是函数式接口，所以匿名内部类都可以写成箭头函数的形式。
```

```java
class Test2 implements Runnable{		
    public void run() {
        for(int i=0;i<20;i++) {
            System.out.println("一边听歌");
        }
    }
}		
new Thread(new Test2()).start();

//匿名内部类 必须借助接口或者父类
new Thread(new Runnable() {
    public void run() {
        for(int i=0;i<20;i++) {
            System.out.println("一边听歌");
        }
    }
}).start();

//jdk8 简化  lambda表达式
new Thread(()-> {
        for(int i=0;i<20;i++) {
            System.out.println("一边听歌");
        }
    }
).start();

/*
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.function.Supplier;
*/
public class ToUpper implements Function<String, Integer> {
    @Override
    public Integer apply(String s) {
        return Integer.parseInt(s);
    }

    public static void main(String[] args) {
        Integer apply = new ToUpper().apply("123");
        System.out.println(apply);

        Function<String, String> stringToStringFunction = new Function<String, String>() {
            @Override
            public String apply(String s) {
                return s.toUpperCase();
            }
        };

        String aaa = stringToStringFunction.apply("aaa");
        System.out.println(aaa);


        Function<String, String> stringToLambadFunction = s -> s.toUpperCase();
        String bbbb = stringToLambadFunction.apply("bbbb");
        System.out.println(bbbb);

        Consumer<String> consumer = (s) -> System.out.println(s);
        consumer.accept("aa");
        Consumer<String> consumer2 = System.out::println;

        consumer2.accept("bb");


        Supplier<String> supplier = () -> "aaaa";
        String s = supplier.get();
        System.out.println(s);

//        断言
        Predicate<String> predicate = (str) -> str.contains("a");

        boolean bol = predicate.test("aaa");
        System.out.println(bol);


    }
}

/*Aaa obj = option.orElseGet(() -> {
    return new Aaa("default-name");
});*/

Aaa obj = option.orElseGet(Aaa::new);

```
`函数式接口等同于普通接口中仅有一个抽象方法，可以使用匿名内部类和lambal表达式的形式创建对象(如果是public void run()创建对象并执行)；`


# Optional
## Optional对象的创建
Optional类提供了三个静态方法empty()、of(T value)、ofNullable(T value)来创建Optinal对象，示例如下：
```java
// 1、创建一个包装对象值为空的Optional对象
Optional<String> optStr = Optional.empty();
// 2、创建包装对象值非空的Optional对象
Optional<String> optStr1 = Optional.of("optional");
// 3、创建包装对象值允许为空的Optional对象
Optional<String> optStr2 = Optional.ofNullable(null);
```
## Optional 类典型接口的使用
## get
```java
public T get() {
    if (value == null) {
        throw new NoSuchElementException("No value present");
    }
    return value;
}
```
可以看到，get()方法主要用于返回包装对象的实际值，但是如果包装对象值为null，会抛出NoSuchElementException异常。

## isPresent()
方法的源码：
ifPresent()方法接受一个Consumer对象（消费函数），如果包装对象的值非空，运行Consumer对象的accept()方法。示例如下：
```java
public static void printName(Student student){
    Optional.ofNullable(student).ifPresent(u ->  System.out.println("The student name is : " + u.getName()));
}

```
## orElse()
方法的源码：
```java
public T orElse(T other) {
    return value != null ? value : other;
}
```
orElse()方法功能比较简单，即如果包装对象值非空，返回包装对象值，否则返回入参other的值（默认值）。

## orElseGet
## orElseThrow

```java
public static String getGender(Student student){
    return Optional.ofNullable(student).map(u -> u.getGender()).orElse("Unkown");
}
```

```java
public class OptionalTest {

    public static void main(String[] args) {

        class Aaa {
            private String name;

            public Aaa() {
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }

            public Aaa(String name) {
                this.name = name;
            }

            @Override
            public String toString() {
                return "Aaa{" +
                        "name='" + name + '\'' +
                        '}';
            }
        }

        Aaa aaa = null; //new Aaa();

        // 允许有空null
        Optional<Aaa> option = Optional.ofNullable(aaa);

        // 如果为null，就生产者产生一个默认对象
        /*Aaa obj = option.orElseGet(() -> {
            return new Aaa("default-name");
        });*/

        Aaa obj = option.orElseGet(Aaa::new);

        // 打印
        System.out.println(obj);

        Aaa hhhhhh = option.orElseThrow(() -> new RuntimeException("hhhhhh"));
        System.out.println(hhhhhh.getName());


    }

}
```

# Stream编程
Java8中的Stream是对容器对象功能的增强，它专注于对容器对象进行各种非常便利、高效的 聚合操作（aggregate operation），或者大批量数据操作 (bulk data operation)。Stream API借助于同样新出现的Lambda表达式，极大的提高编程效率和程序可读性。同时，它提供串行和并行两种模式进行汇聚操作，并发模式能够充分利用多核处理器的优势。通常，编写并行代码很难而且容易出错, 但使用Stream API无需编写一行多线程的代码，就可以很方便地写出高性能的并发程序。

​ 我觉得我们可以将流看做流水线，这个流水线是处理数据的流水线，一个产品经过流水线会有一道道的工序就如同对数据的中间操作，比如过滤我不需要的，给数据排序能，最后的终止操作就是产品从流水线下来，我们就可以统一打包放入仓库了。

​ 当我们使用一个流的时候，通常包括三个基本步骤：获取一个数据源（source）→ 数据转换 → 执行操作获取想要的结果。每次转换原有Stream对象不改变，返回一个新的Stream对象（可以有多次转换），这就允许对其操作可以像链条一样排列，变成一个管道，如下图所示:

Stream有几个特性：
- Stream不存储数据，而是按照特定的规则对数据进行计算，一般会输出结果。
- Stream不会改变数据源，通常情况下会产生一个新的集合或一个值。
- Stream具有延迟执行特性，只有调用终端操作时，中间操作才会执行。

## Stream流的创建
Stream可以通过集合数组创建。
通过 java.util.Collection.stream() 方法用集合创建流，我们发现
```java
List<String> list = Arrays.asList("a", "b", "c");
// 创建一个顺序流
Stream<String> stream = list.stream();
// 创建一个并行流
Stream<String> parallelStream = list.parallelStream();

```
使用java.util.Arrays.stream(T[] array)方法用数组创建流
```java
int[] array={1,3,5,6,8};
IntStream stream = Arrays.stream(array);
```
使用Stream的静态方法：of()、iterate()、generate()
```java
Stream<Integer> stream = Stream.of(1, 2, 3, 4, 5, 6);

Stream<Integer> stream2 = Stream.iterate(0, (x) -> x + 3).limit(4);
stream2.forEach(System.out::println);

Stream<Double> stream3 = Stream.generate(Math::random).limit(3);
stream3.forEach(System.out::println);
```

# Stream的终止操作
## 遍历/匹配（foreach/find/match）
数据流消费掉
```java
// 打印集合的元素
simpleList.stream().forEach(System.out::println);
// 其实可以简化操作的
simpleList.forEach(System.out::println);

public void findFirst() {
        Optional<Person> first = this.personList.stream().findFirst();
        System.out.println(first);
        Optional<Person> any = personList.stream().findAny();
        System.out.println(any);
// 随便找一个,可以看到findAny()操作，返回的元素是不确定的，
    // 对于同一个列表多次调用findAny()有可能会返回不同的值。
    // 使用findAny()是为了更高效的性能。如果是数据较少，串行地情况下，一般会返回第一个结果，
    // 如果是并行的情况，那就不能确保是第一个。
        Optional<Person> any1 = personList.parallelStream().findAny();
        System.out.println(any1);
        any1.ifPresent(p -> System.out.println(p));

// 判断有没有任意一个人年龄大于35岁
        boolean flag = personList.stream().anyMatch(item -> item.getAge() > 35);
// 判断是不是所有人年龄都大于35岁
        System.out.println(flag);
        boolean b = personList.stream().allMatch(item -> item.getAge() > 35);
        System.out.println(b);

    }

````
##  归集(toList/toSet/toMap)
## 统计(count/averaging/sum/max/min）
## 归约reduce
归约，也称缩减，顾名思义，是把一个流缩减成一个值，能实现对集合求和、求乘积和求最值操作。
```java
Integer result = simpleList.stream().reduce(1,(n1, n2) -> n1*n2);
    System.out.println(result);
```
## 接合(joining)
joining可以将Stream中的元素用特定的连接符（没有的话，则直接连接）连接成一个字符串。
```java
List<String> list = Arrays.asList("A", "B", "C");
		String string = list.stream().collect(Collectors.joining("-"));
		System.out.println("拼接后的字符串：" + string);
```
## 分组(partitioningBy/groupingBy)
分组：将集合分为多个Map，比如员工按性别分组;
```java
// 将员工按薪资是否高于8000分组
    Map<Boolean, List<Person>> part = personList.stream().collect(Collectors.partitioningBy(x -> x.getSalary() > 8000));
    // 将员工按性别分组
    Map<String, List<Person>> group = personList.stream().collect(Collectors.groupingBy(Person::getSex));
    // 将员工先按性别分组，再按地区分组
    Map<String, Map<String, List<Person>>> group2 = personList.stream().collect(Collectors.groupingBy(Person::getSex, Collectors.groupingBy(Person::getArea)));
    System.out.println("员工按薪资是否大于8000分组情况：" + part);
    System.out.println("员工按性别分组情况：" + group);
    System.out.println("员工按性别、地区：" + group2);
```

# Stream中间操作
筛选（filter）
```java
List<Person> collect = personList.stream().filter(item -> item.getSalary() > 8000).collect(Collectors.toList());
System.out.println("collect = " + collect);
```
映射(map/flatMap)
```java
List<Person> collect4 = personList.stream().map(person -> {
            person.setSalary(person.getSalary() + 100);
            return person;
        }).collect(Collectors.toList());
        System.out.println(collect4);
```
# 排序(sorted)
```java
// 按工资升序排序（自然排序）
    List<String> newList = personList.stream().sorted(Comparator.comparing(Person::getSalary)).map(Person::getName)
        .collect(Collectors.toList());
    // 按工资倒序排序
    List<String> newList2 = personList.stream().sorted(Comparator.comparing(Person::getSalary).reversed())
        .map(Person::getName).collect(Collectors.toList());
    // 先按工资再按年龄升序排序
    List<String> newList3 = personList.stream()
        .sorted(Comparator.comparing(Person::getSalary).thenComparing(Person::getAge)).map(Person::getName)
        .collect(Collectors.toList());
    // 先按工资再按年龄自定义排序（降序）
    List<String> newList4 = personList.stream().sorted((p1, p2) -> {
        if (p1.getSalary() == p2.getSalary()) {
            return p2.getAge() - p1.getAge();
        } else {
            return p2.getSalary() - p1.getSalary();
        }
    }).map(Person::getName).collect(Collectors.toList());

    System.out.println("按工资升序排序：" + newList);
    System.out.println("按工资降序排序：" + newList2);
    System.out.println("先按工资再按年龄升序排序：" + newList3);
    System.out.println("先按工资再按年龄自定义降序排序：" + newList4);

```
# peek操作
```java
// 在stream中间进行调试，因为stream不支持debug
    List<Person> collect = personList.stream().filter(p -> p.getSalary() > 5000)
        .peek(System.out::println).collect(Collectors.toList());
    // 修改元素的信息，给每个员工涨工资一千
    personList.stream().peek(p -> p.setSalary(p.getSalary() + 1000))
        .forEach(System.out::println);
```
# 其他操作
流也可以进行合并、去重、限制、跳过等操作。
```java
// distinct去掉重复数据   
    // skip跳过几个数据
    // limit限制使用几个数据
    simpleList.stream().distinct().skip(2).limit(3).forEach(System.out::println);
```