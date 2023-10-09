library(swipeR)
library(shiny)
library(shinyWidgets)
library(ggplot2)
library(ggthemes)

wrapper <- swipeRwrapper(
  div(
    fluidRow(
      column(
        6,
        awesomeRadio(
          "theme", "Choose a theme",
          c(
            "Calc",
            "Clean",
            "Economist",
            "Excel",
            "FiveThirtyEight",
            "Foundation",
            "Google Docs",
            "Highcharts",
            "Pander",
            "Solarized",
            "Stata",
            "Wall Street"
          )
        )
      ),
      column(
        6,
        tags$p("The Shiny slider does not work here..."),
        tags$div(
          class = "swiper-no-swiping",
          sliderInput(
            inputId = "slider", label = "Base font size:",
            value = 12, min = 10, max = 20
          )
        ),
        tags$output("12", style = "font-weight: bold; color: blue"),
        br(), hr(), br(),
        materialSwitch("facets", "Facets?", status = "info"),
        conditionalPanel(
          condition = "input.facets",
          awesomeRadio(
            "direction", label = NULL, status = "info",
            choices = c("by row" = "row", "by column" = "column"),
          )
        ),
        br(), hr(), br(),
        actionButton(
          "btn", "Add slide", class = "btn-primary btn-block",
          onclick = "document.getElementById('SWIPER').swiper.appendSlide(
            '<div class=\"swiper-slide rlogo\"></div>');
            Shiny.setInputValue('newslide', true, {priority: 'event'});"
        )
      )
    ),
    style = "margin-left: 10%; margin-right: 10%; font-size: 2rem;"
  ),
  div(
    plotOutput("ggplot", width = "85%", height = "400px"),
    align = "center"
  )
)

ui <- fluidPage(
  tags$head(
    tags$style(HTML(
      ".shiny-plot-output {
          border: 2px solid royalblue;
      }
      .shiny-text-output {
          font-size: 30px;
          font-style: italic;
      }
      .recalculating {
         display: none; /* otherwise there's a flash */
      }
      .rlogo {
         width: 100%;
         height: 100%;
         background-image: url(https://www.r-project.org/logo/Rlogo.png);
         background-repeat: no-repeat;
         background-size: contain;
         background-position: center;
      }"
    ))
  ),
  br(), br(), br(),
  fluidRow(
    column(
      12,
      swipeR(
        wrapper, id = "SWIPER", height = "450px", width = "90%", effect = "flip",
        navigationColor = "black", paginationColor = "black", rewind = TRUE,
        on = list(
          afterInit = htmlwidgets::JS(
            "function(swiper) {
               setTimeout(function(){ Shiny.setInputValue('index', 1); }, 0);
            }"
          ),
          slideChange = htmlwidgets::JS(
            "function(swiper) {
               Shiny.setInputValue('index', swiper.activeIndex + 1);
            }"
          )
        )
      )
    ),
    column(
      12,
      textOutput("slideIndex")
    )
  )
)

server <- function(input, output, session) {

  ggtheme <- reactive({
    size <- input[["slider"]]
    print(input[["slider"]])
    size <- if(is.null(size)) 12 else as.integer(size)
    switch(
      input[["theme"]],
      "Calc"            = theme_calc(base_size = size),
      "Clean"           = theme_clean(base_size = size),
      "Economist"       = theme_economist(base_size = size),
      "Excel"           = theme_excel_new(base_size = size),
      "FiveThirtyEight" = theme_fivethirtyeight(base_size = size),
      "Foundation"      = theme_foundation(base_size = size),
      "Google Docs"     = theme_gdocs(base_size = size),
      "Highcharts"      = theme_hc(base_size = size),
      "Pander"          = theme_pander(base_size = size),
      "Solarized"       = theme_solarized(base_size = size),
      "Stata"           = theme_stata(base_size = size),
      "Wall Street"     = theme_wsj(base_size = size)
    )
  })

  output[["ggplot"]] <- renderPlot({
    gg <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
      geom_point(size = 6) + ggtheme()
    if(input[["facets"]]) {
      if(input[["direction"]] == "row") {
        gg <- gg + facet_grid(rows = vars(Species))
      } else {
        gg <- gg + facet_grid(cols = vars(Species))
      }
    }
    gg
  })

  nSlides <- reactiveVal(2)
  observeEvent(input[["newslide"]], {
    nSlides(nSlides() + 1)
  })

  output[["slideIndex"]] <- renderText({
    paste0(input[["index"]], "/", nSlides())
  })

}

shinyApp(ui, server)


