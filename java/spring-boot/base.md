# Spring Boot 的特点
1. 独立运行的 Spring 项目
Spring Boot 可以以 jar 包的形式独立运行，Spring Boot 项目只需通过命令“ java–jar xx.jar” 即可运行。
2. 内嵌 Servlet 容器
Spring Boot 使用嵌入式的 Servlet 容器（例如 Tomcat、Jetty 或者 Undertow 等），应用无需打成 WAR 包 。
3. 提供 starter 简化 Maven 配置
启动器包含许多依赖项，您需要这些依赖项来快速启动和运行项目，并使用一组一致的、受支持的托管可传递依赖项; 
启动器包含许多依赖项，您需要这些依赖项来快速启动和运行项目，并使用一组一致的、受支持的托管可传递依赖项
Spring Boot 提供了一系列的“starter”项目对象模型（POMS）来简化 Maven 配置。
1. 提供了大量的自动配置
Spring Boot 提供了大量的默认自动配置，来简化项目的开发，开发人员也通过配置文件修改默认配置。
1. 自带应用监控
Spring Boot 可以对正在运行的项目提供监控。
1. 无代码生成和 xml 配置
Spring Boot 不需要任何 xml 配置即可实现 Spring 的所有配置。

# starter
官方的，第三方的，生产的执行器（actuator），
spring-boot官方遵循特定的命名模式，;Spring-boot-starter -*，*是一个特定类型的应用程序。
第三方的明明启动类，例如：druid-spring-boot-starter，mybatis-plus-boot-starter
# 包命名使用反向域名
reversed domain name
主应用程序类在其他类之上的根包中;
@SpringBootApplication注释通常放在主类上，它隐式地为某些项定义了一个基本的“搜索包”。

# Spring Beans and Dependency Injection依赖注入
您可以自由地使用任何标准Spring Framework技术来定义bean及其注入的依赖项。我们经常发现使用@ComponentScan(查找bean)和使用@Autowired(进行构造函数注入)效果很好。 
 
如果您按照上面建议的方式构建代码(将应用程序类定位在根包中)，您可以添加@ComponentScan而不带任何参数。您的所有应用程序组件(@Component、@Service、@Repository、@Controller等)都会自动注册为Spring bean。
如果bean只有一个构造函数，您可以省略@Autowired，如下例所示:
```java
@Service
public class DatabaseAccountService implements AccountService {

    private final RiskAssessor riskAssessor;

    public DatabaseAccountService(RiskAssessor riskAssessor) {
        this.riskAssessor = riskAssessor;
    }
}
```

# actuctor
生产环境时监视和管理应用程序。您可以选择使用HTTP端点或JMX来管理和监视应用程序。审计、运行状况和指标收集也可以自动应用到应用程序。

## 端点
执行器端点：监视应用程序并与之交互。Spring Boot包括许多内置端点，并允许添加端点。例如；运行状况端点提供基本应用程序运行状况信息。 
 
可以通过HTTP或JMX启用或禁用每个端点并公开(使其可远程访问)。当一个端点被启用并公开时，它被认为是可用的。内置端点只有在可用时才会自动配置。大多数应用程序选择通过HTTP公开，其中端点的ID和前缀/actuator被映射到一个URL。例如，默认情况下，运行状况端点映射到/执行器/health。

# springboot原理
- spring原理
- springMVC原理
- 自动配置原理
- spring-boot原理
1.在SpringApplication.class中执行run方法，`创建SpringApplication应用`（参数传入的主配置类）；
保存一些信息；
判断当前的应用的类型；calssutils。Servlet
初始加载 启动器ApplicationContextInitializer（去spring.factory文件中的加载）；
初始化加载应用监听器加载ApplicationListener（去spring.factory文件中的加载）；
有main方法的类就是主程序类
运行SpringApplication
stopWatch
记录应用的启用时间
创建引导上下文，完成对引导器上下文环境的设置；
RunListener 运行监听器；方便所有的事件感知；
准备环境读取所有的环境源配置值， 
通知所有监听器的环境信息； 
创建IOC容器，根据项目类型创建容器，保存环境信息，IOC容器的后置处理流程，
applicationInitializer
应用初始化器；
- 遍历applicationInitializer
- 遍历listener
刷新IOC容器
- 创建容器中的所有组件（spring注解）
容器刷新后
通知所有的监听器started
调用所有监听器的running方法
有异常调用listeners.failed()的方法


