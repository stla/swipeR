HTMLWidgets.widget({
  name: "swipeR",

  type: "output",

  factory: function(el, width, height) {
    var parser = new DOMParser();

    return {
      renderValue: function(x) {
        var doc = parser.parseFromString(x.html, "text/html");
        el.innerHTML = doc.body.innerHTML;
        if(x.thumbs) {
          var thumbs = parser.parseFromString(x.thumbs, "text/html");
          el.appendChild(thumbs.body.firstElementChild);
        }

        var scrollbar = false;
        if(x.scrollbar) {
          scrollbar = {
            el: '.swiper-scrollbar',
            draggable: true
          };
        }

        var opts = {
          direction: x.direction,
          effect: x.effect,
          grabCursor: x.effect === "cube" || x.effect === "cards",
          cubeEffect: x.cubeEffect,
          initialSlide: x.initialSlide,
          zoom: x.zoom,
          loop: x.loop,
          rewind: x.rewind,
          slidesPerView: x.slidesPerView,
          spaceBetween: x.spaceBetween,
          speed: x.speed,
          scrollbar: scrollbar,
          autoplay: x.autoplay,
          navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
          },
          pagination: {
            el: ".swiper-pagination",
            clickable: true
          }
        };

        if(x.on) {
          opts.on = x.on;
        }

        if(x.thumbs) {
          var swiperThumbs = new Swiper(el.lastElementChild, {
            slidesPerView: x.thumbsPerView,
            freeMode: true,
            watchSlidesProgress: true
          });
          opts.thumbs = {swiper: swiperThumbs};
        }

        var swiper = new Swiper(el.firstElementChild, opts);

      },

      resize: function (width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
