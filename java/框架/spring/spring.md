# 什么是spring?
- Spring框架为现代java的企业应用程序提供了一个`全面的编程`和`配置模型—`—适用于任何类型的部署平台。
- 应用程序级的基础设施支持
- Spring让编程人员专注于应用程序的业务逻辑，而不需要关注部署环境

# springIOc容器
- IoC：依赖注入(DI)：
`在这个过程中，对象仅通过构造函数参数、工厂方法的参数或在构造或从工厂方法返回对象实例后在对象实例上设置的属性来定义它们的依赖关系(即与它们一起工作的其他对象)。然后容器在创建bean时注入这些依赖项。这个过程基本上是bean本身的逆过程(因此得名，控制反转)，通过使用类的直接构造或Service Locator模式等机制来控制其依赖项的实例化或位置。`

# 容器
容器可以实例化对象、组装对象和管理对象的声明周期和依赖关系；

# pojo(plain old java object)
- 简单的java对象，
- 没有继承任何类，没有实现任何接口，没有被侵入，没有业务方法；

# javaBean
- 是一种java语言编写的可重用的组件。符合一定的java类规范，是一种规范。
- 规范的约定有： 
- 有无参数的构造器（因为通常JavaBean是由容器所创建的，所以要有无参构造器）;
- 所有的属性都是private的;
- 通过提供setter和getter方法来实现对成员属性的访问
- 这个类应是可序列化的serialisable：用于Bean的持久化

# pojo与javaBean
EJB（Enterprise JavaBean 企业JavaBean进行区分
POJO比较纯净；
JavaBean比较复杂，是可复用组件，没有明确的规范，任何一个Java类都可以是一个Bean。
由spring负责实例化和销毁的对象；

# springBean
Spring bean是Spring框架在运行时管理的对象。
Spring应用程序的`基本构建块`；
应用程序逻辑代码都将放在Spring bean中;

# Entity Bean
- 可以代表数据库中的一行记录，多个客户端应用能够以共享方式访问表示该数据库记录的Entity Bean;
- 持久数据组件指的是这样一种对象，它们知道如何将自身放入持久存储的空间中。它们使用一些持久机制，比如序列化、O/R映射。

# 
- spring-beans和spring-context包是Spring框架IoC容器的基础;
- BeanFactory接口提供了一种高级配置机制，能够管理任何类型的对象。ApplicationContext是BeanFactory的子接口;
它补:
- 更容易与Spring的AOP特性集成 
- 消息资源处理(用于国际化)  
- 事件发布 
- 应用程序层特定的上下文，例如用于web应用程序的WebApplicationContext。
BeanFactory提供了配置框架和基本功能，而ApplicationContext添加了更多特定于企业的功能。ApplicationContext是BeanFactory的一个完整的超集，在本章中专门用于描述Spring的IoC容器。

# bean
构成应用程序主干并由Spring IoC容器管理的对象称为bean;
bean是由Spring IoC容器实例化、组装和管理的对象。
bean以及它们之间的依赖关系反映在容器使用的配置元数据中。

applicationcontext接口表示Spring IoC容器，并负责实例化、配置和组装bean。容器通过读取`配置元数据`来获得关于实例化、配置和组装哪些对象的指令。配置元数据以XML、Java注释或Java代码表示。它允许您表达组成应用程序的对象以及这些对象之间丰富的相互依赖关系。

元数据和手动提供的单例实例需要尽可能早地注册，以便容器在自动装配和其他自检步骤期间正确地推断它们。虽然在某种程度上支持覆盖现有元数据和现有单例实例，但在运行时注册新bean(与对工厂的实时访问同时进行)不受支持，可能导致并发访问异常、或者状态不一致;

# bean name
每个bean都有一个或多个标识符。这些标识符在承载bean的容器中必须是唯一的;
您不需要为bean提供名称或id。如果您没有显式地提供名称或id，容器将为该bean生成唯一的名称。
Bean命名约定 :使用标准Java约定的实例字段名, 以小写字母开头，并从那里开始采用驼峰式大小写。

Spring未命名的组件bean名称: 采用简单的类名，并将其初始字符改为小写;可以通过@Bean注释提供别名;

# 实例化bean
在容器本身通过反射地调用其构造函数直接创建bean的情况下指定要构造的bean类，这有点相当于使用new操作符的Java代码。
## 构造函数进行实例化
```xml
<bean id="exampleBean" class="examples.ExampleBean"/>
```
## 静态工厂方法实例化
```java
public class ClientService {
    private static ClientService clientService = new ClientService();
    private ClientService() {}

    public static ClientService createInstance() {
        return clientService;
    }
}
```
```xml
<bean id="clientService"
    class="examples.ClientService"
    factory-method="createInstance"/>
```
## 实例工厂方法进行实例化

# 容器
您的应用程序类与配置元数据相结合，这样在创建并初始化ApplicationContext之后，您就有了一个完全配置的可执行系统或应用程序。
Spring IoC容器使用一种形式的配置元数据，开始实例化、配置和组装应用程序中的对象。

