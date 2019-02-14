<#--
title = Easily secure your Spring Boot applications with Keycloak
date = 2017-05-29
publish = true
author = Sébastien Blanc
-->

<h2>
What is Keycloak?</h2>
Although security is a crucial aspect of any application, its implementation can be difficult. Worse, it is often neglected, poorly implemented and intrusive in the code. But lately, security servers have appeared which allow for outsourcing and delegating all the authentication and authorization aspects. Of these servers, one of the most promising is Keycloak, open-source, flexible, and agnostic of any technology, it is easily deployable/adaptable in its own infrastructure.

Moreover, Keycloak is more than just an authentication server, it also provides a complete Identity Management system, user federation for third parties like LDAP and a lot more ... Check it out on <a href="http://www.keycloak.org/">here</a>.

The project can also be found on <a href="https://github.com/sebastienblanc/spring-boot-keycloak-tutorial">Github</a>

<br />
<br />
<!--more--><h2>
Spring Boot and Keycloak</h2>
Keycloak provides adapters for an application that needs to interact with a Keycloak instance. There are adapters for WildFly/EAP, NodeJS, Javascript and of course for Spring Boot.
<br />
<br />
<h2>
Setting up a Keycloak server</h2>
<div>
<br /></div>
You have different options to set up a Keycloak server but the easiest one is probably to grab a standalone distribution, unzip it and voila! Open a terminal and go to your unzipped Keycloak server and from the bin directory simply run:
<br />
<pre>./standalone.sh(bat)
</pre>
Then open a browser and go to <em>http://localhost:8080/auth.</em>

Since it's the first time that the server runs you will have to create an admin user, so let's create an admin user with admin as username and admin for the password:<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435383 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/kc1-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
Now you can log in into your administration console and start configuring Keycloak.
<br />
<br />
<h3>
Creating a new Realm</h3>
<div>
<br /></div>
Keycloak defines the concept of a realm in which you will define your clients, which in Keycloak terminology means an application that will be secured by Keycloak, it can be a Web App, a Java EE backend, a Spring Boot etc.

So let's create a new realm by simply clicking the "Add realm" button:<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435384 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/kc2-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
Let's call it "SpringBoot".
<br />
<br />
<h3>
Creating the client, the role, and the user</h3>
<div>
<br /></div>
Now we need to define a client, which will be our Spring Boot app. Go to the "Clients" section and click the "create" button. We will call our client "product-app":<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435385 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/kc3-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
On the next screen, we can keep the defaults settings but just need to enter a valid redirect URL that Keycloak will use once the user is authenticated. Put as value: "http://localhost:8081/*"<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435387 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/kc4-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
Don't forget to Save!

Now, we will define a role that will be assigned to our users, let's create a simple role called "user":<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435388 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/kc5-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
And at last but not least let's create a user, only the username property is needed, let's call him "testuser":<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435389 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/kc6-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
And finally, we need to set his credentials, so go to the credentials tab of your user and choose a password, I will be using "password" for the rest of this article, make sure to turn off the "Temporary" flag unless you want the user to have to change his password the first time he authenticates.

Now proceed to the "Role Mappings" tab and assign the role "user":<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435390 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/kc8-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
We are done for now with the Keycloak server configuration and we can start building our Spring Boot App!
<br />
<br />
<h2>
Creating a simple app</h2>
<div>
<br /></div>
Let's create a simple Spring Boot application, you might want to use the <a href="https://start.spring.io/">Spring Initializr</a> and choose the following options:
<br />
<ul>
<li>Web</li>
<li>Freemarker</li>
<li>Keycloak</li>
</ul>
Name your app "product-app" and download the generated project:<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435391 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/sb1-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
Import the application in your favorite IDE, I will be using IntelliJ.

Our app will be simple and will contain only 2 pages:
<br />
<ul>
<li>An index.html which will be the landing page containing just a link to the product page.</li>
<li>Products.ftl which will be our product page template and will be only accessible for authenticated user.</li>
</ul>
Let's start by creating in simple index.html file in "/src/resources/static":
<br />
<br />
<pre>&lt;html&gt;
&lt;head&gt;
    &lt;title&gt;My awesome landing page&lt;/title&gt;
&lt;/head&gt;
 &lt;body&gt;
   &lt;h2&gt;Landing page&lt;/h2&gt;
   &lt;a href="/products"&gt;My products&lt;/a&gt;
 &lt;/body&gt;
&lt;/html&gt;
</pre>
<pre>
</pre>
<pre>
</pre>
<pre></pre>
Now we need a controller:
<br />
<br />
<pre>@Controller
class ProductController {

   @Autowired ProductService productService;

   @GetMapping(path = "/products")
   public String getProducts(Model model){
      model.addAttribute("products", productService.getProducts());
      return "products";
   }

