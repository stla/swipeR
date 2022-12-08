library(swipeR)
library(htmltools)

wrapper <- swipeRwrapper(
  tags$img(src = "https://swiperjs.com/demos/images/nature-1.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-2.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-3.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-4.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-5.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-6.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-7.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-8.jpg")
)

swipeR(
  wrapper, height = "500px", width = "70%", thumbs = TRUE, thumbsPerView = 4,
  on = list(reachEnd = htmlwidgets::JS("function() {alert('the end');}"))
)


