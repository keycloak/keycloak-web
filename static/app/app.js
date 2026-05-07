import Keycloak from 'keycloak-js';

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

        function login() {
            keycloak.login();
        }

        function logout() {
            keycloak.logout();
        }

        keycloak.init({
            checkLoginIframe: false
        }).then(function(auth) {
            document.getElementById('login').onclick = login;
            document.getElementById('logout').onclick = logout;
            document.getElementById('clearConfig').onclick = clearConfig;

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

function clearConfig() {
    console.info("Clearing the configuration.");
    if (window.location.href.includes('?')) {
        window.location.href = window.location.href.split('?')[0];
    }
}

function updateConfig() {
    var url = document.getElementById('url').value;
    var realm = document.getElementById('realm').value;
    var client = document.getElementById('client').value;

    window.location.href = window.location.href.split('?')[0] + '?url=' + url + '&realm=' + realm + '&client=' + client;
}

function loadConfig() {
    var qstring = window.location.href.includes('?') ? window.location.href.split('?')[1] : '';
    if (qstring.includes('#')) {
        qstring = qstring.split('#')[0];
    }
    var h = qstring.split('&');
    var r = {};
    for (var i = 0; i < h.length; i++) {
        var t = h[i].split('=')
        r[t[0]] = t[1];
    }
    console.info("Configuration loaded: " + JSON.stringify(r));
    return r;
}

init();
