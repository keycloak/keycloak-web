var page = window.location.pathname + window.location.hash;
var openRedirects = new XMLHttpRequest();
openRedirects.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var redirects = this.responseText.split(/\r?\n/);
        for (var i = 0; i < redirects.length; i++) {
            var redirect = redirects[i].split("=");
            if (page.startsWith(redirect[0])) {
                var checkRedirect = new XMLHttpRequest();
                checkRedirect.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        window.location = checkRedirect.responseURL;
                    }
                }
                checkRedirect.open("GET", redirect[1], true);
                checkRedirect.send();
                break;
            }
        }
    }
  };
openRedirects.open("GET", "/resources/redirects", true);
openRedirects.send();