   @GetMapping(path = "/logout")
   public String logout(HttpServletRequest request) throws ServletException {
      request.logout();
      return "/";
   }
}</pre>
<pre></pre>
As you can see, it's simple; we define a mapping for the product page and one for the logout action. You will also notice that we are calling a "ProductService" that will return a list of strings that will put in our Spring MVC Model object, so let's create that service:
<br />
<pre>@Component
class ProductService {
   public List&lt;String&gt; getProducts() {
      return Arrays.asList("iPad","iPod","iPhone");
   }
}</pre>
<pre></pre>
We also need to create the product.ftl template, create this file in "src/resources/templates":
<br />
<br />
<pre>&lt;#import "/spring.ftl" as spring&gt;
&lt;html&gt;
&lt;h2&gt;My products&lt;/h2&gt;
&lt;ul&gt;
&lt;#list products as product&gt;
    &lt;li&gt;$amp{product}&lt;/li&gt;
&lt;/#list&gt;
&lt;/ul&gt;
&lt;p&gt;
    &lt;a href="/logout"&gt;Logout&lt;/a&gt;
&lt;/p&gt;
&lt;/html&gt;</pre>
<pre></pre>
Here we simply iterate through the list of products that are in our Spring MVC Model object and we add a link to log out from our application.

All that is the left is adding some keycloak properties in our application.properties.
<br />
<br />
<h3>
Defining Keycloak's configuration</h3>
<div>
<br /></div>
Some properties are mandatory:
<br />
<br />
<pre>keycloak.auth-server-url=http://localhost:8080/auth
keycloak.realm=springboot
keycloak.public-client=true
keycloak.resource=product-app</pre>
<pre></pre>
Then we need to define some Security constraints as you will do with a Java EE app in your web.xml:
<br />
<pre>keycloak.security-constraints[0].authRoles[0]=user
keycloak.security-constraints[0].securityCollections[0].patterns[0]=/products/*</pre>
Here, we simply define that every request to /products/* should be done with an authenticated user and that this user should have the role "user".

One last property is to make sure our application will be running on port 8081:
<br />
<br />
<pre>server.port=8081</pre>
<pre></pre>
We are all set and we can run our app!

You have several options to run your Spring Boot application, with Maven you can simply do:
<br />
<br />
<pre>mvn clean spring-boot:run</pre>
<pre></pre>
Now browse to "http://localhost:8080" and you should see the landing page, click the "products" links and you will be redirected to the Keycloak login page:<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435401 size-large" height="329" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/login-1024x526.png" style="border: 1px solid grey;" width="640" /><br />
<br />
Login with our user "testuser/password" and should be redirected back to your product page:<br />
<br />
&nbsp;

<img alt="" class="aligncenter wp-image-435402 size-large" height="351" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/product-1024x562.png" style="border: 1px solid grey;" width="640" /><br />
<br />
Congratulations! You have secured your first Spring Boot app with Keycloak. Now Log out and go back to the Keycloak administration console and discover how you can "tune" your login page. For instance, you can activate the "Remember Me", the "User Registration", hit the save button and go back to your login screen, you will see that these features have been added.
<br />
<br />
<h2>
Introducing Spring Security support</h2>
<div>
<br /></div>
If you're a Spring user and have been playing around security, there is a big chance that you have been using Spring Security. Well, I have some good news: we also have a Keycloak Spring Security Adapter and it's already included in our Spring Boot Keycloak Starter.

Let's see how we can leverage Spring Security together with Keycloak.
<br />
<br />
<h3>
Adding Spring Security Starter</h3>
<div>
<br /></div>
First, we need the Spring Security libraries, the easiest way to do that is to add the spring-boot-starter-security artifact in your pom.xml:
<br />
<br />
<pre>&lt;dependency&gt;
   &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;
   &lt;artifactId&gt;spring-boot-starter-security&lt;/artifactId&gt;
&lt;/dependency&gt;
</pre>
<h3>
Creating a SecurityConfig class</h3>
<div>
<br /></div>
Like any other project that is secured with Spring Security, a configuration class extending WebSecurityConfigurerAdapter is needed. Keycloak provides its own subclass that you can again subclass:
<br />
<br />
<pre>@Configuration
@EnableWebSecurity
@ComponentScan(basePackageClasses = KeycloakSecurityComponents.class)
 class SecurityConfig extends KeycloakWebSecurityConfigurerAdapter
{
   /**
    * Registers the KeycloakAuthenticationProvider with the authentication manager.
    */
   @Autowired
   public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
      KeycloakAuthenticationProvider keycloakAuthenticationProvider = keycloakAuthenticationProvider();
      keycloakAuthenticationProvider.setGrantedAuthoritiesMapper(new SimpleAuthorityMapper());
      auth.authenticationProvider(keycloakAuthenticationProvider);
   }

   @Bean
   public KeycloakConfigResolver KeycloakConfigResolver() {
      return new KeycloakSpringBootConfigResolver();
   }

   /**
    * Defines the session authentication strategy.
    */
   @Bean
   @Override
   protected SessionAuthenticationStrategy sessionAuthenticationStrategy() {
      return new RegisterSessionAuthenticationStrategy(new SessionRegistryImpl());
   }

   @Override
   protected void configure(HttpSecurity http) throws Exception
   {
      super.configure(http);
      http
            .authorizeRequests()
            .antMatchers("/products*").hasRole("user")
            .anyRequest().permitAll();
   }
}
</pre>
<pre></pre>
Let's have a closer look at the most important methods:
<br />
<ul>
<li>configureGlobal: Here we change the Granted Authority Mapper, by default in Spring Security, roles are prefixed with <strong>ROLE_,</strong> we could change that in our Realm configuration but it could be confusing for other applications that do not know this convention, so here we assign a SimpleAuthorityMapper that will make sure no prefix is added.</li>
<li>keycloakConfigResolver: By default, the Keycloak Spring Security Adapter will look up for a file named keycloak.json present on your classpath. But here we want to leverage the Spring Boot properties file support.</li>
<li>configure: Here is where we define our security constraints, pretty simple to understand we secure the path "/products" with role "user"</li>
</ul>
Now we can remove the security constraints that we had defined previously in our application.properties file and let's add another property to map the Principal name with our Keycloak username:
<br />
<pre>keycloak.principal-attribute=preferred_username
</pre>
Now we can even inject the principal in our controller method and put the username in the Spring MVC model:
<br />
<br />
<pre>@GetMapping(path = "/products")
public String getProducts(Principal principal, Model model){
   model.addAttribute("principal",principal);
   model.addAttribute("products", productService.getProducts());
   return "products";
}</pre>
<pre></pre>
Finally, we update the product.ftl template to print out the username:
<br />
<br />
<pre>&lt;#import "/spring.ftl" as spring&gt;
&lt;html&gt;
&lt;h2&gt;Hello $amp{principal.getName()}&lt;/h2&gt;
&lt;ul&gt;
&lt;#list products as product&gt;
    &lt;li&gt;$amp{product}&lt;/li&gt;
