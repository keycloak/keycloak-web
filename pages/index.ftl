<#include "../templates/header.ftl">
<#include "../templates/menu.ftl">

<div class="marquee-section">
    <div class="container-fluid">
        <div class="row marquee-slide-row">
            <div class="col-xs-12">
                <h1>Open Source Identity and Access Management</h1>
                <h2>For Modern Applications and Services</h2>
                <div class="learn"><a class="btn btn-primary" href="${root}getting-started.html">Get Started with Keycloak</a></div>
            </div>
        </div>
    </div>
</div>

<div class="main-banner">
    <div class="container">
        <div class="row">
            <div class="col-sm-7 col-xs-12 left-col">
                <p>
                    Add authentication to applications and secure services with minimum fuss. No need to deal with storing
                    users or authenticating users. It's all available out of the box.
                </p>
                <p>
                    You'll even get advanced features such as User Federation, Identity Brokering and Social Login.
                </p>
                <p>
                    For more details go to <a href="about.html">about</a> and <a href="documentation.html">documentation</a>, and don't forget to <a href="${root}getting-started.html">try Keycloak</a>. It's easy by design!
                </p>
            </div>

            <div class="col-sm-4 col-sm-offset-1 col-xs-12 announcement-col">
                <div class="announce-box">
                    <h3>News</h3>
                    <ul class="announce-ul">
                        <#list news as n>
                        <li>
                            <b>${n.date?string["dd MMM"]}</b> <a href="${n.link}">${n.title}</a>
                        </li>
                        </#list>
                    </ul>
                </div>


            </div>

        </div>
    </div>
</div>

<div class="features-section">
    <div class="container features-area">
        <div class="features-flex-container">

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-key" aria-hidden="true"></i></li>
                    <li class="description"><h4>Single-Sign On</h4>
                        <p>Login once to multiple applications</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-exchange" aria-hidden="true"></i></li>
                    <li class="description"><h4>Standard Protocols</h4>
                        <p>OpenID Connect, OAuth 2.0<br/> and SAML 2.0</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-cog" aria-hidden="true"></i></li>
                    <li class="description"><h4>Centralized Management</h4>
                        <p>For admins and users</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-shield" aria-hidden="true"></i></li>
                    <li class="description"><h4>Adapters</h4>
                        <p>Secure applications and services easily</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-users" aria-hidden="true"></i></li>
                    <li class="description"><h4>LDAP and Active Directory</h4>
                        <p>Connect to existing user directories</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-cloud" aria-hidden="true"></i></li>
                    <li class="description"><h4>Social Login</h4>
                        <p>Easily enable social login</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-cloud" aria-hidden="true"></i></li>
                    <li class="description"><h4>Identity Brokering</h4>
                        <p>OpenID Connect or SAML 2.0 IdPs</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-bolt" aria-hidden="true"></i></li>
                    <li class="description"><h4>High Performance</h4>
                        <p>Lightweight, fast and scalable</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-server" aria-hidden="true"></i></li>
                    <li class="description"><h4>Clustering</h4>
                        <p>For scalability and availability</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-eye" aria-hidden="true"></i></li>
                    <li class="description"><h4>Themes</h4>
                        <p>Customize look and feel</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-edit" aria-hidden="true"></i></li>
                    <li class="description"><h4>Extensible</h4>
                        <p>Customize through code</p>
                    </li>
                </ul>
            </div>

            <div class="flex-item">
                <ul>
                    <li class="symbol"><i class="fa fa-2x fa-lock" aria-hidden="true"></i></li>
                    <li class="description"><h4>Password Policies</h4>
                        <p>Customize password policies</p>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<#include "../templates/footer.ftl">
