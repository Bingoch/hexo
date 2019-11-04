---
title: SpringMVC
tag: SpringMVC
categories: SpringMVC
---

## 1. 三层结构介绍

三层架构包括：**表现层、业务层、持久层**。

### 1.1 表现层

- 也就是我们常说的web 层。它负责接收客户端请求，向客户端响应结果，通常客户端使用http 协议请求web 层，web 需要接收 http 请求，完成 http 响应。

- 表现层包括展示层和控制层：控制层负责接收请求，展示层负责结果的展示。

- 表现层依赖业务层，接收到客户端请求一般会调用业务层进行业务处理，并将处理结果响应给客户端。

- 表现层的设计一般都使用 MVC 模型。（MVC 是表现层的设计模型，和其他层没有关系）

### 1.2 业务层

- 也就是我们常说的 service 层。它负责业务逻辑处理，和我们开发项目的需求息息相关。web 层依赖业务层，但是业务层不依赖 web 层。

- 业务层在业务处理时可能会依赖持久层，如果要对数据持久化需要保证事务一致性。（也就是我们说的， 事务应该放到业务层来控制）

### 1.3 持久层

- 也就是我们是常说的 dao 层。负责数据持久化，包括数据层即数据库和数据访问层，数据库是对数据进行持久化的载体，数据访问层是业务层和持久层交互的接口，业务层需要通过数据访问层将数据持久化到数据库中。通俗的讲，持久层就是和数据库交互，对数据库表进行增删改查的。

## 2. MVC 设计模式

**MVC** 全名是 Model View Controller，是**模型(model)－视图(view)－控制器(controller)**的缩写， 是一种用于设计创建 Web 应用程序表现层的模式。MVC 中每个部分各司其职：

1. Model（模型）

- 模型包含业务模型和数据模型，数据模型用于封装数据，业务模型用于处理业务。

2. View（视图）

- 通常指的就是我们的 jsp 或者 html，作用一般就是展示数据的。

- 通常视图是依据模型数据创建的。

3. Controller（控制器）

- 是应用程序中处理用户交互的部分。作用一般就是处理程序逻辑的。

## 3. 执行流程

![](C:\Users\CHEN\Documents\markdown\image\mvc.jpg)

# 配置

## web.xml 配置

配置前端控制器DispatcherServlet和拦截的URL

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:mvc="http://www.springframework.org/schema/mvc"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd" id="WebApp_ID" version="3.0">
  <display-name>springmvcTest</display-name>

  <welcome-file-list>
    <welcome-file>index.jsp</welcome-file>
  </welcome-file-list>

  <!--
    1.在servlet-name命名
    2.servlet-class就是你对应的拦截器的包，这里默认这样写就好了
    3.load-on-startup=1  看名字就知道是指工程运行的的时候就启动该拦截器
  -->
  <servlet>
      <servlet-name>springmvc</servlet-name>
      <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
      <init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>classpath:spring-mvc.xml</param-value>
	  </init-param>
      <load-on-startup>1</load-on-startup>
  </servlet>
  <!-- 
     4.servlet-mapping就是设置拦截器将要对哪些请求做出拦截，*.do表示对所有.do的结尾的请求会被拦截处理
   -->
  <servlet-mapping>
      <servlet-name>springmvc</servlet-name>
    <url-pattern>*.do</url-pattern>      
  </servlet-mapping>

