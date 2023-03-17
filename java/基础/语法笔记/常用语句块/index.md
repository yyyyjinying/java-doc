```java

req.setAttribute("list", airportService.show());
req.getRequestDispatcher("index.jsp").forward(req, resp);  // dispatcher 调度器

在被Spring 管理的类中通过@Value(“${key}”)取出properties 中内容

@GetMapping("/userName")
public List<User> getUserListByName(@RequestParam(name = "userName",defaultValue = "") String userName) {
    return repository.findByUserName(userName);
}

```