```java
public static ConfigurableApplicationContext run(Class<?>[] primarySources, String[] args) {
    return (new SpringApplication(primarySources)).run(args);
    先调用一个参数的构造器，调用多个参数的构造器，
}

public SpringApplication(ResourceLoader resourceLoader, Class... primarySources) {
        this.sources = new LinkedHashSet();
        this.bannerMode = Mode.CONSOLE;
        this.logStartupInfo = true;
        this.addCommandLineProperties = true;
        this.addConversionService = true;
        this.headless = true;
        this.registerShutdownHook = true;
        this.additionalProfiles = new HashSet();
        this.isCustomEnvironment = false;
        this.lazyInitialization = false;
        this.resourceLoader = resourceLoader;
        Assert.notNull(primarySources, "PrimarySources must not be null");
        this.primarySources = new LinkedHashSet(Arrays.asList(primarySources));
        this.webApplicationType = WebApplicationType.deduceFromClasspath();
        this.setInitializers(this.getSpringFactoriesInstances(ApplicationContextInitializer.class));
        this.setListeners(this.getSpringFactoriesInstances(ApplicationListener.class));
        this.mainApplicationClass = this.deduceMainApplicationClass();
    }

    将主配置类（this.primarySources）保存起来，接着判断是否是响应式编程，还是sevelet;

    private <T> Collection<T> getSpringFactoriesInstances(Class<T> type, Class<?>[] parameterTypes, Object... args) {
        ClassLoader classLoader = this.getClassLoader();
        Set<String> names = new LinkedHashSet(SpringFactoriesLoader.loadFactoryNames(type, classLoader));
        List<T> instances = this.createSpringFactoriesInstances(type, parameterTypes, classLoader, args, names);
        AnnotationAwareOrderComparator.sort(instances);
        return instances;
    }

    类加载器，加载spring.factory文件中的配置；

```
2.
# @SpringBootApplication注释可以用来启用这三个特性
 
- @EnableAutoConfiguration: 自动配置机制 
- @ComponentScan: 组件扫描 
- @SpringBootConfiguration: 注册额外的bean或导入额外的配置类。Spring标准@Configuration的替代方案，帮助集成测试中检测配置。

# 大多数ide都可以直接导入Maven项目

# mvn dependency:tree 查看依赖树
# 修改默认配置
- SpringBoot 默认使用以下 2 种全局的配置文件
- application.properties
- application.yml
- 可以在 Spring Boot 启动时被自动读取，修改 Spring Boot 自动配置的默认值

# YAML 
全称 YAML Ain't Markup Language，它是一种以数据为中心的标记语言，比 XML 和 JSON 更适合作为配置文件。

YAML 的语法如下：
使用缩进表示层级关系。
缩进时不允许使用 Tab 键，只允许使用空格。
缩进的空格数不重要，但同级元素必须左侧对齐。
大小写敏感。
```yml
person: 
    name: zhaojinying
nPerson:
    a: ${person}/aa # yaml文件中如何做引用变量 
    b: "${person}/aa \t1 \t2" # 字符转译

```

# java读取配置文件（三种方法)
方法一：
- @Value('${person.name}') // list[0].name
方法二：
- 使用Environment对象封装全部配置信息
- 使用@Autowired 自动装配到Environment对象中
```java
@Autowired
private Environment env;

env.getProperty("person.name");

```
方法三：
- 自定义yml数据；
- spring中定义数据模型；
- 申明bean对象，定义为spring管理的bean， 否则无法进行属性注入，指定数据涞源
- @Component\@ConfigurationProperties(prefix="dataSource")

# spring整合junit
- @SpringBootTest
  @SpringBootTest(classes = ShiroDemoApplication.class)
- 设置junit的springboot启动类
- @Autowired 注入bean对象（@Component）
- @Test
  junit.jupiter(junit5而非junit4)
- @Transactional事务的自动回滚
- 执行bean对象方法
  注意：
  1.测试类如果存在于引导类所在包或子包中无需指定引导类；
  2.测试类如果不在引导类所在的包或者子包中需要通过classs属性指定引导类；
```java
@SpringBootTest(classes=ZhaoApplication.class)
class ZhaoApplicationTests {

    @Autowired
    BookDao bookDao;

    @Test
    void contextLoads() {
        bookDao.see();
    }

}

```
# druid
# lombok
# mybatis-plus
- 分页如何使用；
- 查询条件如何使用；
```yml
## 配置mybatis-plus的表前缀和字段转换，mp的日志打印等；
spring:
  datasource:
    druid:
      driver-class-name: com.mysql.cj.jdbc.Driver
      url: jdbc:mysql://localhost:3306/aaa
      username: root
      password: 123456
mybatis-plus:
  global-config:
    db-config:
      table-prefix: t_
  configuration:
    map-underscore-to-camel-case: false # 数据库中的字段驼峰法命名和实体类中的驼峰法命名相冲突
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl

```

# spring-boot的yml多环境的配置文件的优先级
- 最高， 整个项目的config文件夹下
- 第二， 整个的项目的根路径下
- 第三， resource的文件下的config文件夹
- 第四， resource文件下
# 多环境配置
```xml
<!--多环境配置-->
    <profiles>
        <profile>
            <!-- 本地开发环境 -->
            <id>dev</id>
            <properties>
                <profileActive>dev</profileActive>
            </properties>
        </profile>
        <profile>
            <id>test</id>
            <properties>
                <profileActive>test</profileActive>
            </properties>
        </profile>
        <profile>
            <id>prod</id>
            <properties>
                <profileActive>prod</profileActive>
            </properties>
            <!-- 默认开启这个配置 -->
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
        </profile>
    </profiles>
```
![application.yml]("./imgs/2.png")
```yml
spring:
  profiles:
    active: @profileActive@ # 如果报异常是maven依赖错误，需要重新执行package
```

# 宽松绑定
- @configurationProperties支持属性名宽松绑定
- 驼峰模式、下划线模式、中划线模式、常量模式。
  
# 常用计量单位
- @DurationUnit(ChronoUnit.MINUTES)
- @DataSizeUnit(DataUnit.MEGABYTES)
- 