</web-app>
```

## spring-mvc 配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <!-- 启用Spring基于annotation的DI, 使用户可以在Spring MVC中使用Spring的强大功能。-->
    <context:annotation-config />

    <!-- DispatcherServlet上下文， 只管理@Controller类型的bean， 忽略其他型的bean, 如@Service -->
    <context:component-scan base-package="com.springmvc.controller">
        <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller" />
    </context:component-scan>

    <!-- HandlerMapping, 无需配置， Spring MVC可以默认启动。 DefaultAnnotationHandlerMapping
        annotation-driven HandlerMapping -->

    <!-- 扩充了注解驱动，可以将请求参数绑定到控制器参数 -->
    <mvc:annotation-driven />

    <!-- 静态资源处理， css， js， imgs -->
    <mvc:resources mapping="/resources/**" location="/resources/" />

    <!-- 配置视图解析器。 可以用多个ViewResolver。 使用order属性排序。 InternalResourceViewResolver放在最后。 -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/jsps/" />
        <property name="suffix" value=".jsp" />
    </bean>
    
    <mvc:interceptors>  
    <!-- 使用 bean 定义一个 Interceptor，直接定义在 mvc:interceptors 下面的 Interceptor 将拦截所有的请求 -->  
    <bean class="com.springmvc.interceptor.WrongCodeInterceptor"/>  
    <mvc:interceptor>  
        <mvc:mapping path="/demo/hello.do"/>  
        <!-- 定义在 mvc:interceptor 下面的 Interceptor，表示对特定的请求进行拦截 -->  
        <bean class="com.springmvc.interceptor.LoginInterceptor"/>  
    </mvc:interceptor>  
</mvc:interceptors>  
</beans>
```

# Controller返回值及常用注解

Controller 方法的返回值分为不使用注解修饰和注解修饰两种。

## 1. 不使用注解修饰

### 1.1返回ModelAndView

```java
@RequestMapping(value = "returnMV")
public ModelAndView returnMV() {
	ModelAndView mv = new ModelAndView();
	List<Item> itemList = itemService.findItemList();
	mv.addObject("itemList", itemList);
	mv.setViewName("itemList");
	return mv;
}
```

### 1.2 返回void

   (1) 使用 request 转发向页面

```java
request.getRequestDispatcher("页面路径").forward(request, response);
```

   (2) 通过 response 页面重定向

```java
response.sendRedirect("url")
```

   (3) 通过 response 指定响应结果

```java
@RequestMapping(value = "returnVoid")
public void returnVoid(HttpServletRequest request, HttpServletResponse response) throws IOException {
	response.setCharacterEncoding("utf-8");
	response.setContentType("application/json;charset=utf-8");
	response.getWriter().write("findItem2 result");
}
```

### 1.3 返回字符串

   (1) 逻辑视图名

```java
@RequestMapping(value = "returnString")
public String returnString(Model model) {
	List<Item> itemList = itemService.findItemList();
	model.addAttribute("itemList", itemList);
	return "itemList";
}
```

   (2) redirect 重定向

```java
/**
 * 返回字符串:redirect重定向
 */
@RequestMapping(value = "redirectUrl")
public String redirectUrl() {
    System.out.println("代码执行到这里···redirectUrl");
    return null;
}
/**
 * 测试
 */
@RequestMapping(value = "test")
public String test() {
    return "redirect:redirectUrl";
}
```

   (3) forward 转发

```java
/**
 * 返回字符串:forward重定向
 */
@RequestMapping(value = "forwardUrl")
public String forwardUrl() {
    System.out.println("代码执行到这里···forwardUrl");
    return null;
}
@RequestMapping(value = "test")
public String test() {
    return "forward:forwardUrl";
}
```

## 2. 使用注解

### 2.1 @ResponseBody 注解

@ResponseBody 注解可以通过内置的9种 HttpMessageConverter，匹配不同的 Controller返回值类型，然后进行不同的消息转换处理。

将转换之后的数据放到 HttpServletResponse 对象的响应体返回到页面,不同的 HttpMessageConverter 处理的数据，指定的 ContentType 值也不同。

```java
@RequestMapping(value = "returnJson")
@ResponseBody
public List<Item> returnJson(Model model) {
	List<Item> itemList = itemService.findItemList();
	return itemList;
}
```

### 2.2 @RestController 注解

@RestController 注解相当于是 @Controller 和 @ResponseBody 的组合注解，有此注解标注的类，都不需要再写 @ResponseBody 注解了。

```java
@RestController
public class RestTestController {

    @Autowired
    private ItemService itemService;

    @RequestMapping(value = "itemList")
    public List<Item> itemList() {
        List<Item> itemList = itemService.findItemList();
        return itemList;
    }
}
```

效果和使用 @ResponseBody 注解是完全一样的。

## 3. @RequestMapping 注解

1. URL路径映射

