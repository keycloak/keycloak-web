window.onload = init;

function init() {
    document.getElementById('guide-search').addEventListener("input", search);
}

function search(e) {
    var search = e.path[0].value.toLowerCase();

    var cards = document.getElementsByClassName("card");
    var show = true;

    searchCards(search, cards);
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
