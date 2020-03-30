<#assign title = "Test Application" noindex=true nocsp=true>

<#include "../../templates/header.ftl">
<#include "../../templates/menu.ftl">

<script src="keycloak.js" type="text/javascript"></script>
<script src="app.js" type="text/javascript"></script>

<div class="page-section cards-section">
    <div class="container">
        <div class="row">
            <div class="card">
                <div id="card-config" class="card-body">
                    <div id="config-view" class="hide">
                        <a id="login" class="btn btn-primary hide">Sign in</a>
                        <a id="logout" class="btn btn-primary hide">Sign out</a>
                        <a href="" class="btn btn-default">Clear config</a>
                    </div>
                    <div id="config-edit" class="hide">
                        <form class="form-horizontal" id="config-form">
                          <div class="form-group">
                            <label for="url" class="col-sm-2 control-label">Keycloak URL</label>
                            <div class="col-sm-10">
                              <input type="text" class="form-control" id="url" value="http://localhost:8080/auth">
                            </div>
                          </div>
                          <div class="form-group">
                            <label for="realm" class="col-sm-2 control-label">Realm</label>
                            <div class="col-sm-3">
                              <input type="text" class="form-control" id="realm" value="myrealm">
                            </div>
                          </div>
                          <div class="form-group">
                            <label for="client" class="col-sm-2 control-label">Client</label>
                            <div class="col-sm-3">
                              <input type="text" class="form-control" id="client" value="myclient">
                            </div>
                          </div>
                          <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                              <button class="btn btn-primary">Save</button>
                            </div>
                          </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div id="display-user" class="row hide">
            <div class="card">
                <div class="card-body">
                    Hello, <span id="user-details"></span>
                </div>
            </div>
        </div>
    </div>
</div>

<#include "../../templates/footer.ftl">
