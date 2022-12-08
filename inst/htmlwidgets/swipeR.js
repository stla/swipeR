HTMLWidgets.widget({
  name: "swipeR",

  type: "output",

  factory: function(el, width, height) {
    var parser = new DOMParser();

    return {
      renderValue: function(x) {
        var doc = parser.parseFromString(x.html, "text/html");
        el.innerHTML = doc.body.innerHTML;

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
          cubeEffect: {
            shadow: true,
            slideShadows: true,
            shadowOffset: 20,
            shadowScale: 0.94
          },
          initialSlide: x.initialSlide,
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

        var swiper = new Swiper(el.firstElementChild, opts);

      },

      resize: function (width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
