window.onload = function() {
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

    addTitleToBuildOptionIcons();
    createExpanderForOptions();

    loadUrlQuery();
    addSearchEventListeners();
}

function createExpanderForOptions() {
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
}

function addTitleToBuildOptionIcons() {
    var buildIcons = document.getElementsByClassName('options-build');
    for (var i = 0; i < buildIcons.length; i++) {
        var buildIcon = buildIcons[i];
        buildIcon.firstElementChild.setAttribute('title', 'Build option');
    }
}

function loadUrlQuery() {
    var params = new URLSearchParams(window.location.search);
    var q = params.get('q');
    if (q) {
        document.getElementById('options-search').value = q;
    }
    var f = params.get('f');
    if (f) {
        document.getElementById('options-filter-' + f).checked = true;
    }
    if (q || f) {
        search();
    }
}

function updateUrlQuery(search, filter) {
    var query = '';

    if (search) {
        query = '?q=' + search;
    }

    if (filter) {
        if (query.length > 0 && filter != 'all') {
            query += '&f=' + filter;
        } else if (filter != 'all') {
            query += '?f=' + filter;
        }
    }

    var url = window.location.toString();
    if (url.indexOf('?') != -1) {
        url = url.substring(0, url.indexOf('?'));
    }

    history.replaceState(null, null, url + query);
}

function addSearchEventListeners() {
    if (document.getElementById('options-search')) {
        document.getElementById('options-search').addEventListener("input", search);
        document.getElementById('options-filter-all').addEventListener("click", search);
        document.getElementById('options-filter-build').addEventListener("click", search);
        document.getElementById('options-filter-config').addEventListener("click", search);
    }
}

function search() {
    var search = document.getElementById('options-search').value;
    var filter;

    for (var b of document.getElementsByName("options-filter")) {
        if (b.checked) {
            filter = b.value;
        }
    }

    updateUrlQuery(search, filter);

    for (var k of document.getElementsByClassName('options-key')) {
        showOption(search, filter, k);
    }

    hideEmptyCategories();
}

function showOption(search, filter, optionKey) {
    var container = optionKey;
    while (container != null && container.nodeName != 'TR') {
        container = container.parentElement;
    }

    show = false;
    if (search) {
        if(container.innerText.toLowerCase().indexOf(search) != -1) {
            show = true;
        }
    } else {
        show = true;
    }

    if (show && filter) {
        if (filter == 'build') {
            show = container.querySelector('.options-build');
        } else if (filter == 'config') {
            show = !container.querySelector('.options-build');
        }
    }

    if (show) {
        container.classList.add('options-show');
        container.classList.remove('options-hide');
    } else {
        container.classList.remove('options-show');
        container.classList.add('options-hide');
    }
}

function hideEmptyCategories() {
    var categories = document.getElementsByClassName("sect1");
    for (var category of categories) {
        if (category.querySelector('.options-show')) {
            category.classList.remove('d-none');
        } else {
            category.classList.add('d-none');
        }
    }
}

