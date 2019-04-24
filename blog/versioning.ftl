<#--
title = Keycloak Releases and Versioning
date = 2019-04-24
publish = true
author = Stian Thorgersen
-->

<p>
We are aiming to achieve a continuous delivery model with Keycloak. By that we mean it should be seamless to upgrade
between Keycloak releases and to keep up to date with the latest release.
</p>

<p>
This requires no breaking changes, but rather deprecating old APIs allowing time to migrate to new APIs.
</p>

<p>
Traditional semantic versioning does not fit very well with this model. By following the mantra of continuous delivery
we would forever be stuck on a major version and only update the minor version, and you could argue whether or not it
would be correct to update the major version when an API that has been deprecated for a long period of time is removed.
</p>

<p>
With this in mind we have made some slight changes to our release cadence and versioning schema.
</p>

<p>
For now we will have a new feature release roughly 4 times each year. Each release will bump the major version number.
That doesn't mean there are breaking changes, but until we perfect our continuous delivery model there may be some, so
always refer to the migration guide prior to upgrading!
</p>

<p>
We have also decided to drop the Final suffix from releases. That is simply because it is not needed as we have not done
any beta or release candidates for a long time. In the spirit of continuous delivery we will have individual features
marked as preview, rather than whole releases.
</p>

<p>
As a final note with the reduced release cadence we are planning to do more micro releases. This will be focused on
critical bugs and security vulnerabilities. We may however accept contributions to less critical bugs given the fix
is well tested and has low risk of regressions.
</p>