配置元数据通常以简单直观的XML格式提供
基于xml的配置元数据将这些bean配置为顶级<beans/>元素中的<bean/>元素。Java配置通常在@Configuration类中使用带@ bean注释的方法。

这些bean定义对应于构成应用程序的实际对象。通常，您将定义服务层对象、持久化层对象(如存储库或数据访问对象)、表示对象(如Web控制器)、基础结构对象(如JPA EntityManagerFactory)、JMS队列等等。通常，不会在容器中配置细粒度的域对象，因为创建和加载域对象通常是存储库和业务逻辑的责任。

id属性是标识单个bean定义的字符串。
class属性定义bean的类型，并使用完全限定的类名。
# 配置元数据

# 控制反转
我们可以自己new对象，东一个西一个，会造成混乱，而且还要处理单例模式，所以我们不手动做这件事，交给容器来控制；但根据哪些规范规则来管理，就出现了配置元数据。

# Dependency injection (DI)
依赖注入(DI)是一个过程，在这个过程中，对象仅通过构造函数参数、工厂方法的参数或在构造或从工厂方法返回对象实例后在对象实例上设置的属性来定义它们的依赖关系(即与它们一起工作的其他对象)。然后容器在创建bean时注入这些依赖项。这个过程本质上是bean本身通过直接构造类或Service Locator模式控制其依赖项的实例化或位置的逆过程(因此称为控制反转)。

解耦

大白话：
C 依赖 A ，A依赖B；

先实例化C,发现需要A，在实例化A，发现需要B；在实例化B；
这个过程就是依赖注入；他跟我们手动依赖的顺序是相反的，所以又叫控制反转；


`依赖注入有两种主要形式`:基于构造函数的依赖注入和基于setter的依赖注入；
对于强制性依赖项使用构造函数，对于可选依赖项使用setter方法或配置方法是一个很好的经验法则

实际创建bean时才设置bean属性；

dependencies属性既可以指定初始化时依赖项，也可以指定对应的销毁时依赖项(仅在单例bean的情况下)。与给定bean定义依赖关系的依赖bean首先被销毁，然后再销毁给定bean本身。因此，依赖也可以控制关机顺序。

# 循环依赖：
如果一个bean是另一个bean的依赖项，这通常意味着一个bean被设置为另一个bean的属性。
构造函数依赖注入会造成循环依赖，setter方式的依赖注入可以解决；
类A通过构造函数注入类B，类B通过构造函数注入类A；抛出BeanCurrentlyInCreationException；

在容器加载时检测配置问题，例如对不存在的bean的引用和循环依赖
`惰性初始化单例bean，还是预实例化单例bean`

使用p-命名空间的XML快捷方式
使用c-命名空间的XML快捷方式
复合属性名

延迟初始化的beans：
意思是IoC容器在第一次请求时创建bean实例，不是在启动时；
当惰性初始化bean是未惰性初始化的单例bean的依赖项时，ApplicationContext在启动时创建惰性初始化bean，因为它必须满足单例的依赖项

# ref
被引用的bean是要设置其属性的bean的依赖项，并且在设置属性之前根据需要对其进行初始化。

# 内部Beans
内部bean定义不需要定义的ID或名称。如果指定了，容器不会使用这样的值作为标识符。容器在创建时也会忽略作用域标志，因为内部bean总是匿名的，并且总是与外部bean一起创建。不可能独立地访问内部bean，也不可能将它们注入协作bean(而不是封闭bean)。内部bean通常只是共享其包含bean的作用域。

# autowired自动装配
- 自动装配可以显著减少指定属性或构造函数参数的需要；
- 自动装配可以随着对象的演变而更新配置；
- no
- byName：通过属性名自动装配。Spring寻找与需要自动连接的属性具有相同名称的bean；
- byType
- constructor：类似于byType，但适用于构造函数参数；

# 自动装配的局限性和缺点
- 属性和构造函数参数设置中的`显式依赖总是覆盖自动装配`。您`不能自动装配简单的属性`，如原语、字符串和类(以及这些简单属性的数组)。这种限制是设计出来的。 
- 自动装配`不如显式连接准确`。尽管如前面的表中所指出的，Spring小心地避免猜测，以免出现可能产生意外结果的歧义。spring管理对象之间的关系不再显式地记录。 
- `连接信息对于可能从Spring容器生成文档的工具来说可能不可用`。 
容器内的多个bean定义可能与setter方法或构造函数参数指定的类型匹配。对于数组、集合或Map实例，这并不一定是个问题。然而，对于需要单个值的依赖项，这种模糊性不会被任意解决。如果没有可用的惟一bean定义，则抛出异常。

autowire-candidate属性被设计为仅影响基于类型的自动装配。它不会影响按名称的显式引用，即使指定的bean没有被标记为自动装配候选对象，引用也会被解析。因此，根据名称自动装配仍然会在名称匹配时注入bean。