&lt;/#list&gt;
&lt;/ul&gt;
&lt;p&gt;
    &lt;a href="/logout"&gt;Logout&lt;/a&gt;
&lt;/p&gt;
&lt;/html&gt;</pre>
<pre></pre>
Restart your app, authenticate again, it should still work and you should also able to see your username printed on the product page:<br />
&nbsp; &nbsp;<img alt="" class="size-large wp-image-435410 aligncenter" src="https://developers.redhat.com/blog/wp-content/uploads/2017/05/springsec-1024x562.png" style="border: 1px solid grey;" /><br />
<h2>
Conclusion</h2>
<div>
<br /></div>
We saw in this article how to deploy and configure a Keycloak Server and then secure a Spring Boot app, first by using Java EE security constraints and then by integrating Spring Security. In the next article, we will decompose this monolith application, which will give us the opportunity to:
<br />
<ul>
<li>See how to secure a microservice.</li>
<li>How microservices can securely "talk" to each other.</li>
<li>How a Pure Web App build with AngularJS can be secured with Keycloak and call secured microservices.</li>
</ul>
<h2>
Screencast</h2>
This article is also available in "screencast" format :
<br />
<ul>
<li><a href="https://www.youtube.com/watch?v=UUWyu1kG6YI">https://www.youtube.com/watch?v=UUWyu1kG6YI</a> (Part 1)</li>
<li><a href="https://www.youtube.com/watch?v=Yc5Qe5C3Xn4">https://www.youtube.com/watch?v=Yc5Qe5C3Xn4</a> (Part 2)</li>
</ul>
<h2>
Resources</h2>
<ul>
<li><a href="https://github.com/sebastienblanc/spring-boot-keycloak-tutorial">Github Project</a></li>
<li><a href="http://www.keycloak.org/">Keycloak website</a></li>
<li><a href="https://keycloak.gitbooks.io/documentation/securing_apps/topics/oidc/java/spring-boot-adapter.html">Spring Boot Keycloak Adapter Documentation</a></li>
<li><a href="https://keycloak.gitbooks.io/documentation/securing_apps/topics/oidc/java/spring-security-adapter.html">Spring Security Keycloak Adapter Documentation</a></li>
<li><a href="https://start.spring.i/">Spring Initializr Site</a></li>
</ul>
&nbsp;

<br />
<hr />
