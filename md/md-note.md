# MD语法入门
## 标题
```js
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题
```
## 列表
```json
//形式一
+ a
+ b
+ c
//形式二
- d
- e
- f
//形式三
* g
* h
* i
```

## 有序列表
//正常形式
1. abc
2. bcd
3. cde
//错序效果
2. fgh
3. ghi
5. hij
```js
//正常形式
1. abc
2. bcd
3. cde
//错序效果
2. fgh
3. ghi
5. hij
```

## 嵌套列表
>列表可以嵌套，使用时在嵌套列表前按 tab 或 空格 来缩进,去控制列表的层数
+ 123
+ abc
    + bcd
    + cde
+ 465
+ 789

//有序列表嵌套
1. abcd
   1. abcde
   2. abcde
   3. abcde
2. bcde
3. cdef

## 引用说明区块
对某个部分做的内容做一些说明或者引用某某的话等，可以用这个语法。
> 引用内容、说明内容。在语句前面加一个 

> ，注意是英文的那个右尖括号，注意空格，引用因为是一个区块，理论上是应该什么内容都可以放，比如说：标题，列表，引用等等。

## 代码块
在发布一些技术文章会涉及展示代码的问题，这时候代码块就显得尤为重要。

` shaoliangdaima,danhangshiyong `
```
    daliangdaima,xuyaoduohangshiyong
    daliangdaima,xuyaoduohangshiyong
    daliangdaima,xuyaoduohangshiyong
    daliangdaima,xuyaoduohangshiyong
    daliangdaima,xuyaoduohangshiyong
```

```html
<!-- English -->
<script src="../dist/js/languages/en.js"></script>

<!-- 繁體中文 -->
<script src="../dist/js/languages/zh-tw.js"></script>
```

## 链接
链接的文字放在[]中，链接地址放在随后的()中，链接也可以带title属性，链接地址后面空一格，然后用引号引起来，如下：
-------
[简书]: https://www.jianshu.com "创作你的创作"
[简书]是一个创作社区,任何人均可以在其上进行创作。用户在简书上面可以方便的创作自己的作品,互相交流。
//参数定义的其他写法
[简书]: https://www.jianshu.com '创作你的创作'
[简书]: https://www.jianshu.com (创作你的创作)
[简书]: <https://www.jianshu.com> "创作你的创作"

[简书](https://www.jianshu.com "创作你的创作"),

## 图片
![my-logo.png](https://upload-images.jianshu.io/upload_images/13623636-6d878e3d3ef63825.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240 "my-logo")

car
------
![car](./img/car.jpg)

## 分割线
最少三个下划线和星号
- - -
***

## 强调字体
一个星号或者是一个下划线包起来，会转换为<em>倾斜，如果是2个，会转换为<strong>加粗
---
_强调_
---
**强调**

## 转义
\\
\*
\+
\-
\`
\_

## 删除线
用~~把需要显示删除线的字符包裹起来
---
~~删除~~
~~删除~~

## 表格
//例子一
| 123  |  234 |  345 |
| :--- | ---: | ---: |
| 123  |  234 |  345 |
| 123  |  234 |  345 |


//例子三

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ | :-------------: | ------------: |
| col 3 is      | some wordy text |         $1600 |
| col 2 is      |    centered     |           $12 |
| zebra stripes |    are neat     |            $1 |

## 锚点
<a href="#title1">标题一</a>
<a href="#title2">标题二</a>
<a href="#title3">标题三</a>

<h2 id="title1">标题一内容</h2>
<h2 id="title2">标题二内容</h2>
<h2 id="title3">标题三内容</h2> 

