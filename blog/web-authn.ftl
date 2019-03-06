<#--
title = W3C Web Authentication (WebAuthn)
date = 2019-03-06
publish = true
author = Stian Thorgersen
-->

<p>
W3C Web Authentication (WebAuthn) was recently made an official web standard. This is a great step towards making a safer and
simpler authentication experience for users.
</p>

<p>
Where traditional authentication, such as password and OTP, rely on having shared secrets between the user and the
web application, this is not the case with WebAuthn. WebAuthn uses public key-based credentials resulting in the web
application not having access to the users secrets anymore. The keys are also unique per web application which eliminates
the risk of phishing attacks.
</p>

<p>
WebAuthn provides a standard protocol for web applications to authenticate via a number of devices through a relatively
simple challenge/response. All major browser vendors now have support for WebAuthn and FIDO2, where FIDO2 is the specification
that enables the browser to communicate with different hardware devices.
</p>

<p>
WebAuthn can be used both as a two factor mechanism as well as enable passwordless authentication. There are already
an healthy amount of devices that can be used together with WebAuthn. There are a number of security keys like
<a href="https://www.yubico.com/">YubiKey</a>, <a href="https://thinc.ensurity.com/">ThinC</a> and
<a href="https://cloud.google.com/titan-security-key/">Titan</a>. A lot of new laptops also come with built-in
fingerprint scanners, and it Android also recently made it possible to use the fingerprint scanners on Android 7+ devices with WebAuthn.
</p>

<p>
We are of course planning on bringing WebAuthn support to Keycloak in the near future. The team behind <a href="https://github.com/webauthn4j/webauthn4j">webauthn4j</a>
has been hard at work greating a quality Java library for WebAuthn and will hopefully soon have an extension to
Keycloak ready.
</p>

<p>
We will first focus on two-factor authentication with WebAuth and as part of this we will bring a number of improvements
to Keycloak around two-factor authentication. For more details check the
<a href="https://github.com/keycloak/keycloak-community/blob/master/design/web-authn-two-factor.md">design document</a>.
</p>

<p>
Later, we will also bring the passwordless experience to Keycloak. This will also introduce Keycloak to the identity
first login flows. By asking for the users identity first Keycloak can provide smarter decisions on how to authenticate
a user based on the users preferences. For example requesting the user to press the button on their security key instead
of asking for a password.
</p>

<p>
Resources:
<ul>
<li><a href="https://www.w3.org/TR/webauthn/">W3C Specification</a></li>
<li><a href="https://fidoalliance.org/w3c-and-fido-alliance-finalize-web-standard-for-secure-passwordless-logins/">W3C and FIDO Alliance Finalize Web Standard for Secure, Passwordless Logins</a></li>
<li><a href="https://www.wired.com/story/android-passwordless-login-fido2/">Android is helping kill passwords on a billion devices</a></li>
</ul>
</p>
