#' @import htmlwidgets
#' @export
sigmaGraph <- function(edges, nodes, options = list(),
                       width = NULL, height = NULL) {  
  # read the gexf file
  g <- list(nodes=nodes, edges=edges)    
  data <- g  
  data <- RJSONIO::fromJSON(datapackager::listToJSON(g))
  
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
  htmlwidgets::createWidget("sigmaGraph", x, width = width, height = height)
}

#' @export
sigmaGraphOutput <- function(outputId, width = "100%", height = "500px") {
  shinyWidgetOutput(outputId, "sigmaGraph", width, height, package = "sigmaGraph")
}

#' @export
renderSigmaGraph <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, sigmaGraphOutput, env, quoted = TRUE)
}