# 基于注解的容器配置
Annotation-based Container Configuration
每种方法都有其优缺点，通常由开发人员决定哪种策略更适合他们。由于它们的定义方式，注释在它们的声明中提供了大量上下文，从而导致更短、更简洁的配置。但是，XML擅长在不涉及源代码或重新编译的情况下将组件连接起来。一些开发人员更喜欢让连接靠近源代码，而另一些开发人员则认为带注释的类不再是pojo，而且，配置变得分散且更难控制。
基于注释的配置提供了XML设置的替代方案，它依赖于字节码元数据来连接组件，而不是尖括号声明。开发人员不使用XML描述bean连接，而是通过在相关类、方法或字段声明上使用注释将配置移动到组件类本身

注释注入在XML注入之前执行。因此，XML配置将覆盖通过这两种方法连接的属性的注释。
 non-invasive way: 非侵入式

 # merge属性必须在较低的继承的子定义上指定。

 # p命名空间的简写
 <property name="spouse" ref="jane"/>
 p:spouse-ref="jane"

 # @Autowired
 - 构造函数
 - setter方法
 - 任意名称和参数的方法
 - 字段

默认行为是将带注释的方法和字段视为所需依赖项的方法和字段；
@Autowired(required = false)
非必需：不能满足注入点标记则跳过，对于自动连接目的是可选的，如果不能自动连接，则将忽略该属性

任何给定bean类中只有一个构造函数可以声明@Autowired，并将所需属性设置为true，这表明该构造函数在用作Spring bean时将自动连接。如果多个构造函数声明注释，它们都必须声明required=false，以便被视为自动装配的候选者(类似于XML中的autowire=constructor)；
```java
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Autowired(required = false)
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // ...
}
```

@Autowired、@Inject、@Value和@Resource注解由Spring BeanPostProcessor实现处理。这意味着您不能在自己的BeanPostProcessor或BeanFactoryPostProcessor类型(如果有的话)中应用这些注释


# 
容器只创建一次单例bean A，因此只有一次设置属性的机会。容器不能在每次需要时都为bean A提供bean B的新实例。
假设单例bean A需要使用非单例(原型)bean B，可能是在A上的每次方法调用上

解决方法：一个解决办法是放弃某些控制反转。您可以通过实现ApplicationContextAware接口，以及在bean A每次需要bean B实例时调用容器的getBean(“B”)来让bean A知道容器。

单例bean和作为原型部署的有状态bean(非单例)
```xml
<!--被依赖后，prototype返回的实例都是不一样的（非单例）-->
    <bean id="myCommand" class="com.zjy.methodinjection.Command" scope="prototype">
    </bean>

    <bean class="com.zjy.methodinjection.CommandAbstractManager">
        <lookup-method name="createCommand" bean="myCommand"/>
    </bean>
```
# Bean Scopes
- singleton: Spring IoC容器的单个对象实例
- phototype: 任意数量的对象实例
- request: 在单个HTTP请求的生命周期内,每个HTTP请求都有自己的bean实例(是在单个bean定义的基础上创建的)。仅在web感知Spring ApplicationContext的上下文中有效。
- session: 在HTTP会话的生命周期内。仅在web感知Spring ApplicationContext的上下文中有效。
- application: 作用于ServletContext的生命周期。仅在web感知Spring ApplicationContext的上下文中有效。
- websocket: 作用于WebSocket的生命周期。仅在web感知Spring ApplicationContext的上下文中有效。

# 单例作用域 the singleton scope
Spring IoC容器只创建该bean定义的对象的一个实例,并存储在此类单例bean的缓存中，对该命名bean的所有后续请求和引用都返回缓存的对象；
单个Spring容器中的特定类定义了一个bean，Spring容器且仅一个实例
单例作用域是Spring中的默认作用域

# 原型作用域 the phototype scope
每次对特定bean发出请求时都会创建一个新的bean实例。
对所有有状态bean使用原型作用域，而对无状态bean使用单例作用域
bean被注入到另一个bean中,可以通过容器上的getBean()方法调用请求它；

与其他作用域相比，Spring不管理原型bean的完整生命周期。容器实例化、配置并以其他方式组装一个原型对象，并将其交给客户端，不再记录该原型实例。因此，尽管初始化生命周期回调方法在所有对象上都被调用，无论其作用域如何，但在原型的情况下，`配置的销毁生命周期回调不会被调用`。客户端代码必须清理原型作用域的对象，并释放原型bean所拥有的昂贵资源。要让Spring容器释放原型作用域bean所拥有的资源，请尝试使用自定义bean后处理器，它包含需要清理的bean的引用。

希望单例作用域bean在运行时反复获取原型作用域bean的新实例。您不能将原型作用域bean的依赖项注入到单例bean中；可以采用方法注入；

# Web初始配置
DispatcherServlet、RequestContextListener和RequestContextFilter都做完全相同的事情，即将HTTP请求对象绑定到为该请求提供服务的线程。这使得请求范围和会话范围的bean在调用链的更下方可用。

# request scope
作用域是HTTP请求级别
```java
@RequestScope
@Component
public class LoginAction {
    // ...
}
```
# Session Scope
单个HTTP会话的生命周期中使用UserPreferences bean定义来创建UserPreferences bean的新实例
```java
@SessionScope
@Component
public class UserPreferences {
    // ...
}
```
# Application Scope
在ServletContext级别，并存储为常规的ServletContext属性。
但有两个重要的不同之处:它是每个ServletContext的单例bean，而不是每个Spring ApplicationContext的单例bean

