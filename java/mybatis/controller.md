```java
// post请求的传参数
/**
axios.post('/user/login',{
    username: this.username,
    password: this.password
}).then(
*/
@PostMapping("/login")
    public Result login(@RequestBody User user) { ……

```

****