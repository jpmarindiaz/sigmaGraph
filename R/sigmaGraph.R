
#' @export
sigmaGraph <- function(d, nodes = NULL, opts = NULL,
                       width = NULL, height = NULL, ...) {

  opts <- parseOpts(opts = opts, ...)
  edges <- d
  if(is.null(nodes))
    data <- cleanGraph(edges)
  else{
    noSingleNodes <- FALSE
    data <- cleanGraph(edges, nodes = nodes, opts = opts)
  }

  settings <- opts

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