# WebSocket Scope
WebSocket作用域与WebSocket会话的生命周期相关联，适用于WebSocket应用程序上的STOMP

# 将bean限定为依赖项
Spring IoC容器不仅管理对象(bean)的实例化，还管理协作者(或依赖项)的连接。如果您想将(例如)一个HTTP请求范围的bean注入到另一个存在时间较长的范围的bean中，您可以选择注入一个AOP代理来代替这个范围bean。也就是说，您需要注入一个代理对象，该对象公开与作用域对象相同的公共接口，但也可以从相关作用域(例如HTTP请求)检索真实目标对象，并将方法调用委托给真实对象。

# 定制bean的性质
- 生命周期回调
- ApplicationContextAware和BeanNameAware
- Other Aware Interfaces 其他感知接口

为了与容器对bean生命周期的管理进行交互，您可以实现Spring InitializingBean和DisposableBean接口。容器为前者调用afterPropertiesSet()，为后者调用destroy()，以便在初始化和销毁bean时让bean执行某些操作。

解决bean耦合到spring特定的接口
@PostConstruct and @PreDestroy annotations
init-method and destroy-method bean definition metadata.

# 默认初始化和销毁方法


# 控制bean生命周期行为
- InitializingBean和DisposableBean回调接口 
- 自定义init()和destroy()方法 
- @PostConstruct和@PreDestroy注释。您可以组合这些机制来控制给定的bean。

# 为同一个bean配置的多个生命周期机制，使用不同的初始化方法，调用如下: 
用@PostConstruct注释的方法 
由InitializingBean回调接口定义的afterPropertiesSet() 
自定义配置的init()方法 
Destroy方法的调用顺序相同: 
用@PreDestroy注释的方法 
destroy()由DisposableBean回调接口定义 
自定义配置destroy()方法

ApplicationContext的其他方法提供了对文件资源的访问、发布应用程序事件和访问MessageSource


