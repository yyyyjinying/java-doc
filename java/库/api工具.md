# 日期时间处理
```java
 LocalDateTime now2 = LocalDateTime.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH时mm分ss秒");
String format = now2.format(formatter);

```