# swipeR

![](https://raw.githubusercontent.com/stla/swipeR/main/inst/gifs/swipeR-images.gif)

![](https://raw.githubusercontent.com/stla/swipeR/main/inst/gifs/swipeR-shiny.gif)

![](https://raw.githubusercontent.com/stla/swipeR/main/inst/gifs/swipeR-shiny2.gif)

To include an image in a carousel from a file, you can use **base64** encoding:

    ```{r}
    library(swipeR)
    library(htmltools)
    library(base64enc)
    b64 <- dataURI(file = "path_to_image.png", mime = "image/png")
    wrapper <- swipeRwrapper(
      tags$img(src = b64, style = "width: 500px; margin: auto;"),
      ......
    )
    swipeR(wrapper, height = "400px", navigationColor = "navy")
    ```
