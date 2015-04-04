#' @import htmlwidgets
#' @export
sigmaGraphSimple <- function(edges, nodes = NULL, options = list(),
                             width = NULL, height = NULL) {
  
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
  htmlwidgets::createWidget("sigmaGraphSimple", x, width = width, height = height, package="sigmaGraph")
}

#' @export
sigmaGraphSimpleOutput <- function(outputId, width = "100%", height = "500px") {
  shinyWidgetOutput(outputId, "sigmaGraphSimple", width, height, package = "sigmaGraph")
}

#' @export
renderSigmaGraphSimple <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, sigmaGraphSimpleOutput, env, quoted = TRUE)
}