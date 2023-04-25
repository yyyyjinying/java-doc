### 映射器
一个映射器类就是一个仅需声明与 SqlSession 方法相匹配方法的接口。

#### 映射器注解
```java
 public interface MenuMapper {
//    @Results(value={
//            @Result(column = "id", property = "id", id = true),
//            @Result(column = "name", property = "name"),
//            @Result(column = "pid", property = "pid"),
//            @Result(property = "children", many=@Many(select="selByPid"), column = "{uid=uid,pid=id}")
//
//    })
//    @Select("select *,#{uid} uid from menu where id in (select mid from users_menu where uid=#{uid}) and pid=#{pid}")
//    List<Menu> selByPid(Map<String, Object> map);

    @Results(value={
            @Result(column = "id", property = "id", id = true),
            @Result(column = "parent_id", property = "parentId"),
            @Result(property = "children", many=@Many(select="selByPid"), column = "id")

    })
//    @Select("select id,name,parent_id from tb_category where parent_id=#{id}")
    @Select("select * from tb_category where parent_id=#{id}")
    List<Category> selByPid(int id);
}
```
- 注解 API 不支持联合映射。这是由于 Java 注解不允许产生循环引用。
- 在 MyBatis 3 中，我们提供了其它的配置方式。MyBatis 3 构建在全面且强大的基于 Java 语言的配置 API 之上。它是 XML 和注解配置的基础。注解提供了一种简单且低成本的方式来实现简单的映射语句
- 但最强大的 MyBatis 映射并不能用注解来构建
- @Results 
- - 一组结果映射，指定了对某个特定结果列，映射到某个属性或字段的方式。属性：value、id。value 属性是一个 Result 注解的数组。而 id 属性则是结果映射的名称。
- @Result
- - 在列和属性或字段之间的单个结果映射.
- - id、column、javaType、jdbcType、typeHandler、one、many
- - id boolean表示该属性是否用于唯一标识和比较对象
- - one 属性是一个关联
- - many 属性则是集合关联
- @Property 与pojo保持一致，指定参数值或占位符
- column="{自定义参数名=字段名,…}"

# 分页实现
## 一 limit
```java
    @Override
    public List<ExamRecord> getExamRecord(String columnValue, ExamRecord examRecord, Integer currentPage, Integer pageSize) {
        Integer cur = currentPage - 1;
        return examRecordMapper.getExamRecord(columnValue, examRecord, cur, pageSize);
    }
List<ExamRecord> getExamRecord(
           @Param("columnValue") String columnValue,
           @Param("exam") ExamRecord exam,
           @Param("currentPage") Integer currentPage,
           @Param("pageSize") Integer pageSize);
```
```xml
<select id="getExamRecord" resultMap="examResultMap">
        select
        <choose>
            <when test="columnValue!=null and columnValue!=''">
                ${columnValue}
            </when>
            <otherwise>
                *
            </otherwise>
        </choose>
        from exam_record
        <where>
            <if test="exam!=null and exam.uid!=null and exam.uid!=''">
                uid=#{exam.uid}
            </if>
            <if test="exam!=null and exam.examId!=null and exam.examId!=''">
                  AND exam_id like concat('%', #{exam.examId}, '%')
            </if>
        </where>
        limit ${currentPage},${pageSize}
    </select>
<resultMap id="examResultMap" type="com.example.domain.romtest.ExamRecord">
        <id property="id" column="id"></id>
        <result property="uid" column="uid"></result>
        <result property="examId" column="exam_id"></result>
        <result property="startTime" column="start_time"></result>
        <result property="submitTime" column="submit_time"></result>
        <result property="score" column="score"></result>
    </resultMap>
```
## 二 RowBounds分页
```java
@Override
    public List<ExamRecord> queryExamByPage(Integer currentPage, Integer pageSize) {

        return examRecordMapper.queryExamByPage(new RowBounds(currentPage - 1, pageSize));
    }
```
```xml
<select id="queryExamByPage" resultType="com.example.domain.romtest.ExamRecord">
        select * from exam_record
    </select>
```
## 三 PageHelper
```java
@Override
    public PageInfo<Brand> findAllUserByPage(int pageNum, int pageSize) {
        List<Brand> list = brandMapper.selectList(null);
        PageHelper.startPage(pageNum, pageSize);
        PageInfo<Brand> pageInfo = new PageInfo(list);

        return pageInfo;
    }
@Override
    public CommonPage<Brand> findBrandByPage(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Brand> list = brandMapper.selectList(null);
        CommonPage<Brand> brandList = CommonPage.restPage(list);
        return brandList;
    }
@ApiOperation("查询商品")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<CommonPage<PmsProduct>> getList(PmsProductQueryParam productQueryParam,
                                                        @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                        @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<PmsProduct> productList = productService.list(productQueryParam, pageSize, pageNum);
        return CommonResult.success(CommonPage.restPage(productList));
    }
```
