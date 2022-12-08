#' @importFrom htmltools renderTags div css validateCssUnit
swiperDiv <- function(wrapper, width, height, scrollbar) {
  style <- css(width = validateCssUnit(width), height = validateCssUnit(height))
  if(scrollbar) {
    scrollbarDiv <- div(class = "swiper-scrollbar")
  } else {
    scrollbarDiv <- NULL
  }
  renderTags(
    div(
      class = "swiper",
      style = style,
      wrapper,
      div(class = "swiper-button-next"),
      div(class = "swiper-button-prev"),
      div(class = "swiper-pagination"),
      scrollbarDiv
    )
  )[["html"]]
}


