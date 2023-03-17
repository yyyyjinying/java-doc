```java
// import com.alibaba.fastjson.JSON;
// toJSONString可以将map转化为字符串
// 
private void sendMsg(String email, String username) {
    Map<String,String> map = new HashMap();
    map.put("type", Constants.MSG_EMAIL);
    map.put("emailName", email);
    map.put("username", username);
    String message = JSON.toJSONString(map);
    log.info("####会员服务推送消息到消息服务平台####json:{}", message);
    rabbitTemplate.convertAndSend("r_email_exchange", "r_email_routing_key", message);
}

// parseObject可以将字符串转化为map
Map map = JSON.parseObject(message, Map.class);
String email = (String) map.get("emailName");
```

# @JsonSerialize
我们将对象序列化为JSON传输给前端，有时候我们的某个或者某些字段需要特殊处理，比如我们有一个日期字段，我们希望当日期为NULL时给前端不返回NULL而返回为未完成等信息，或者我们有一些状态字段，我们需要给前端返回状态对应的信息，此时我们就需要自定义字段的序列化。
 @JsonSerialize(using = ObjectIdSerializer.class)
 @JsonSerialize(nullusing = ObjectIdSerializer.class)
# @JsonIgnoreProperties 
//生成json时将name和age属性过滤
@JsonIgnoreProperties({"name","age"})
public class  user {
private  String name;
private int age;
# @JsonIgnore
在json序列化时将java bean中的一些属性忽略掉
public class  user {
private  String name;
@JsonIgnore
private int age;
}

# @JsonSerialize
此注解用于属性或者getter方法上，用于在序列化时嵌入我们自定义的代码，比如序列化一个double时在其后面限制两位小数点。
# @JsonDeserialize
此注解用于属性或者setter方法上，用于在反序列化时可以嵌入我们自定义的代码，类似于上面的@JsonSerialize

# @Transient
@[email protected]�射,ORM框架将忽略该属性；
如

# @JsonProperty("items")