#' Title
#'
#' @param ... elements
#'
#' @return xx
#' @export
#' @importFrom htmltools div
swipeRwrapper <- function(...) {
  elements <- list(...)
  do.call(
    function(...) {
      div(class = "swiper-wrapper", ...)
    },
    lapply(elements, function(el) {
      div(class = "swiper-slide", el)
    })
  )
}

#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
swipeR <- function(
    wrapper, width = "100%", height = "100%",
    id = NULL, direction = "horizontal", effect = "slide",
    initialSlide = 1, loop = FALSE, rewind = FALSE,
    slidesPerView = 1, spaceBetween = 30, speed = 300,
    scrollbar = FALSE, autoplay = FALSE,
    thumbs = FALSE, thumbsPerView = 2, thumbsHeight = "60px",
    on = NULL,
    elementId = NULL
) {
  x <- list(
    "html"                = swiperDiv(wrapper, id, width, height, scrollbar),
    "thumbs"              = if(thumbs) thumbsDiv(wrapper, width, thumbsHeight),
    "thumbsPerView"       = thumbsPerView,
    "direction"           = match.arg(direction, c("horizontal", "vertical")),
    "effect"              =
      match.arg(
        effect,
        c("slide", "fade", "cube", "coverflow", "flip", "cards")
      ),
    "initialSlide"        = initialSlide - 1,
    "loop"                = loop,
    "rewind"              = rewind && !loop,
    "slidesPerView"       = slidesPerView,
    "spaceBetween"        = spaceBetween,
    "speed"               = speed,
    "scrollbar"           = scrollbar,
    "autoplay"            = autoplay,
    "on"                  = on
  )

  # create widget
  htmlwidgets::createWidget(
    name = "swipeR",
    x,
    width = NULL,
    height = NULL,
    package = "swipeR",
    elementId = elementId
  )
}

#' Shiny bindings for swipeR
#'
#' Output and render functions for using swipeR within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a swipeR
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name swipeR-shiny
#'
#' @export
swipeROutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "swipeR", width, height, package = "swipeR")
}

#' @rdname swipeR-shiny
#' @export
renderSwipeR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, swipeROutput, env, quoted = TRUE)
}
