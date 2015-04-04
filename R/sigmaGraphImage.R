#' @import htmlwidgets
#' @export
sigmaGraphImage <- function(edges, nodes = NULL, options = list(),
                             width = NULL, height = NULL) {
  
  if (is.null(nodes$imageUrl)){
    message("No imageUrl provided: using default")
    nodes$imageUrl <- "http://shiny.rstudio.com/tutorial/lesson2/www/bigorb.png"
  }
  
  data <- cleanGraph(edges, nodes)  
  
  drawEdges = TRUE
  drawNodes = TRUE  
  settings <- list(
    drawEdges = drawEdges,
    drawNodes = drawNodes
  )  
  # pass the data and settings using 'x'
  x <- list(
    data = data,
    settings = settings
  )  
  # create the widget
  htmlwidgets::createWidget("sigmaGraphImage", x, width = width, height = height, package="sigmaGraph")
}

#' @export
sigmaGraphImageOutput <- function(outputId, width = "100%", height = "500px") {
  shinyWidgetOutput(outputId, "sigmaGraphImage", width, height, package = "sigmaGraph")
}

#' @export
renderSigmaGraphImage <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, sigmaGraphImageOutput, env, quoted = TRUE)
}
