var version = '${version.version}';
function dl(category, label) {
    dataLayer.push({'event':category, 'version': version});
    dataLayer.push({'event':category + '-' + label, 'version': version});
    dataLayer.push({'event':category + '-' + label + '-' + version});
}