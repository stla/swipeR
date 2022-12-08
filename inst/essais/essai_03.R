library(swipeR)
library(htmltools)

wrapper <- swipeRwrapper(
  tags$div(
    class = "swiper-zoom-container",
    tags$img(src = "https://swiperjs.com/demos/images/nature-1.jpg")
  ),
  tags$div(
    class = "swiper-zoom-container",
    tags$img(src = "https://swiperjs.com/demos/images/nature-2.jpg")
  ),
  tags$div(
    class = "swiper-zoom-container",
    tags$img(src = "https://swiperjs.com/demos/images/nature-3.jpg")
  ),
  tags$div(
    class = "swiper-zoom-container",
    tags$img(src = "https://swiperjs.com/demos/images/nature-4.jpg")
  )
)

swipeR(
  wrapper, height = "500px", width = "70%"
)


