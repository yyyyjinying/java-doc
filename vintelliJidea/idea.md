# serialVersionUID设置
进入setting→inspections→serialization issues→选择图中的选项。serializable class without ‘serialVersionUID’
# 如何拉取源码
```xml
<build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
        </plugins>
    </build>
```
# 在pom文件下
在父工程下执行，子工程不行；
执行terminal
- mvn dependency:sources -DdownloadSources=true -DdownloadJavadocs=true

在选择download sources
如果没有变化的话，在手动选择sources

# IDEA - maven子工程无法引用父工程的依赖
```xml
<groupId>com.rabbit</groupId>
<artifactId>rabbitmq-study</artifactId>
<packaging>pom</packaging>
<version>1.0-SNAPSHOT</version>
<modules>
    <module>producer</module>
    <module>consumer</module>
</modules>
<parent>
    <artifactId>rabbitmq-study</artifactId>
    <groupId>com.rabbit</groupId>
    <version>1.0-SNAPSHOT</version>
</parent>
<modelVersion>4.0.0</modelVersion>

<artifactId>producer</artifactId>
```
preferences->maven->always update snaphots(☑️)


# 如果开启Dashboard
在项目文件目录找到.idea目录并在workspace.xml中找到RunDashboard，配置如下；然后需要重新关闭项目重启项目配置生效；
```xml
 <component name="RunDashboard">
 <option name="ruleStates">
  <list>
   <RuleState>
    <option name="name" value="ConfigurationTypeDashboardGroupingRule" />
   </RuleState>
   <RuleState>
    <option name="name" value="StatusDashboardGroupingRule" />
   </RuleState>
  </list>
 </option>
<!-- 新增的配置 -->
 <option name="configurationTypes">
 <set>
  <option value="SpringBootApplicationConfigurationType" />
 </set>
</option>
```


# 快捷键
- 向后删除键 delete
- 向前删除键 fn+delete
- Home Fn + ←
- End Fn + →
- ⇥ 右制表符（Tab键）
- ⇤ 左制表符（Shift+Tab）
- ⌘⌥L 格式化代码
- command+G定位
- 多行注释：control+shift+/
- 讲多行连成一行：control+shift+J
- option + fn + delete 删除到单词末尾
- option + delete 删除到单词开始
- command + 加号/command + 减号 展开/折叠代码块
- command + shift + 加号 展开所有代码块
- command + shift + 减号 折叠所有代码块
- Command + y 删除当前行

- 按下 option+tab 可以循环切换四个声调
- 1、切换候选词
- －和＋，或者左右键
- 2、展开候选词
- 左右两个括弧键或者上下键
- alt+f7 : 查找在哪里使用 相当于eclipse的ctrl+shift+G
- command+alt+f7 : 这个是查找选中的字符在工程中出现的地方，可以不是方法变量类等，这个和上面的有区别的
- command＋F7 : 可以查询当前元素在当前文件中的引用，然后按F3可以选择 ，功能基本同上 
- 选中文本，按command+shift+F7 ，高亮显示所有该文本，按Esc高亮消失。 
- 选中文本，按Alt+F3 ，逐个往下查找相同文本，并高亮显示。
- shift+f3 : 就是往上找
- `ctrl+enter : 出现生成get,set方法的界面` 
- shift+enter : 换到下一行
- command+N : 查找类
- command+shift+N : 查找文件
- command+R : 替换
- ctrl+shift+R : 可以在整个工程或着某个目录下面替换变量
- command+Y : 查看当前方法实现
- command+D : 复制当前行到下一行
- ctrl+shift+J : 把多行连接成一行，会去掉空格的行
- command+J : 可以生成一些自动代码，比如for循环
- command+B : 找变量的来源 同F4 查找变量来源
- ctrl+shift+B : 找变量所属的类
- command+G : 定位
- command+F : 在当前文件里查找文本 f3向下看，shift+f3向上看
- ctrl+shift+F : 可以在整个工程或着某个目录下面查找变量 相当于eclipse里的ctrl+H
- alt+shift+C :最近修改的文件
- command+E :最近打开的文件
- alt+enter :导入包，自动修改
- command+alt+L :格式化代码
- command+alt+I : 自动缩进，不用多次使用tab或着backspace键，也是比较方便的
- ctrl+shift+space :代码补全，这个会判断可能用到的，这个代码补全和代码提示是不一样的
- `command+P : 方法参数提示`
- `command+alt+T : 把选中的代码放在 TRY{} IF{} ELSE{} 里`
- command+X :剪切删除行
- command+shift+V : 可以复制多个文本
- command+shift+U : 大小写转换
- alt+f1 :查找文件所在目录位置
- command+/ :注释一行或着多行 //
- ctrl+shift+/ : 注释/…/
- command+shift+上下箭头 : 把代码上移或着下移


- alt+f8 : debug时选中查看值f8相当于eclipse的f6跳到下一步
- shift+f8 :相当于eclipse的f8跳到下一个断点
- alt+shift+f7 :这个是强制进入代码
- command+f9 debug :运行java类
- ctrl+shift+f10 :正常运行java类
- command+f2 :停止运行


 
- `commond+O : 快速override重写类方法`
-  shift+enter : 换到下一行
# 快速查看修改文件
- shift+f6 :重命名
- command+f12 :可以显示当前文件的结构
- command+alt+左右箭头 : 返回上次编辑的位置
- 选中文本，按Alt+F3 ，enter逐个往下查找相同文本，并高亮显示,esc取消高亮；
- command+B : 找变量的来源 同F4 查找变量来源
# 格式化
- command+option+L 快速格式化
- command+shift+U 小写字母转大写

# 快捷键查找
- command+N `按名字搜索类` 
- command+shift+N 按文件名搜索文件

- ctrl+H `查看类的继承关系`，例如HashMap的父类是AbstractMap
- command+option+B `查找接口的实现类以及实现类的方法`
- option+F7 查找类或方法在哪被使用
- command+F 在当前文件夹下，按照文本的内容查找
- command+R : 替换
- command+单击 `查看当前类在哪里被使用`
- Ctrl+Shift+F `项目全局文件夹下，按照文本的内容查找`
- Ctrl+shift+R : 可以在整个工程或着某个目录下面替换变量
- `shift + shift 任意搜`
- shift+f6 :重命名
- command+F12 :可以显示当前文件的结构
- command+alt+左右箭头 : 返回上次编辑的位置
- 选中文本，按Alt+F3 ，enter逐个往下查找相同文本，并高亮显示,esc取消高亮；
- command+B : 找变量的来源 同F4 查找变量来源
- command + shift + F `全文查找字符`
- command+alt+T : `把选中的代码放在 TRY{} IF{} ELSE{}` 里

- command + o 可以快速实现@Override
- control + N 代码自动生成
- `control + G : 连续选中多个当前单词`



