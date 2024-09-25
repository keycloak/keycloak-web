<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="security" title="Security">

<div class="container mt-5 kc-article">

<h1>Security Charter</h1>

<h2>Mission</h2>
<p>The Keycloak Security Taskforce is committed to enhancing the security of the Keycloak project through continuous improvement of documentation, code, and processes. Our core responsibilities include:</p>
<ul>
  <li>Proactive triage: rapidly addressing security vulnerabilities reported to Keycloak and ensuring they are resolved promptly and consistently.</li>
  <li>Impact evaluation: assessing the security implications of new and existing features.</li>
  <li>Process enhancement: regularly reviewing and refining security processes to ensure ongoing improvement within the codebase.</li>
</ul>

<h2>Teams</h2>

<h3>Keycloak Security Response Team</h3>
<p>A dedicated subset of maintainers actively involved in triaging new issues and coordinating with Resolution Teams. The Response Team has full access to all CVEs reported to the project and can add or remove members from Resolution Teams as necessary.</p>

<h4>Member Nomination Process</h4>
<ul>
  <li>New members can be nominated by existing maintainers and members of the Keycloak Security Response Team. Members of both teams have a vote in the approval process, and a 2/3 majority is required for approval.</li>
  <li>All nominations must be sent to the Keycloak Security mailing list.</li>
  <li>Members may step down at any time and may nominate a replacement when they do.</li>
</ul>

<h4>Responsibilities</h4>
<ul>
  <li>Remain active and responsive, participating in day-to-day activities.</li>
  <li>Communicate any leave of absence.</li>
  <li>Participate on rotating shifts on a weekly basis.</li>
  <li>Members that have been inactive or not filling their responsibilities for more than three months without advance notice will be removed by vote.</li>
</ul>

<h4>Scope</h4>
<ul>
  <li>Vulnerability triage: managing reports received via the Keycloak security mailing list.</li>
  <li>Coordination: overseeing the response to reported vulnerabilities to ensure compliance with SLA deadlines.</li>
  <li>Process improvement: maintaining and enhancing security measures, such as implementing linters, scanners, fuzzers, and patch managers. Ensuring security is proactively integrated throughout the project.</li>
</ul>

<h4>Rotating shifts</h4>
<ul>
  <li>Team members take turns being the primary point of contact on a weekly basis.</li>
  <li>The designated person on the shift handles incoming security requests, coordinates responses to incidents, and manages day-to-day security tasks during their shift.</li>
  <li>Other team members will continue to work on security response duties, supporting the person on the shift.</li>
  <li>The Keycloak Security Office weekly meeting hours determine the end of the shift, and the next person on the shift is updated about the status.</li>
  <li>Vacations and PTOs are communicated during the meeting so we can adjust the shift.</li>
</ul>

<h3>Keycloak Security Resolution Team</h3>
<p>Dynamic teams formed by individuals actively involved in triaging or resolving open CVEs. Members are added when they engage with a vulnerability and removed once their involvement concludes.</p>

<h4>Scope</h4>
<ul>
  <li>Resolution and testing: ensuring vulnerabilities are effectively fixed and thoroughly tested.</li>
  <li>Collaboration: working with the Response team to prioritize fixes above all other items in the team's backlog, regardless of their nature.</li>
  <li>Release Coordination: collaborating closely with release coordinators and Quality Engineering (QE) teams to include patches in upcoming releases.</li>
</ul>

<h2>Access</h2>
<table>
  <thead>
    <tr>
      <th>Resource</th>
      <th>Response Team</th>
      <th>Resolution Team</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><a href="https://groups.google.com/g/keycloak-security">Mailing list</a></td>
      <td>Full access</td>
      <td>Added in CC to specific threads</td>
    </tr>
    <tr>
      <td><a href="https://github.com/keycloak/keycloak-private/">Private GitHub repository</a></td>
      <td>Full access</td>
      <td>Temporary access</td>
    </tr>
    <tr>
      <td><a href="https://github.com/keycloak/keycloak/security">Security advisories and alerts</a></td>
      <td>Full access</td>
      <td>No access</td>
    </tr>
    <tr>
      <td>Slack channel (#alerts-keycloak-cve)</td>
      <td>Full access</td>
      <td>Temporary access</td>
    </tr>
  </tbody>
</table>

<h2>Coordinating a Security Vulnerability Fix</h2>
<ul>
  <li>Identification: the Response Team identifies relevant engineers from affected areas and temporarily includes them in private communication channels (e.g., repositories, email threads), forming a temporary Resolution Team.</li>
  <li>Efficiency: to prevent accidental disclosure, the Resolution Team remains as small as necessary.</li>
  <li>Autonomy: the Resolution Team has the autonomy to involve additional parties such as release coordinators, QE, and documentation teams. Communication with the Response Team is advised when in doubt.</li>
  <li>Access Revocation: post-release, access to sensitive communication channels is revoked to uphold the principle of least privilege.</li>
</ul>

<h2>Process Overview</h2>
<ol>
  <li>A new vulnerability is reported to the Keycloak security mailing list.</li>
  <li>A CVE ID is assigned.</li>
  <li>The Response Team identifies the responsible group (e.g., Team A with members Noah and Emma).</li>
  <li>Team A submits the fix to the private repository and includes domain experts for review.</li>
  <li>Team A informs QE and releases coordinators about the forthcoming patch.</li>
  <li>The pull request is merged, and a new release is issued along with official advisories.</li>
</ol>

<p>In the absence of CVEs to fix, all team members will have their access revoked to security-sensitive channels except for the Keycloak Security Response Team.</p>

<p>This charter outlines the approach the Keycloak project takes to manage and mitigate security vulnerabilities, ensuring the integrity and reliability of the project for all users.</p>

</div>

</@tmpl.page>
