


sigmaGraphOpts <- function(){
  list(
    data = list(
      nodesSizeVar = "size",
      nodesColorVar = "color",
      nodesLabelVar = "label",
      nodesImageVar = "image",
      nodesPositionX = "x",
      nodesPositionY = "y",
      edgesSourceVar = "source",
      edgesTargetVar = "target",
      edgesSizeVar = "size",
      edgesLabelVar = "label",
      edgesTypeVar = "type",
      noSingleNodes = FALSE
    ),
    defaultNodeColor = "#cccccc",
    palette = "Set2",
    plugins = list(
      dragNodes = TRUE,
      forceAtlas = FALSE,
      forceAtlasTime = 2000,
      images = FALSE,
      neighbors = FALSE
    ),
    sigma = list(
      font = 'robotoregular',
      drawLabels = TRUE,
      drawNodes = TRUE,
      drawEdges = TRUE,
      drawEdgeLabels = FALSE,
      minNodeSize = 5,
      maxNodeSize = 10,
      minEdgeSize = 2,
      maxEdgeSize = 5,
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
      defaultLabelSize = 10,
      labelThreshold = 0,
      # defaultEdgeHoverColor = '#000',
      edgeHoverExtremities = TRUE,
      # edgeHoverPrecision = 3,
      # # ADD when auto curving parallel edges. Doesn't work with tapered edges
      # autoCurveSortByDirection = FALSE,
      mouseWheelEnabled = FALSE,
      sideMargin = 0,
      zoomingRatio = 1.1,
      # zoomMin = 0.05,
      # zoomMax = 50,
      # autoRescale = ['nodeSize', 'edgeSize'],
      nodesPowRatio = 0.5,
      edgeLabelSize = 'fixed',
      edgeLabelThreshold = 0,
      autoCurveRatio = 0,
      imageThreshold = 0,
      defaultEdgeType = 'tapered'
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
