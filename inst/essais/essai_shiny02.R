library(swipeR)
library(shiny)
library(ggplot2)

wrapper <- swipeRwrapper(
  div(
    plotOutput("ggplot1", width = "75%", height = "400px"),
    align = "center"
  ),
  div(
    plotOutput("ggplot2", width = "75%", height = "400px"),
    align = "center"
  ),
  div(
    plotOutput("ggplot3", width = "75%", height = "400px"),
    align = "center"
  ),
  div(
    plotOutput("ggplot4", width = "75%", height = "400px"),
    align = "center"
  )
)

ui <- fluidPage(
  tags$head(
    tags$style(HTML(
      ".shiny-plot-output {
          border: 2px solid royalblue;
      }"
    ))
  ),
  br(), br(), br(),
  fluidRow(
    column(
      12,
      swipeR(
        wrapper, height = "450px", width = "80%", effect = "cube", speed = 2000,
        navigationColor = "black", rewind = TRUE, id = "CAROUSEL"
      )
    ),
    column(
      12,
      br(), br(), br(),
    ),
    column(
      3, align = "center",
      actionButton(
        "btn1", "Scatter plot", class = "btn-primary",
        onclick = "document.getElementById('CAROUSEL').swiper.slideTo(0);"
      )
    ),
    column(
      3, align = "center",
      actionButton(
        "btn2", "Line chart", class = "btn-primary",
        onclick = "document.getElementById('CAROUSEL').swiper.slideTo(1);"
      )
    ),
    column(
      3, align = "center",
      actionButton(
        "btn3", "Bar chart", class = "btn-primary",
        onclick = "document.getElementById('CAROUSEL').swiper.slideTo(2);"
      )
    ),
    column(
      3, align = "center",
      actionButton(
        "btn4", "Boxplots", class = "btn-primary",
        onclick = "document.getElementById('CAROUSEL').swiper.slideTo(3);"
      )
    )
  )
)

server <- function(input, output, session) {
  output[["ggplot1"]] <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point() +
      theme(panel.border = element_rect(fill = NA, color = "firebrick"))
  })
  output[["ggplot2"]] <- renderPlot({
    ggplot(economics, aes(date, unemploy)) + geom_line()
  })
  output[["ggplot3"]] <- renderPlot({
    ggplot(mpg, aes(class)) + geom_bar()
  })
  output[["ggplot4"]] <- renderPlot({
    ggplot(mpg, aes(class, hwy)) + geom_boxplot()
  })
}

shinyApp(ui, server)


