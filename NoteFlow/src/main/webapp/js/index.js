document.getElementById("tagsContainer").addEventListener("scroll", function () {
    if (this.scrollLeft > 0) {
        document.getElementById("tagsWrapper").classList.add("scroll-shadow-e");
    } else {
        document.getElementById("tagsWrapper").classList.remove("scroll-shadow-e");
    }

    if (this.scrollLeft + this.offsetWidth < this.scrollWidth) {
        document.getElementById("tagsWrapper").classList.add("scroll-shadow-s");
    } else {
        document.getElementById("tagsWrapper").classList.remove("scroll-shadow-s");
    }
});

document.getElementById("tagsContainer").addEventListener("hover", function () {
    // if scroll possible, add px
    if (this.scrollWidth != this.offsetWidth) {
        document.getElementById("tagsWrapper").classList.add("md:pe-4");
    }
});

