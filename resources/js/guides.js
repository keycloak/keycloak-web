window.onload = function() {
    document.getElementById('guide-search').addEventListener("input", search);

    var params = new URLSearchParams(window.location.search);
    var q = params.get('q');
    if (q) {
        document.getElementById('guide-search').value = q;
        search();
    }
}

function search() {
    var search = document.getElementById('guide-search').value;
    var cards = document.getElementsByClassName("card");
    var show = true;

    searchCards(search, cards);
    updateUrlQuery(search);
}

function updateUrlQuery(search) {
    var query = '';
    if (search) {
        query = '?q=' + search;
    }

    var url = window.location.toString();
    if (url.indexOf('?') != -1) {
        url = url.substring(0, url.indexOf('?'));
    }

    history.replaceState(null, null, url + query);
}

function searchCards(search, cards) {
    for (var i = 0; i < cards.length; i++) {
        var card = cards[i];

        var show = false;
        var c = card.children;

        if (search) {
            for (var j = 0; j < c.length; j++) {
                if (c[j].innerText.toLowerCase().indexOf(search) != -1) {
                    show = true;
                }
            }
        } else {
            show = true;
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