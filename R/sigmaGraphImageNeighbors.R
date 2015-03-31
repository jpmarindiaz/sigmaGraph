#' @import htmlwidgets
#' @export
sigmaGraphImageNeighbors <- function(edges, nodes = NULL, options = list(),
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
  htmlwidgets::createWidget("sigmaGraphImageNeighbors", x, width = width, height = height, package="sigmaGraph")
}

#' @export
sigmaGraphNeighborsOutput <- function(outputId, width = "100%", height = "400px") {
  shinyWidgetOutput(outputId, "sigmaGraphImageNeighbors", width, height, package = "sigmaGraph")
}

#' @export
renderSigmaGraphNeighbors <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, sigmaGraphImageNeighborsOutput, env, quoted = TRUE)
}


