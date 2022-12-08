library(swipeR)
library(shiny)
library(ggplot2)
library(htmlwidgets)

wrapper1 <- swipeRwrapper(
  tags$img(src = "https://swiperjs.com/demos/images/nature-1.jpg", height = "400px"),
  tags$img(src = "https://swiperjs.com/demos/images/nature-2.jpg", height = "400px")
)

wrapper <- swipeRwrapper(
  div(actionButton("btn", "Click me"), align = "center"),
  div(textInput("txt", "Write something"), align = "center"),
  div(plotOutput("ggplot", width = "70%", height = "300px"), align = "center")
)

ui <- fluidPage(
  swipeR(wrapper, height = "auto", width = "80%", effect = "cube", speed = 2000),
  swipeR(wrapper1, height = "450px",
         on = list(slideChange = JS("function(s){alert('s');}")))
)

server <- function(input, output, session) {
  output[["ggplot"]] <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point()
  })
}

shinyApp(ui, server)


