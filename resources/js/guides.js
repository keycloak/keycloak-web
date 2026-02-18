window.onload = function() {
    document.getElementById('guide-search').addEventListener("input", search);
    document.getElementById('guide-category-search').addEventListener("change", search);

    var params = new URLSearchParams(window.location.search);
    var q = params.get('q');
    var c = params.get('c');
    if (q || c) {
        document.getElementById('guide-search').value = q;
        document.getElementById('guide-category-search').value = c;
        search();
    }
}

function search() {
    var search = document.getElementById('guide-search').value;
    var categorySearch = document.getElementById('guide-category-search').value;
    var cards = document.getElementsByClassName("card");
    var show = true;

    searchCards(search, categorySearch, cards);
    updateUrlQuery(search, categorySearch);
}

function updateUrlQuery(search, categorySearch) {
    var query = '';
    if (search) {
        query = 'q=' + search;
    }
    if (categorySearch) {
        if (search) {
            query += "&";
        }
        query += 'c=' + categorySearch;
    }

    query = '?' + query;

    var url = window.location.toString();
    if (url.indexOf('?') != -1) {
        url = url.substring(0, url.indexOf('?'));
    }

    history.replaceState(null, null, url + query);
}

function searchCards(search, categorySearch, cards) {
    for (var i = 0; i < cards.length; i++) {
        var card = cards[i];

        var showCategory = true;
        var show = false;
        var c = card.children;

        if (categorySearch && card.closest(".guide-category").id != categorySearch) {
            showCategory = false;
        }

        if (showCategory && search) {
            for (var j = 0; j < c.length; j++) {
                if (c[j].innerText.toLowerCase().indexOf(search) != -1) {
                    show = true;
                }
            }
        } else {
            show = showCategory;
        }

        if (show) {
            card.parentElement.classList.remove("d-none");
            card.parentElement.classList.add("d-block");
        } else {
            card.parentElement.classList.add("d-none");
            card.parentElement.classList.remove("d-block");
        }
    }

    var categories = document.getElementsByClassName("guide-category");
    for (var i = 0; i < categories.length; i++) {
        var category = categories[i];
        var show = category.getElementsByClassName('d-block').length > 0;

        if (show) {
            category.classList.remove("d-none");
            category.classList.add("d-flex");
        } else {
            category.classList.add("d-none");
            category.classList.remove("d-flex");
        }
    }
}