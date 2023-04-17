```java

req.setAttribute("list", airportService.show());
req.getRequestDispatcher("index.jsp").forward(req, resp);  // dispatcher 调度器

在被Spring 管理的类中通过@Value(“${key}”)取出properties 中内容

@GetMapping("/userName")
public List<User> getUserListByName(@RequestParam(name = "userName",defaultValue = "") String userName) {
    return repository.findByUserName(userName);
}

```

构造方法里面禁止加入任何业务逻辑，如果有初始化逻辑，请放在init方法中。
反编译出的字节码文件显示每次循环都会new出一个StringBuilder对象，然后进行append操作，最后通过toString() 返回String对象，造成内存资源浪费。
@ApiOperation("名片编辑")
    @PostMapping("/edit")
    public Result<?> edit(@RequestBody @Validated NameCard nameCard, BindingResult br) {

        Optional<Map<String, Object>> optional = ValidatedUtils.hasBindingFailure(br);
        if (optional.isPresent()) {
            return Result.error("参数绑定失败", optional.get());
        }

        boolean bol = nameCardService.updateNameCard(nameCard);
        return bol ? Result.OK("修改名片成功", bol) : Result.error("修改失败成功", bol);
    }
    