BeanNameAware: 该回调在填充普通bean属性之后调用，但在初始化回调(如InitializingBean.afterPropertiesSet()或自定义初始化方法之前调用。


容器的内部preInstantiateSingletons()方法会忽略定义为抽象bean;
数据访问对象(DAO)是singleton scope

@Autowired基本上是关于带有可选语义限定符的类型驱动注入。
@Resource注释，该注释在语义上定义为通过唯一名称标识特定的目标组件，声明的类型与匹配过程无关

# @Autowired
- @Autowired基于类型选择，如果有多个的时候，Qualifier注解进行区别；
- @Primary 选择指定的bean自动注入
- @Qualifier("main")  选择指定的bean自动注入
- @Resource(name="cat") 根据name注入，如果没有，就采用类型注入


# 要自动连接的字段使用`自定义限定符`进行注释
```java
@Autowired
@MovieQualifier(format=Format.VHS, genre="Comedy")
private MovieCatalog comedyVhsCatalog;
```

# @Resource
```java
// 解析众所周知的可解析依赖项:BeanFactory、ApplicationContext、ResourceLoader、ApplicationEventPublisher和MessageSource接口。
@Resource
private CustomerPreferenceDao customerPreferenceDao;

// 首先查找名为“customerPreferenceDao”的bean，然后回落到类型customerPreferenceDao的主类型匹配:
@Resource
private ApplicationContext context; 
```
# 容器启动过程
```java
@Override
	public void refresh() throws BeansException, IllegalStateException {
		synchronized (this.startupShutdownMonitor) {
			StartupStep contextRefresh = this.applicationStartup.start("spring.context.refresh");

			// Prepare this context for refreshing.
            // 为刷新准备这个上下文。
			prepareRefresh();

			// Tell the subclass to refresh the internal bean factory.
            // 告诉子类刷新内部bean工厂。
			ConfigurableListableBeanFactory beanFactory = obtainFreshBeanFactory();

			// Prepare the bean factory for use in this context.
            // 准备在此上下文中使用的bean工厂。
			prepareBeanFactory(beanFactory);

			try {
				// Allows post-processing of the bean factory in context subclasses.
                // 允许在上下文子类中对bean工厂进行后处理。
				postProcessBeanFactory(beanFactory);

				StartupStep beanPostProcess = this.applicationStartup.start("spring.context.beans.post-process");
				// Invoke factory processors registered as beans in the context.
                // 调用上下文中注册为bean的工厂处理器。
				invokeBeanFactoryPostProcessors(beanFactory);

				// Register bean processors that intercept bean creation.
				registerBeanPostProcessors(beanFactory);
				beanPostProcess.end();

				// Initialize message source for this context.
				initMessageSource();

				// Initialize event multicaster for this context.
				initApplicationEventMulticaster();

				// Initialize other special beans in specific context subclasses.
				onRefresh();

				// Check for listener beans and register them.
				registerListeners();

				// Instantiate all remaining (non-lazy-init) singletons.
				finishBeanFactoryInitialization(beanFactory);

				// Last step: publish corresponding event.
				finishRefresh();
			}

			catch (BeansException ex) {
				if (logger.isWarnEnabled()) {
					logger.warn("Exception encountered during context initialization - " +
							"cancelling refresh attempt: " + ex);
				}

				// Destroy already created singletons to avoid dangling resources.
				destroyBeans();

				// Reset 'active' flag.
				cancelRefresh(ex);

				// Propagate exception to caller.
				throw ex;
			}

			finally {
				// Reset common introspection caches in Spring's core, since we
				// might not ever need metadata for singleton beans anymore...
				resetCommonCaches();
				contextRefresh.end();
			}
		}
	}
```
# @Value通常用于注入外部化属性:


注释包在JDK 9中从核心Java模块中分离出来，最终在JDK 11中被移除

# 原型注释:@Component、@Service和@Controller
@Component是任何spring管理组件的通用原型
@Repository、@Service和@Controller是@Component的专门化，用于更具体的用例(分别在持久层、服务层和表示层)。

@Repository已经被支持作为持久层中自动异常转换的标记。

# 使用元注释和组合注释

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component 
public @interface Service {

    // ...
}
```
@RestController注释由@Controller和@ResponseBody组成

Spring可以`自动检测构造型类`，并在`ApplicationContext中注册相应的BeanDefinition实例`
```java
@Service
public class SimpleMovieLister {

    // 容器中存在的bean
    private MovieFinder movieFinder;

    public SimpleMovieLister(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // @Autowired
    // private MovieFinder movieFinder;

    public void say(){

        movieFinder.setAge(12);
        movieFinder.setName("zhaozhao");

        String s = movieFinder.toString();
        System.out.println(s);
    }
}

@Component
public class MovieFinder {
    private String name;
    private Integer age;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public MovieFinder() {
    }

    public MovieFinder(String name, Integer age) {
        this.name =name;
        this.age =age;
    }

    @Override
    public String toString() {
        return "MovieFinder{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
```

常规Spring组件中的@Bean方法与Spring @Configuration类中的@Bean方法处理方式不同。区别在于，没有使用CGLIB增强@Component类来拦截方法和字段的调用。CGLIB代理是通过调用@Configuration类中的@Bean方法中的方法或字段来创建对协作对象的bean元数据引用的方法。这样的方法不是用正常的Java语义调用的，而是通过容器来提供Spring bean的常规生命周期管理和代理，即使是在通过编程调用@Bean方法引用其他bean时也是如此。相反，在普通的@Component类中调用@Bean方法中的方法或字段具有标准的Java语义，不应用特殊的CGLIB处理或其他约束。

默认bean名称生成器将返回未大写的非限定类名。
您可以在@ configuration注释类或@ component注释类中使用@Bean注释

结构简单 
与实例化ClassPathXmlApplicationContext时使用Spring XML文件作为输入的方式大致相同，您可以在实例化AnnotationConfigApplicationContext时使用@Configuration类作为输入。这允许完全不使用xml的Spring容器，

# @Bean在@Configuration、@Component中的区别
这种声明bean间依赖关系的方法只有在@Configuration类中声明@Bean方法时才有效。您不能使用普通的@Component类来声明bean之间的依赖关系。
lite模式(普通的工厂模式生成的bean)和full模式

# 查找方法注入 
如前所述，查找方法注入是一种高级特性，应该很少使用。它在单作用域bean依赖于原型作用域bean的情况下非常有用。

# CGLIB的子类
所有@Configuration类在启动时都是CGLIB的子类。在子类中，子方法在调用父方法并创建一个新实例之前，首先检查容器中是否有任何缓存的(作用域)bean。

@Configuration类最终只是容器中的另一个bean:这意味着它们可以像任何其他bean一样利用@Autowired和@Value injection以及其他特性。

# 对于一个通用的standardservletenvirenvironment，完整的层次结构如下所示，最高优先级的条目位于顶部: 
ServletConfig参数(如果适用——例如，在DispatcherServlet上下文的情况下) 
ServletContext参数(web.xml上下文参数条目) 
JNDI环境变量(java:comp/env/ entries) 
JVM系统属性(-D命令行参数) 
JVM系统环境(操作系统环境变量)

# Bean definition profiles
允许在不同环境注册不同的Bean


# Resource
Java的标准java.net.URL类和各种URL前缀的标准处理程序还不足以满足对所有低级资源的访问;
Resource接口在Spring和Spring中被大量使用
用实用程序类
资源抽象不能取代功能。它尽可能地包装它。例如，UrlResource包装一个URL，并使用包装的URL来完成它的工作

Spring包括几个内置的资源实现: 
UrlResource 
UrlResource包装了一个java.net.URL，可用于访问通常可以通过URL访问的任何对象，如文件、HTTPS目标、FTP目标等
路径字符串包含一个众所周知的(对属性编辑器来说)前缀(例如classpath:)，它将为该前缀创建一个适当的专门化资源；
如果它不识别前缀，则假定该字符串是标准URL字符串并创建UrlResource；

ClassPathResource 
该类表示应该从类路径获得的资源
JavaBeans PropertyEditor识别字符串路径上的特殊前缀classpath:，并在这种情况下创建ClassPathResource；

FileSystemResource 
这是java.io.File句柄的Resource实现
支持文件解析和URL解析；

PathResource 
是一个纯粹的基于java.nio.path.Path的FileSystemResource替代品
ServletContextResource 
这是ServletContext资源的Resource实现，用于解释相关web应用程序根目录中的相对路径。
InputStreamResource 
InputStreamResource是给定InputStream的资源实现
ByteArrayResource
这是给定字节数组的Resource实现。它为给定的字节数组创建一个ByteArrayInputStream。

# ResourceLoader
所有应用程序上下文实现ResourceLoader接口。因此，所有应用程序上下文都可以用于获取Resource实例。
会为每个上下文返回适当的对象。（ServletContextResource，FileSystemResource）
可以通过指定任何标准java.net.URL前缀来强制使用UrlResource。使用文件和https前缀的示例如下:
```java
Resource template = ctx.getResource("file:///some/resource/path/myTemplate.txt");
Resource template = ctx.getResource("https://myhost.com/resource/path/myTemplate.txt");
```
classpath:
classpath:com/myapp/config.xml
file:
file:///data/config.xml
https:
https://myserver/logo.png
/data/config.xml：
取决于底层的ApplicationContext。

# ResourcePatternResolver
Ant-style路径模式解析为资源对象
```java
PathMatchingResourcePatternResolver resourcePatternResolver = new PathMatchingResourcePatternResolver();
        Resource[] resources = resourcePatternResolver.getResources(mapperLocations);
        sqlSessionFactoryBean.setMapperLocations(resources);
```

# classpath*: 
classpath*:/config/beans.xml

您还可以依赖于ResourceLoader的自动装配，作为实现ResourceLoaderAware接口的替代方案。

资源路径没有前缀，根据应用程序上下文的确切类型；
如果需要强制使用特定的资源类型，可以使用前缀
```java
@Component
public class MyBean {

    private final Resource template;

    public MyBean(@Value("${template.path}") Resource template) {
        this.template = template;
    }

    // ...
}
```
# Ant-style Patterns
/WEB-INF/*-context.xml
com/mycompany/**/applicationContext.xml
file:C:/some/path/*-context.xml
classpath:com/mycompany/**/applicationContext.xml

通配符类路径依赖于底层ClassLoader的getResources()方法

相对路径相对于当前工作目录，而绝对路径相对于文件系统的根目录

# 使用Spring的Validator接口进行验证 
Spring提供了一个Validator接口，您可以使用它来验证对象。Validator接口通过使用Errors对象工作，以便在验证时，验证器可以向Errors对象报告验证失败。

#  @DateTimeFormat 
用于格式化java.util.Date, java.util.Calendar, Long (for millisecond timestamps)毫秒时间戳
```java
@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
@DateTimeFormat(pattern = "yyyy-MM-dd")
// “yyyy-MM-dd HH:mm:ss”时，需要使用java.util.Date的时间类
private java.util.Date birthday;

/**
 * Style.CURRENCY：货币类型
 * Style.NUMBER：正常数字类型
 * Style.PERCENT：百分比类型
 */
@NumberFormat(style=Style.NUMBER,pattern="#,###")    
private int total;

@NumberFormat(style=Style.PERCENT)
private double discount;

@NumberFormat(style=Style.CURRENCY)
private double money;
```

# Bean Validation

# spEl
1个实例的T(int)计算结果为false，而1个实例的T(Integer)计算结果为true

## 符号运算符与纯字母等价
- lt (<)
- gt (>)
- le (<=)
- ge (>=)
- eq (==)
- ne (!=)
- div (/)
- mod (%)
- not (!)
`文本操作符都不区分大小写`

# Logical Operators 逻辑运算
- and (&&)
- or (||)
- not (!)
# 数学运算符 Mathematical Operators
数字和字符串上使用加法运算符(+)。只能在数字上使用减法(-)、乘法(*)和除法(/)运算符。你也可以在数字上使用模(%)和指数幂(^)运算符

# Elvis Operators 
是三元运算符的简写
city?:'Unknown'
# Safe Navigation Operator 安全导航运算符
placeOfBirth?.city

.?[selectionExpression] 满足条件的集合
.^[selectionExpression] 第一个
.$[selectionExpression] 最后一个
投影表达式
 .![projectionExpression]

 # 面向方面编程(AOP)
 Spring的关键组件之一是AOP框架；
 通过提供另一种思考程序结构的方式来补充面向对象编程(OOP)；
 OOP中模块化的关键单位是类，在AOP中模块化的关键单位是aspect。
 支持跨越多个类型和对象的关注点(例如事务管理)的模块化；

 AOP概念 
让我们从定义一些`核心的AOP概念`和`术语`开始。这些术语不是spring特有的。不幸的是，AOP术语不是特别直观。但是，如果Spring使用自己的术语，那就更令人困惑了。 
 
切面:跨越多个类的关注点的模块化。事务管理是企业Java应用程序中横切关注点的一个很好的例子。在Spring AOP中，方面是通过使用常规类(基于模式的方法)或使用@Aspect注释(@AspectJ风格)注释的常规类实现的。 
 
连接点:程序执行期间的一个点，例如方法的执行或异常的处理。在Spring AOP中，一个连接点总是代表一个方法执行。 
 
通知:切面在特定连接点上采取的操作。不同类型的建议包括“前后”、“之前”和“之后”的建议。(通知类型将在后面讨论。)许多AOP框架，包括Spring，都将通知建模为一个拦截器，并围绕连接点维护一个拦截器链。 
 
切入点:匹配连接点的断言。通知与切入点表达式相关联，并在与切入点匹配的任何连接点上运行(例如，具有特定名称的方法的执行)。由切入点表达式匹配的连接点的概念是AOP的核心，Spring默认使用AspectJ切入点表达式语言。 
 
引入:代表一个类型声明额外的方法或字段。Spring AOP允许您向任何被通知的对象引入新的接口(以及相应的实现)。例如，您可以使用介绍使bean实现IsModified接口，以简化缓存。(在AspectJ社区中，引入被称为类型间声明。) 
 
目标对象:由一个或多个切面通知的对象。也被称为“通知对象”。因为Spring AOP是通过使用运行时代理实现的，所以这个对象始终是一个代理对象。 
 
AOP代理:AOP框架为了实现代理对象。在Spring框架中，AOP代理是JDK动态代理或CGLIB代理。 
  
织入:将切面与其他应用程序类型或对象连接起来，以创建通知的对象。这可以在编译时(例如，使用AspectJ编译器)、加载时或运行时完成。与其他纯Java AOP框架一样，Spring AOP在运行时执行编织。


Spring框架的AOP功能通常与Spring IoC容器一起使用
Spring AOP目前只支持方法执行连接点(建议在Spring bean上执行方法)；
Spring AOP是用纯Java实现的。不需要特殊的编译过程
Spring AOP从不与AspectJ竞争以提供全面的AOP解决方案

# AOP代理 
Spring AOP默认为AOP代理使用标准JDK动态代理。这使得任何接口(或一组接口)都可以被代理。 
 
Spring AOP也可以使用CGLIB代理。这对于代理类而不是接口是必要的。默认情况下，如果业务对象没有实现接口，则使用CGLIB。由于针对接口而不是类编程是一种良好的实践，业务类通常实现一个或多个业务接口。强制使用CGLIB是可能的，在这些情况下(希望很少发生)，您需要通知一个没有在接口上声明的方法，或者需要将一个代理对象作为具体类型传递给方法。

发现bean有事务注解就生成代理，添加事务实现返回代理，没有就返回原bean;

AspectJ是一门语言
@ @AspectJ支持
spring实现了aspectj相同的注解；
本身还是使用spring AOP；
基于@AspectJ切面配置Spring AOP，通过切面通知自动代理bean;
如果Spring确定一个bean是由一个或多个切面通知的，它会自动为该bean生成一个代理，以拦截方法调用，并确保根据需要运行通知。
准备工作： 
- @AspectJ可通过XML或java样式的配置启用；
- 确保AspectJ的aspectjweaver.jar库位于应用程序的类路径中(1.8或更高版本)。

# 切点
切点表达式：
执行任意公共方法
execution(public * *(..))
执行指定包下的任意方法
within(com.xyz.service.*)
执行代理实现AccountService接口的任何连接点(仅在Spring AOP中执行方法)
this(com.xyz.service.AccountService)

目标对象实现AccountService接口的任何连接点(仅在Spring AOP中执行方法):
target(com.xyz.service.AccountService)

execution: （常用）用于匹配方法执行的连接点，这是在使用Spring AOP时使用的主要切入点指示符。（匹配方法）
within: 用于匹配指定类型内的方法执行。（匹配整个类）
this: 用于匹配当前【AOP代理对象】类型的执行方法；
target: 用于匹配当前目标对象类型的执行方法；
args: 限制匹配连接点(使用Spring AOP时的方法执行)，其中参数是给定类型的实例
# 使用' &&' || '和' ! '组合切入点表达式
```java
@Pointcut("execution(public * *(..))")
private void anyPublicOperation() {} 

@Pointcut("within(com.xyz.myapp.trading..*)")
private void inTrading() {} 

@Pointcut("anyPublicOperation() && inTrading()")
private void tradingOperation() {} 
```

在定义中尽可能缩小匹配的搜索空间
- 类型化指示符选择
- 作用域指示符选择 within
- 上下文指示符 this、target和@annotation

```java
@Aspect("perthis(com.xyz.myapp.CommonPointcuts.businessService())")
public class MyAspect {

```
在创建方面实例之前，其中的任何通知都不会运行

# 通知
Before advice）前置通知
After returning advice）返回通知 （只适用于成功的正常返回）
After throwing advice）抛出异常后通知
After (Finally) 最终通知 （类似于try-catch语句中的finally块）
Around通知

任何通知方法都可以声明一个类型

# <aop:config>风格大量使用了Spring的自动代理机制
只使用<aop:config>样式或者只使用AutoProxyCreator样式并且不要混合使用它们

# 使用Spring框架的好处是什么？
- 轻量
- 控制反转
- 面向切面的编程(AOP)
- 容器
- MVC框架
- 事务管理
- 异常处理

# Spring由哪些模块组成？
- Core module
- Bean module
- Context module
- Expression Language module
- JDBC module
- ORM module
- OXM module
- Java Messaging Service(JMS) module
- Transaction module
- Web module
- Web-Servlet module

# 核心容器（应用上下文) 模块
这是基本的Spring模块，提供spring 框架的基础功能，BeanFactory 是 任何以`spring``基础应用`的`核心`。Spring 框架建立在此模块之上，它使Spring成为一个容器。
# BeanFactory – BeanFactory 实现举例
Bean 工厂是工厂模式的一个实现，提供了控制反转功能，用来把应用的配置和依赖从真正的应用代码中分离。最常用的BeanFactory 实现是XmlBeanFactory 类。
#  XMLBeanFactory
它根据XML文件中的定义加载beans。该容器从XML 文件读取`配置元数据`并用它去创建一个`完全配置`的系统或应用。

# AOP模块
AOP模块用于发给我们的Spring应用做面向切面的开发， 很多支持由AOP联盟提供，这样就确保了Spring和其他AOP框架的共通性。这个模块将元数据编程引入Spring
#  解释JDBC抽象和DAO模块
通过使用JDBC抽象和DAO模块，保证数据库代码的简洁，并能避免数据库资源错误关闭导致的问题，它在各种不同的数据库的错误信息之上，提供了一个`统一的异常访问层`。它还利用Spring的AOP 模块给Spring应用中的对象提供`事务管理服务`。
# ORM模块
支持我们在直接JDBC之上使用一个对象/关系映射映射(ORM)工具，Spring 支持集成主流的ORM框架，如Hiberate,JDO和 iBATIS SQL Maps。Spring的事务管理同样支持以上所有ORM框架及JDBC。
# Spring配置文件
Spring配置文件是个XML 文件，这个文件包含了类信息，描述了如何配置它们，以及如何相互调用。
# 什么是Spring IOC 容器？
Spring IOC 负责创建对象，管理对象（通过依赖注入（DI），装配对象，配置对象，并且管理这些对象的整个生命周期。

# IOC的优点是什么

# 一个Spring的应用看起来像什么
一个定义了一些功能的接口
这实现包括属性，它的Setter ， getter 方法和函数等

# 什么是bean装配？
装配，是指在Spring 容器中把bean,按照依赖关系组装到一起；
# 解释不同方式的自动装配
#  你可以在Spring中注入一个null 和一个空字符串吗？
可以。
# Spring注解
# 什么是基于注解的容器配置？
相对于XML文件，注解型的配置依赖于通过字节码元数据装配组件，而非尖括号的声明。开发者通过在相应的类，方法或属性上使用注解的方式，直接组件类中进行配置，而不是使用xml表述bean的装配关系。
- @Required 注解
- 表明bean的属性必须在配置的时候设置
- @Autowired 注解
- @Qualifier 注解
- 多个相同类型的bean却只有一个需要自动装配时



# 在Spring框架中如何更有效地使用JDBC？
# Spring对DAO的支持
Spring对数据访问对象（DAO）的支持旨在`简化它和数据访问技术`如JDBC，Hibernate or JDO 结合使用。这使我们可以方便切换持久层。编码时也不用担心会`捕获每种技术特有的异常`。

# spring支持的ORM
Hibernate
iBatis
JPA (Java Persistence API)
TopLink
JDO (Java Data Objects)
OJB

# Spring支持的事务管理类型
编程式事务管理：灵活性，但难维护;
声明式事务管理：`业务代码`和`事务管理分离`，你只需用注解和XML配置来管理事务。

# Spring框架的事务管理有哪些优点？
声明式事务管理;
它和Spring各种数据访问抽象层很好的集成;

# Spring面向切面编程（AOP）
关注点是应用中一个模块的行为,实现的一个功能;
横切关注点是一个关注点,整个应用都会使用的功能;
连接点: 应用程序执行Spring AOP的位置;
通知是个在方法执行前或执行后要做的动作;
before：前置通知，在一个方法执行前被调用
after：在方法执行之后调用的通知，无论方法执行是否成功
after-returning：仅当方法成功完成后执行的通知
after-throwing：在方法抛出异常退出时执行的通知
around：在方法执行之前和之后调用的通知
切入点是`一个或一组连接点`，通知将在这些位置执行。可以通过表达式或匹配的方式指明切入点。

# 什么是引入？
引入允许我们在已存在的类中增加新的方法和属性。
# 什么是目标对象？
被一个或者多个切面所通知的对象。它通常是一个代理对象。也指被通知（advised）对象。
# 什么是代理？
代理是通知目标对象后创建的对象。从客户端的角度看，代理对象和目标对象是一样的。

# 什么是Spring MVC框架的控制器？
制器提供一个访问应用程序的行为，此行为通常通过服务接口实现。控制器解析用户输入并将其转换为一个由视图呈现给用户的模型。Spring用一个非常抽象的方式实现了一个控制层，允许用户创建多种用途的控制器。





