# spring-boot 整合 shiro
```pom
<dependency>
    <groupId>org.apache.shiro</groupId>
    <artifactId>shiro-spring-boot-starter</artifactId>
    <version>1.9.1</version>
</dependency>

<dependency>
    <groupId>org.apache.shiro</groupId>
    <artifactId>shiro-spring</artifactId>
    <version>1.4.1</version>
</dependency>
```

# Realm
```java
package com.example.demo.shirodemo;

import com.example.demo.common.utils.DigestsUtil;
import com.example.demo.service.impl.LoginServiceImpl;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import java.util.Map;

public class DemoRealm extends AuthorizingRealm {

    public DemoRealm(){
        // CredentialsMatcher
        HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher(DigestsUtil.SHA1);
        hashedCredentialsMatcher.setHashIterations(DigestsUtil.ITERATIONS);
        setCredentialsMatcher(hashedCredentialsMatcher);

    }


    // 授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

//  认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        Object principal = authenticationToken.getPrincipal();
        LoginServiceImpl loginService = new LoginServiceImpl();
        Map<String, String> passwordByUsername = loginService.getPasswordByUsername((String) principal);
        String password = passwordByUsername.get("password");
        String salt = passwordByUsername.get("salt");
        return new SimpleAuthenticationInfo(principal, password, ByteSource.Util.bytes(salt), getName());
    }
}
```
# SecurityManager
```java
package com.example.demo.shirodemo;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.realm.text.IniRealm;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.Factory;

public class Client {
    public static void main(String[] args) {
        DefaultSecurityManager defaultSecurityManager = new DefaultSecurityManager();
        DemoRealm demoRealm = new DemoRealm();
        defaultSecurityManager.setRealm(demoRealm);
        SecurityUtils.setSecurityManager(defaultSecurityManager);

//        //导入INI配置创建工厂
//        Factory<SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro.ini");
//        //工厂构建安全管理器
//        SecurityManager securityManager = factory.getInstance();
//        //使用工具生效安全管理器
//        SecurityUtils.setSecurityManager(securityManager);

        Subject subject = SecurityUtils.getSubject();
        //5.创建令牌
        UsernamePasswordToken token = new UsernamePasswordToken("admin","123");

        try{
            System.out.println("认证状态: "+ subject.isAuthenticated());
            subject.login(token);//用户认证
            System.out.println("认证状态: "+ subject.isAuthenticated());
        }catch (UnknownAccountException e){
            e.printStackTrace();
            System.out.println("认证失败: 用户名不存在~");
        }catch (IncorrectCredentialsException e){
            e.printStackTrace();
            System.out.println("认证失败: 密码错误~");
        }
    }
}

```