- @RequestMapping(value="item") 或 @RequestMapping("item"）
- value的值是数组，可以将多个url映射到同一个方法 @RequestMapping(value = {"itemList", "items"})

2. 窄化请求映射

在 class 上添加 @RequestMapping(url) 指定通用请求前缀， 限制此类下的所有方法的访问请求 url 必须以请求前缀开头，通过此方法对 url 进行模块化分类管理。

```java
@RestController
@RequestMapping(value = "item")
public class RestTestController {

    @Autowired
    private ItemService itemService;

    @RequestMapping(value = {"itemList","items"})
    public List<Item> itemList() {
        List<Item> itemList = itemService.findItemList();
        return itemList;
    }
}
```

3. 请求方法限定

```java
@RequestMapping(method = RequestMethod.GET)
@RequestMapping(method = RequestMethod.POST)
@RequestMapping(method={RequestMethod.GET,RequestMethod.POST})
```



# 参数绑定

## 1. 默认支持的类型

SpringMVC 有支持的默认参数类型，我们直接在形参上给出这些默认类型的声明，就能直接使用了。如下：

**①、HttpServletRequest 对象**

**②、HttpServletResponse 对象**

**③、HttpSession 对象**

**④、Model/ModelMap 对象**

```java
@RequestMapping("/defaultParameter")
    public ModelAndView defaultParameter(HttpServletRequest request,HttpServletResponse response,HttpSession session,Model model,ModelMap modelMap) throws Exception{
        request.setAttribute("requestParameter", "request类型");
        response.getWriter().write("response");
        session.setAttribute("sessionParameter", "session类型");
        //ModelMap是Model接口的一个实现类，作用是将Model数据填充到request域
        //即使使用Model接口，其内部绑定还是由ModelMap来实现
        model.addAttribute("modelParameter", "model类型");
        modelMap.addAttribute("modelMapParameter", "modelMap类型");
         
        ModelAndView mv = new ModelAndView();
        mv.setViewName("view/success.jsp");
        return mv;
    }
```

## 2. 基本数据类型

```
一、byte，占用一个字节，取值范围为 -128-127，默认是“\u0000”，表示空
二、short，占用两个字节，取值范围为 -32768-32767
三、int，占用四个字节，-2147483648-2147483647
四、long，占用八个字节，对 long 型变量赋值时必须加上"L"或“l”,否则不认为是 long 型
五、float，占用四个字节，对 float 型进行赋值的时候必须加上“F”或“f”，如果不加，会产生编译错误，因为系统
自动将其定义为 double 型变量。double转换为float类型数据会损失精度。float a = 12.23产生编译错误的，float a = 12是正确的
六、double，占用八个字节，对 double 型变量赋值的时候最好加上“D”或“d”，但加不加不是硬性规定
七、char,占用两个字节，在定义字符型变量时，要用单引号括起来
八、boolean，只有两个值“true”和“false”，默认值为false，不能用0或非0来代替，这点和C语言不同
```

```java
@RequestMapping("/basicData")
    public void basicData(@RequestParam(value="username") int username){
        System.out.println(username);
    }
```

问题：我们这里的参数是基本数据类型，如果从前台页面传递的值为 null 或者 “”的话，那么会出现数据转换的异常，就是必须保证表单传递过来的数据不能为null或”"，所以，在开发过程中，对可能为空的数据，最好将参数数据类型定义成包装类型

## 3.包装数据类型

包装类型如Integer、Long、Byte、Double、Float、Short，（**String 类型在这也是适用的**）

```java
@RequestMapping("/basicData")
    public void basicData(@RequestParam(value="username") Integer username){
        System.out.println(username);
    }
```

## 4. POJO（实体类）类型的绑定

先定义实体类，再进行参数绑定

```java
@RequestMapping("/pojo")
    public void pojo(User user){
        System.out.println(user);
    }
```

## 5. 集合类型

1. 数组绑定

```java
@RequestMapping("/basicData")
    public void basicData(@RequestParam(value="ids") int[] ids){
        System.out.println(ids);
    }
```

2. List与Map绑定

在包装的pojo中新添加一个List 和 Map类型的属性

```java
Public class QueryVo {
    private Map<String, Student> itemInfo;
    private List<Item> itemList;
    //get/set方法..
}
```

​	