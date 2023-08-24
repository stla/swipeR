library(shiny)
library(swipeR)
library(shinyjs)

js <- function(bool) {
  paste(
    "var swpr = document.getElementById('CAROUSEL').swiper;",
    sprintf(
      "var istab1 = %s;", tolower(bool)
    ),
    "if(istab1) {",
    "  swpr.slideTo(0, 100, false);",
    "  swpr.start();",
    "} else {",
    "  swpr.stop();",
    "}",
    sep = "\n"
  )
}

wrapper <- swipeRwrapper(
  tags$img(src = "img1.png", width = "300", height = "300"),
  tags$img(src = "img2.png", width = "300", height = "300"),
  tags$img(src = "img3.png", width = "300", height = "300"),
  tags$img(src = "img4.png", width = "300", height = "300")
)


ui <- shiny::basicPage(
  useShinyjs(),

  tabsetPanel(
    id = "tabset",
    tabPanel(
      "Carousel",
      value = "tab1",
      swipeR(
        wrapper, height = "500px", width = "500px",
        autoplay = list(delay = 1500, disableOnInteraction = FALSE),
        id = "CAROUSEL"
      ),
    ),
    tabPanel(
      "Nothing",
      value = "tab2"
    )
  )
)

server <- function(input, output) {

  observeEvent(input[["tabset"]], {
    runjs(js(input[["tabset"]] == "tab1"))
  }, ignoreInit = TRUE)

}

shinyApp(ui, server)
