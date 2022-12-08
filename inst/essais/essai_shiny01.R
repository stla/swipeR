library(swipeR)
library(shiny)
library(ggplot2)
library(htmlwidgets)

wrapper1 <- swipeRwrapper(
  tags$img(src = "https://swiperjs.com/demos/images/nature-1.jpg"),#, height = "400px"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-2.jpg"),#, height = "400px"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-1.jpg"),# height = "400px"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-2.jpg")#, height = "400px")
)

wrapper <- swipeRwrapper(
  div(
    actionButton(
      "btn", "Click me",
      onclick = "document.getElementById('MYSWIPER').swiper.slideNext();"
    ),
    align = "center"
  ),
  div(textInput("txt", "Write something"), align = "center", style = "top: 150px;"),
  div(plotOutput("ggplot", width = "70%", height = "300px"), align = "center")
)

ui <- fluidPage(
  #swipeR(wrapper, height = "400px", width = "80%", effect = "cube", speed = 2000, id = "MYSWIPER"),
  swipeR(wrapper1, height = "450px", width = "70%", thumbs = TRUE,
         on = list(slideChange = JS("function(s){alert('s');}")))
)

server <- function(input, output, session) {
  output[["ggplot"]] <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point()
  })
}

shinyApp(ui, server)


