


sigmaGraphOpts <- function(){
  list(
    data = list(
      nodesSizeVar = "size",
      nodesColorVar = "color",
      nodesLabelVar = "label",
      nodesPositionX = "x",
      nodesPositionY = "y",
      edgesSourceVar = "source",
      edgesTargetVar = "target",
      edgesSizeVar = "size",
      edgesLabelVar = "label",
      edgesTypeVar = "curvedArrow",
      noSingleNodes = FALSE
    ),
    defaultNodeColor = "#cccccc",
    palette = "Set2",
    plugins = list(
      dragNoes = TRUE
    ),
    sigma = list(
      font = 'robotoregular',
      minNodeSize = 3,
      maxNodeSize = 8,
      minEdgeSize = 1,
      maxEdgeSize = 1.5,
      enableEdgeHovering = FALSE,
      edgeHoverSizeRatio = 2,
      edgeHoverColor = 'edge',
      defaultEdgeLabelSize = 10,
      defaultEdgeHoverColor = '#35393a',
      defaultHoverLabelBGColor = '#35393a',
      defaultLabelColor = "#999",
      defaultEdgeLabelColor = "#c7c5c4",
      defaultEdgeLabelBGColor = "#454849",
      defaultLabelHoverColor = "#c7c5c4",
      edgeHoverHighlightNodes = 'circle',
      #     doubleClickEnabled = FALSE,
      labelHoverShadow = '',
      defaultLabelSize = 12,
      labelThreshold = 3,
      drawEdgeLabels = FALSE,
      # defaultEdgeHoverColor = '#000',
      edgeHoverExtremities = TRUE,
      # edgeHoverPrecision = 3,
      # # ADD when auto curving parallel edges. Doesn't work with tapered edges
      # autoCurveSortByDirection = FALSE,
      mouseWheelEnabled = FALSE,
      sideMargin = 40,
      zoomingRatio = 1.1,
      # zoomMin = 0.05,
      # zoomMax = 50,
      # autoRescale = ['nodeSize', 'edgeSize'],
      nodesPowRatio = 0.1,
      edgeLabelSize = 'fixed',
      edgeLabelThreshold = 3,
      autoCurveRatio = 1
    )
  )
}

parseOpts <- function(opts = NULL, ...){
  .dotOpts <- list(...)
  if(!is.empty(opts)){
    if(!is.empty(.dotOpts)){
      opts <- modifyList(opts,.dotOpts)
    }
    opts <- modifyList(sigmaGraphOpts(),opts)
  }else{
    if(!is.empty(.dotOpts)){
      opts <- modifyList(sigmaGraphOpts(),.dotOpts)
    }else{
      opts <- sigmaGraphOpts()
    }
  }
  opts
}
