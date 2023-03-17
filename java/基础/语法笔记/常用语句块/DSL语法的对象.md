# DSL是什么，Java怎样构造DSL方法重构

Domain-specific language: 一种专注于某一领域，仅针对部分表达方式的计算机编程语言。

特点
- 方法链 Method Chaining
- 功能序列 Functional Sequence
- 嵌套函数 Nested Functions 嵌套函数
- Lambda表达式/闭包 Lambda Expressions/Closures

使用Java编写的DSL不会造就一门业务用户可以上手的语言，而会是一种业务用户也会觉得易读的语言，同时，从程序员的角度，它也会是一种阅读和编写都很直接的语言。
创建DSL最好的方法是，首先将所需的API原型化，然后在基础语言的约束下将它实现。DSL的实现将会牵涉到连续不断的测试来肯定我们的开发确实瞄准了正确的方向。该“原型－测试”方法正是测试驱动开发模式（TDD－Test-Driven Development）所提倡的。

其实JDK8提供的很多api已经有很多内部DSL的语义，比如Stream流的find、count等操作都是一种DSL的语义表达；