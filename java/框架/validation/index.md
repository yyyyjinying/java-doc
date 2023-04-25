# @NotNull
@NotNull 常用在数据类型为Long，Integer的基础数据类型上，可以配合@Size、@Max、@Min对数值进行大小的控制

# 主键和数字校验
```java
@ApiModelProperty(value = "编号")
@NotNull(message = "编号不能为空")
@JsonFormat(shape = Shape.STRING)
private Long id;

@ApiModelProperty(value = "价格")
@NotNull(message = "价格不能为空")
@Min(value = 100, message = "价格不能低于100")
@Max(value = 5000, message = "价格不能超过5000")
private Integer price;

@ApiModelProperty(value = "数量")
@NotNull(message = "数量不能为空")
@Size(min = 10, max = 50, message = "数量必须不低于10不超过50")
private Integer num;
```
# @NotEmpty 数组集合校验
@NotEmpty 常用在集合类和数组类型上，也可以配合@Size进行大小的控制。
```java
@ApiModelProperty(value = "材料保存列表", required = true)
@NotEmpty(message = "存货清单列表不能为空")
@Size(min = 1, message = "至少需要一条数据")
private List<MaterialAcceptanceItemsSaveVo> itemsSaveList;
```

# @NotBlank 字符串校验
@NotBlank 只用于String数据类型上，可以和@Len配合使用限制字符长度。
```java
@ApiModelProperty(value = "供应商", required = true)
@NotBlank(message = "供应商不能为空")
@Len(min = 1, max = 500)
private String provider;

@ApiModelProperty(value = "发票号", required = true)
@Len(min = 0, max = 250)
private String invoiceNo;
```
# BigDecimal数据类型校验
Long数据类型防止精度丢失，添加注解：@JsonFormat(shape = Shape.STRING)
BigDecimal数据类型的限制注解使用：@DecimalMin、@DecimalMax、@Digits
```java
@ApiModelProperty(value = "报账总金额")
@DecimalMin(value = "0", inclusive = false, message = "报账总金额必须大于0")
@Digits(integer = 10, fraction = 2, message = "报账总金额 最大长度:10，允许精度:2")
private BigDecimal financeMoney;
```
# status值校验
```java
// @Pattern(regexp = "^[0,1]{1}$",message = "帐号启用状态:0->禁用；1->启用")
@Range(min=0, max=1,message = "帐号启用状态:0->禁用；1->启用")
@NotNull(message = "帐号启用状态不能为空")
@ApiModelProperty(value = "帐号启用状态：0->禁用；1->启用")
private Integer status;
```

@Null	被注解的元素必须为 null
@NotNull	被注解的元素必须不为 null
@AssertTrue	被注解的元素必须为 true
@AssertFalse	被注解的元素必须为 false
@Min(value)	被注解的元素必须是一个数字，其值必须大于等于指定的最小值
@Max(value)	被注解的元素必须是一个数字，其值必须小于等于指定的最大值
@DecimalMin(value)	被注解的元素必须是一个数字，其值必须大于等于指定的最小值
@DecimalMax(value)	被注解的元素必须是一个数字，其值必须小于等于指定的最大值
@Size(max, min)	被注解的元素的大小必须在指定的范围内
@Digits (integer, fraction)	被注解的元素必须是一个数字，其值必须在可接受的范围内
@Past	被注解的元素必须是一个过去的日期
@Future	被注解的元素必须是一个将来的日期
@Pattern(value)	被注解的元素必须符合指定的正则表达式
Hibernate Validator 扩展注解
@Email	被注解的元素必须是电子邮箱地址
@Length	被注解的字符串的大小必须在指定的范围内
@NotEmpty	被注解的字符串的必须非空
@Range	被注解的元素必须在合适的范围内