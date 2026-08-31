var pagefind = null;
var pagefindAvailable = null;
var searchId = 0;

window.onload = function() {
    var searchInput = document.getElementById('guide-search');
    var clearBtn = document.getElementById('guide-search-clear');

    searchInput.addEventListener("input", debounce(search, 300));
    searchInput.addEventListener("input", function() {
        clearBtn.hidden = !searchInput.value;
    });
    searchInput.closest('form').addEventListener("submit", function(e) {
        e.preventDefault();
        search();
    });

    clearBtn.addEventListener("click", function() {
        searchInput.value = '';
        clearBtn.hidden = true;
        search();
        searchInput.focus();
    });

    var params = new URLSearchParams(window.location.search);
    var q = params.get('q');
    if (q) {
        searchInput.value = q;
        clearBtn.hidden = false;
        search();
    }
}

function debounce(fn, delay) {
    var timer;
    return function() {
        clearTimeout(timer);
        timer = setTimeout(fn, delay);
    };
}

async function loadPagefind() {
    if (pagefindAvailable !== null) return pagefindAvailable;

    var path = document.getElementById('guide-search').getAttribute('data-pagefind');
    if (!path) {
        pagefindAvailable = false;
        return false;
    }

    try {
        pagefind = await import(path);
        pagefindAvailable = true;
        return true;
    } catch (e) {
        pagefindAvailable = false;
        return false;
    }
}

function setSearchLoading(loading) {
    var spinner = document.getElementById('guide-search-spinner');
    if (spinner) spinner.hidden = !loading;
}

async function search() {
    var query = document.getElementById('guide-search').value.trim();

    updateUrlQuery(query);

    var currentId = ++searchId;
    setSearchLoading(query);
    try {
        await loadPagefind();
        await pagefindSearch(query, currentId);
    } finally {
        if (currentId === searchId) {
            setSearchLoading(false);
        }
    }
}

async function pagefindSearch(query, currentId) {
    var cardContainer = document.getElementById('guide-cards');
    var resultsContainer = document.getElementById('pagefind-results');

    if (!query) {
        cardContainer.style.display = '';
        resultsContainer.style.display = 'none';
        resultsContainer.innerHTML = '';
        return;
    }

    if (!pagefindAvailable) {
        cardContainer.style.display = 'none';
        resultsContainer.style.display = '';
        resultsContainer.innerHTML = '<p class="text-muted mt-4">Search is currently unavailable.</p>';
        return;
    }

    var version = document.getElementById('guide-search').getAttribute('data-pagefind-version');
    var searchOptions = version ? { filters: { version: version } } : {};
    var searchResult = await pagefind.search(query, searchOptions);
    if (currentId !== searchId) return;
    var results = await Promise.all(
        searchResult.results.slice(0, 20).map(function(r) { return r.data(); })
    );
    if (currentId !== searchId) return;

    cardContainer.style.display = 'none';
    resultsContainer.style.display = '';

    if (results.length === 0) {
        resultsContainer.innerHTML = '<p class="text-muted mt-4">No guides found.</p>';
        return;
    }

    var html = '';
    for (var i = 0; i < results.length; i++) {
        var r = results[i];
        var title = r.meta && r.meta.title ? r.meta.title : 'Untitled';
        var category = r.filters && r.filters.category ? r.filters.category[0] : '';
        html += '<a href="' + r.url + '" class="card shadow-sm mb-3 text-decoration-none">';
        html += '<div class="card-body">';
        html += '<h5 class="card-title link-dark">' + highlightTerms(title, query);
        if (category) {
            html += ' <span class="badge bg-light text-muted fs-xsmall">' + escapeHtml(category) + '</span>';
        }
        html += '</h5>';
        if (r.excerpt) {
            html += '<p class="card-text text-muted mb-0">' + r.excerpt + '</p>';
        }
        html += '</div></a>';
    }
    resultsContainer.innerHTML = html;
}

function highlightTerms(text, query) {
    var escaped = escapeHtml(text);
    var term = query.trim();
    if (!term) return escaped;
    var pattern = new RegExp('(' + term.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + ')', 'gi');
    return escaped.replace(pattern, '<mark>$1</mark>');
}

function escapeHtml(text) {
    var div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function updateUrlQuery(search) {
    var query = '';
    if (search) {
        query = '?q=' + encodeURIComponent(search);
    }

    var url = window.location.toString();
    if (url.indexOf('?') != -1) {
        url = url.substring(0, url.indexOf('?'));
    }

    history.replaceState(null, null, url + query);
}
