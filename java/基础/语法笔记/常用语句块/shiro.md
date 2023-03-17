# Override 和继承抽象类的特性
- 继承抽象类可以节省公用的代码，子类只需要关注部分功能方法的实现，实践中
  用@Override重写abstract抽象方法， protected abstract AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken var1) throws AuthenticationException;
  父类中已经对这个抽象方法实施了调用，同时还做了额外的处理计算等；
  get和set也可以在继承中重写和复用，在实践中常常用于修改默认的配置项（封装的对象往往有默认的配置）；
```java

public abstract class AuthenticatingRealm {
    public AuthenticatingRealm() {
        this.setCredentialsMatcher();
    }
    protected abstract AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken var1) throws AuthenticationException;

    public final AuthenticationInfo getAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        AuthenticationInfo info = this.getCachedAuthenticationInfo(token);
        if (info == null) {
            // 1.得到重写方法的返回值
            info = this.doGetAuthenticationInfo(token);
        }
        if (info != null) {
            // 2.对重写方法的返回值，在此处做了匹配验证
            this.assertCredentialsMatch(token, info);
        }
        return info;
    }


    // 验证的方法
    protected void assertCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) throws AuthenticationException {
        CredentialsMatcher cm = this.getCredentialsMatcher();
        if (cm != null) {
            if (!cm.doCredentialsMatch(token, info)) {
                String msg = "Submitted credentials for token [" + token + "] did not match the expected credentials.";
                throw new IncorrectCredentialsException(msg);
            }
        } else {
            throw new AuthenticationException("A CredentialsMatcher must be configured in order to verify credentials during authentication.  If you do not wish for credentials to be examined, you can configure an " + AllowAllCredentialsMatcher.class.getName() + " instance.");
        }
    }

    // setCredentialsMatcher getCredentialsMatcher
    // get set
    public void setCredentialsMatcher(CredentialsMatcher credentialsMatcher) {
        this.credentialsMatcher = credentialsMatcher;
    }
}
public abstract class AuthorizingRealm extends AuthenticatingRealm implements Authorizer, Initializable, PermissionResolverAware, RolePermissionResolverAware {}



public class HashedCredentialsMatcher {
    /**
        如何判断是用的同一个加密方法呢？
        
        @param token: 是主体
        @param info: new SimpleAuthenticationInfo(principal, password, ByteSource.Util.bytes(salt), getName());
     */
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
        /**
        protected Hash hashProvidedCredentials(Object credentials, Object salt, int hashIterations) {
                String hashAlgorithmName = this.assertHashAlgorithmName();
                return new SimpleHash(hashAlgorithmName, credentials, salt, hashIterations);
            }
         */
         // 默认使用的SimpleHash加密算法
        Object tokenHashedCredentials = this.hashProvidedCredentials(token, info);

        // 重写方法返回的SimpleHash加密算法， new SimpleAuthenticationInfo(principal, password, ByteSource.Util.bytes(salt), getName());
        Object accountCredentials = this.getCredentials(info);

        // 两者进行比较, 认证是否通过
        return this.equals(tokenHashedCredentials, accountCredentials);
    }
}

public class DefinedRealm extends AuthorizingRealm {

    public DefinedRealm(){
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

    // 认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
         Object principal = authenticationToken.getPrincipal();

        SecurityService securityService = new SecurityServiceImpl();
//        String password = securityService.findPasswordByLoginName((String) principal);
        Map<String, String> passwordByLoginName = securityService.findPasswordByLoginName((String) principal);


        if (passwordByLoginName.isEmpty()) {
            throw new UnknownAccountException("未知的账户");
        }

        String password = passwordByLoginName.get("password");
        String salt = passwordByLoginName.get("salt");



        return new SimpleAuthenticationInfo(principal, password, ByteSource.Util.bytes(salt), getName());
    }
}


```