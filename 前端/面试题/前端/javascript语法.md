# 1. void
Javascript中void是一个操作符，该操作符指定要计算一个表达式但是不返回值
- <a href="javascript:console.log('javascript');alert('javascript')">Link</a>
- 浏览器不会将其href视为引用路径。相反，它将其视为一些 JavaScript 代码
- 使用void，它告诉浏览器不要返回任何东西（或 return undefined）
- 链接属性的javascript:伪 URL一起使用href。
# 2. Object.is
Object.is() 与 == 不同。== 运算符在判断相等前对两边的变量（如果它们不是同一类型）进行强制转换（这种行为将 "" == false 判断为 true），而 Object.is 不会强制转换两边的值。
Object.is() 与 === 也不相同。差别是它们对待有符号的零和 NaN 不同，例如，=== 运算符（也包括 == 运算符）将数字 -0 和 +0 视为相等，而将 Number.NaN 与 NaN 视为不相等。

# 3.包装类型对象
- new Boolean(false)    // true

# 4. 如何判断一个对象是空对象
- JSON.stringify(obj) === "{}"
- Object.keys().length < 0
  
# 5. const 
- 不是保证变量的值不能改动，而是变量指向的内存地址不能改动。

# 6. 扩展运算符 ... 和 Object.assign(目标对象, 源对象)
- 扩展运算符(...)用于取出参数对象中的所有可遍历属性，拷贝到当前对象中；
-  [...arguments] 代替 Array.prototype.slice.call(arguments)

# esm是什么？
- esm 是 javascript 的标准功能，在浏览器端和 nodejs 中都已得到实现。使用 esm 的好处是浏览器可以最优化加载模块，比使用库更有效率。
- esm 标准通过import, export语法实现模块变量的导入和导出。
## esm 模块的特点
- 存在模块作用域，顶层变量都定义在该作用域，外部不可见；
- 模块脚本自动采用严格模式；
- 模块顶层的this关键字返回undefined；
- esm 是编译时加载，也就是只有所有import的模块都加载完成，才会开始执行；
- 同一个模块如果加载多次，只会执行一次。
- 相关详细讲解 https://segmentfault.com/a/1190000041789653
### 静态导入和动态导入
- 静态导入会显着减慢代码的加载速度，并且您需要正在导入的代码的可能性很小，或者直到以后才需要它。
- 静态导入会显着增加程序的内存使用量，并且您需要导入的代码的可能性很小。
- 当您正在导入的模块在加载时不存在时
- 当需要动态构造导入说明符字符串时。（静态导入仅支持静态说明符。）
- 当导入的模块有副作用时，除非某些条件为真，否则您不希望出现这些副作用。（建议不要在模块中产生任何副作用，但有时您无法在模块依赖项中控制它。）