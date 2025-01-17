dataLayer.push({'kc_version': window.kc_version});
function dl(category, label) {
    dataLayer.push({'event':category});
    dataLayer.push({'event':category + '-' + label});
    dataLayer.push({'event':category + '-' + label + "-" + window.kc_version});
}