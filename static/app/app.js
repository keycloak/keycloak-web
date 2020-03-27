function init() {
    document.getElementById('config-form').onsubmit = function() {
        updateConfig();
        return false;
    }

    var conf = loadConfig();

    if (conf.url && conf.realm && conf.client) {
        var keycloak = new Keycloak({
            url: conf.url,
            realm: conf.realm,
            clientId: conf.client
        });

        keycloak.init({
            checkLoginIframe: false
        }).success(function(auth) {
            document.getElementById('login').onclick = keycloak.login;
            document.getElementById('logout').onclick = keycloak.logout;

            show('config-view');
            hide('config-edit');

            if (auth) {
                var name;
                if (keycloak.tokenParsed['family_name'] || keycloak.tokenParsed['given_name']) {
                    name = keycloak.tokenParsed['given_name'] + ' ' + keycloak.tokenParsed['family_name']
                } else {
                    name = keycloak.tokenParsed.preferred_username;
                }
                document.getElementById('user-details').innerHTML = name;
                hide('login');
                show('logout')
                show('display-user');

            } else {
                console.info('Not Authenticated');
                hide('display-user');
                show('login');
                hide('logout')
            }
        })
    } else {
        show('config-edit');
        hide('config-view');
    }
}

function show(id) {
    document.getElementById(id).classList.remove('hide');
    document.getElementById(id).classList.add('show');
}

function hide(id) {
    document.getElementById(id).classList.add('hide');
    document.getElementById(id).classList.remove('show');
}

function updateConfig() {
    var url = document.getElementById('url').value;
    var realm = document.getElementById('realm').value;
    var client = document.getElementById('client').value;

    window.location.href = window.location.href.split('#')[0] + '#url=' + url + '&realm=' + realm + '&client=' + client;
}

function loadConfig() {
    var h = window.location.hash.substring(1).split('&');
    var r = {};
    for (var i = 0; i < h.length; i++) {
        var t = h[i].split('=')
        r[t[0]] = t[1];
    }
    return r;
}

window.onhashchange = init;
window.onload = init;