#' @importFrom htmltools renderTags div css validateCssUnit
swiperDiv <- function(
    wrapper, id, width, height, scrollbar,
    navigationColor, paginationColor, bulletsSize
) {
  style <- css(
    width = validateCssUnit(width),
    height = validateCssUnit(height),
    `--swiper-navigation-color` = navigationColor,
    `--swiper-pagination-color` = paginationColor,
    `--swiper-pagination-bullet-size` = validateCssUnit(bulletsSize)
  )
  if(scrollbar) {
    scrollbarDiv <- div(class = "swiper-scrollbar")
  } else {
    scrollbarDiv <- NULL
  }
  renderTags(
    div(
      id = id,
      class = "swiper",
      style = style,
      wrapper,
      div(class = "swiper-button-next"),
      div(class = "swiper-button-prev"),
      div(class = "swiper-pagination"),
      scrollbarDiv
    )
  )
}

thumbsDiv <- function(wrapper, width, height) {
  style <- css(
    width = validateCssUnit(width),
    height = validateCssUnit(height)
  )
  renderTags(
    div(
      class = "swiper swiper-thumbs",
      style = style,
      wrapper
    )
  )[["html"]]
}

randomId <- function(size) {
  paste0(
    c("id", sample(c(letters, LETTERS, 0L:9L), size, replace = TRUE)),
    collapse = ""
  )
}

