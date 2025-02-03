var pageWithHash = window.location.pathname + window.location.hash;
var page = window.location.pathname;
var openRedirects = new XMLHttpRequest();
openRedirects.onreadystatechange = function() {
    if (this.readyState === 4 && this.status === 200) {
        var redirects = this.responseText.split(/\r?\n/);
        for (var i = 0; i < redirects.length; i++) {
            var redirect = redirects[i].split("=");
            if (redirects[i].trim().startsWith("#")) {
                // allow for line comments
                continue;
            }
            var pattern = new RegExp(redirect[0])
            if (pattern.test(page) || pattern.test(pageWithHash)) {
                document.title = "Redirecting..."
                document.getElementById("heading").innerText = "Redirecting...";
                document.getElementById("redirecting").style.display = "block";
                document.getElementById("notfound").style.display = "none";
                document.getElementById("redirectlink").href = redirect[1];
                document.getElementById("redirectlink").innerText = redirect[1];
                var anchor = "";
                if (redirect[1].indexOf("#") !== -1) {
                    anchor = "#" + redirect[1].split("#")[1];
                }
                var checkRedirect = new XMLHttpRequest();
                checkRedirect.onreadystatechange = function() {
                    if (this.readyState === 4) {
                        if (this.status === 200) {
                            // The response URL will no longer contain the anchor, therefore, add it again
                            window.location = checkRedirect.responseURL + anchor;
                        } else {
                            document.getElementById("heading").innerText = "Redirect failed";
                            document.getElementById("notfound").style.display = "block";
                            document.getElementById("redirecting").style.display = "none";
                        }
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