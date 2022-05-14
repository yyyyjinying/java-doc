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