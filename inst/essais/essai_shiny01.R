library(swipeR)
library(shiny)
library(ggplot2)
library(htmlwidgets)

wrapper1 <- swipeRwrapper(
  tags$img(src = "https://swiperjs.com/demos/images/nature-1.jpg"),#, height = "400px"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-2.jpg"),#, height = "400px"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-3.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-4.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-5.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-6.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-7.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-8.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-9.jpg"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-10.jpg")
)

wrapper <- swipeRwrapper(
  div(
    actionButton(
      "btn", "Click me",
      onclick = "var s = document.getElementById('UUU').swiper; var el = s.el; console.log(el); var opts = s.params; console.log(opts); opts.effect = 'fade'; s.destroy(true, true); var ss = new Swiper(el, opts); "
    ),
    align = "center"
  ),
  div(textInput("txt", "Write something"), align = "center", style = "top: 150px;"),
  div(plotOutput("ggplot", width = "70%", height = "300px"), align = "center")
)

ui <- fluidPage(
  swipeR(wrapper, height = "400px", width = "80%", effect = "cube", speed = 2000, id = "MYSWIPER"),
  swipeR(wrapper1, height = "450px", width = "70%", thumbs = TRUE, id = "UUU",
         on = list(slideChange = JS("function(s){alert('s');}")))
)

server <- function(input, output, session) {
  output[["ggplot"]] <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point()
  })
}

shinyApp(ui, server)


