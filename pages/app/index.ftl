<#import "/templates/template.ftl" as tmpl>

<@tmpl.page current="test-app" title="Test application" noindex=true nocsp=true>

<script src="keycloak.js" type="text/javascript"></script>
<script src="app.js" type="text/javascript"></script>

<div class="jumbotron jumbotron-fluid kc-bg-triangles py-5 kc-app">
    <div class="container">
    <div class="row">
        <div class="card">
            <div id="card-config" class="card-body">
                <div id="config-view" class="hide my-3">
                    <a id="login" class="btn btn-primary hide">Sign in</a>
                    <a id="logout" class="btn btn-primary hide">Sign out</a>
                    <a href="#" class="btn btn-secondary show">Clear config</a>
                </div>
                <div id="config-edit" class="hide">
                    <form id="config-form">
                      <div class="mb-3">
                        <label for="url" class="form-label">Keycloak URL</label>
                        <div>
                          <input type="text" class="form-control" id="url" value="http://localhost:8080/auth">
                        </div>
                      </div>
                      <div class="mb-3">
                        <label for="realm" class="form-label">Realm</label>
                        <div>
                          <input type="text" class="form-control" id="realm" value="myrealm">
                        </div>
                      </div>
                      <div class="mb-3">
                        <label for="client" class="form-label">Client</label>
                        <div>
                          <input type="text" class="form-control" id="client" value="myclient">
                        </div>
                      </div>
                      <div>
                          <button class="btn btn-primary">Save</button>
                      </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div id="display-user" class="row hide">
        <div class="card mt-3">
            <div class="card-body">
                Hello, <span id="user-details"></span>
            </div>
        </div>
    </div>
    </div>
</div>

</@tmpl.page>