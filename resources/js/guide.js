tocbot.init({
  // Where to render the table of contents.
  tocSelector: '#js-toc',
  // Where to grab the headings to build the table of contents.
  contentSelector: '#guide-body',
  // Which headings to grab inside of the contentSelector element.
  headingSelector: 'h1, h2, h3',
  // For headings inside relative or absolute positioned containers within content.
  hasInnerContainers: true,
  scrollSmoothDuration: 20
});

var optionKeys = document.getElementsByClassName("options-key");
for (var i = 0; i < optionKeys.length; i++) {
    var key = optionKeys[i];

    var expander = document.createElement('i');
    expander.classList.add('options-expander');
    expander.classList.add('fa');
    expander.classList.add('fa-chevron-right');
    expander.value = 'test';

    key.parentElement.insertBefore(expander, key);

    var container = key.parentElement;
    while (container != null) {
        if (container.nodeName == 'TD') {
            container.classList.add('options-collapsed');
            break;
        }
        container = container.parentElement;
    }

    expander.onclick = function(e) {
        var src = e.srcElement;
        var container = src.parentElement;
        while (container != null) {
            if (container.classList.contains('options-collapsed')) {
                src.classList.remove('fa-chevron-right');
                src.classList.add('fa-chevron-down');
                container.classList.remove('options-collapsed');
                container.classList.add('options-expanded');
                break;
            } else if (container.classList.contains('options-expanded')) {
                src.classList.add('fa-chevron-right');
                src.classList.remove('fa-chevron-down');
                container.classList.add('options-collapsed');
                container.classList.remove('options-expanded');
                break;
            }
            container = container.parentElement;
        }
    };
}

var buildIcons = document.getElementsByClassName('options-build');
for (var i = 0; i < buildIcons.length; i++) {
    var buildIcon = buildIcons[i];
    buildIcon.firstElementChild.setAttribute('title', 'Build option');
}
