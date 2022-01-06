var version = '${version.version}';
function dl(category, label) {
    ga('send', 'event', category, category + '-' + label, category + '-' + label + '-' + version);
}