library(swipeR)
library(htmltools)

wrapper <- swipeRwrapper(
  tags$img(src = "https://swiperjs.com/demos/images/nature-1.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-2.jpg")
)

swipeR(wrapper, height = "100%")
