#' @import htmlwidgets
#' @export
sigmaGraphDrag <- function(edges, nodes = NULL, options = list(),
                            width = NULL, height = NULL) {
  
  # read the gexf file
  #   g <- list(nodes=nodes, edges=edges)    
  #   data <- g  
  #   data <- RJSONIO::fromJSON(datapackager::listToJSON(g))
  
  data <- cleanGraph(edges, nodes)
  
  # create a list that contains the settings
  
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
  htmlwidgets::createWidget("sigmaGraphDrag", x, width = width, height = height, package="sigmaGraph")
}

#' @export
sigmaGraphDragOutput <- function(outputId, width = "100%", height = "500px") {
  shinyWidgetOutput(outputId, "sigmaGraphDrag", width, height, package = "sigmaGraph")
}

#' @export
renderSigmaGraphDrag <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, sigmaGraphDragOutput, env, quoted = TRUE)
}


