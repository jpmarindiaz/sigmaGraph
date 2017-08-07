cleanGraph <- function(edges, nodes = NULL, opts = NULL){
  #opts <- sigmaGraph:::parseOpts(opts)
  if (is.null(edges)){
    stop("No edges data.frame")
  }
  if(is.null(opts))
    opts <- sigmaGraphOpts()

  sourceVar <- opts$data$edgesSourceVar
  if(!sourceVar %in% names(edges))
    stop("No source var in edges")
  targetVar <- opts$data$edgesTargetVar
  if(!targetVar %in% names(edges))
    stop("No target var in edges")


  nodesSizeVar <- opts$data$nodesSizeVar
  nodesColorVar <- opts$data$nodesColorVar
  nodesLabelVar <- opts$data$nodesLabelVar
  nodesImageVar <- opts$data$nodesImageVar
  nodesPositionX <- opts$data$nodesPositionX
  nodesPositionY <- opts$data$nodesPositionY

  edgesSizeVar <- opts$data$edgesSizeVar
  edgesLabelVar <- opts$data$edgesLabelVar
  edgesTypeVar <- opts$data$edgesTypeVar

  edges$id <-paste0("e",1:nrow(edges))
  #edges <- edges %>% select_(.dots = c("id",sourceVar, targetVar))
  #names(edges) <- c("id","source","target")
  edges <- edges %>% select(id, c("id",sourceVar, targetVar), everything())

  if(any_row_with_na(edges))
    warning("Removing edges with NA in source or target")

  edges <- edges %>% filter(!is.na(source), !is.na(target))
  edges <- fct_to_chr(edges)
  edges <- num_to_chr(edges)

  noSingleNodes <- opts$data$noSingleNodes %||% TRUE


  if (is.null(nodes)){
    message("No nodes provided: taking nodes from unique edges")
    n <- unique(c(as.character(edges$source), as.character(edges$target)))
    nodes <- data.frame(id = n)
  } else{
    nodes$id <- as.character(nodes$id)
  }
  nodes <- fct_to_chr(nodes)
  #if(class(c(edges$source,edges$target)) != class(nodes$id))
  #  stop("Class of edges and nodes must be the same")

  if (is.null(nodes$id)){
    stop("No node id provided")
  }

  if(!all(c(nodesPositionX, nodesPositionY) %in% names(nodes))){
    message("No node position provided: using automatic")
    nodes$x <- runif(nrow(nodes))
    nodes$y <- runif(nrow(nodes))
    #positions <- FALSE
  }

  if(nodesSizeVar %in% names(nodes)){
    nodes$size <- nodes[[nodesSizeVar]]
  }else{
    nodes$size <- 1
  }

  if(nodesColorVar %in% names(nodes)){
    nodes$color <- paletero(nodes, palette = opts$palette, by = nodesColorVar)
  }else{
    if(is.null(opts$nodesColorPalette)){
      nodes$color <- opts$defaultNodeColor
    }else{
      nodes$color <- opts$defaultNodeColor
    }
  }

  if(nodesLabelVar %in% names(nodes)){
    nodes$label <- nodes[[nodesLabelVar]]
    if(any(is.na(nodes$label)))
      warning("There are NA labels")
  }else{
    nodes$label <- nodes$id
  }

  #   if (is.null(nodes$type)){
  #     message("No node type provided: using random")
  #     ntypes <- c("diamond","square","circle","star","equilateral")
  #     nodes$type <- sample(ntypes,1)
  #   }

  #   if(is.null(edges$id)){
  #     edges$id <- paste0("e",seq(1:nrow(edges)))
  #   } else {
  #     if(length(unique(edges$id))< nrow(edges)){
  #       message("edges id not unique: overriding edges id")
  #       edges$id <- seq(1:nrow(edges))
  #     }
  #   }
  if (!edgesSizeVar %in% names(edges)){
    message("No edge size provided: using 1")
    edges$size <- 1
  }
  if(edgesLabelVar %in% names(edges)){
    edges$label <- edges[[edgesLabelVar]]
  }else{
    edges$label <- ""
    message("No edge label provided, using edge empty label.")
  }

  if(noSingleNodes){
    nodesInEdges <- nodes$id[nodes$id %in% c(edges$source,edges$target)]
    nodes <- nodes %>% filter(id %in% nodesInEdges)
  }

  if (!edgesTypeVar %in% names(edges)){
    message("No edge type provided: using curvedArrow")
    etypes <- c("line","arrow","curvedArrow","curve")
    edges$type <- "tapered"
  }

  if(opts$plugins$images){
    #opts <- modifyList(opts, list(sigma = list(labelThreshold = 0)))
    if(!nodesImageVar %in% names(nodes)){
      stop("Need image urls")
    }else{
      nodes$image <- nodes[[nodesImageVar]]
    }
  }

  if(!allEdgesNodesInNodes(edges,nodes)){
    stop("Not all source and target nodes are in nodes table")
  }

  g <- list(nodes=nodes, edges=edges)
  #g <- list(nodes=nodes, edges=edges, positions = positions, vars = vars)
  data <- g
  data
}


allEdgesNodesInNodes <- function(edges,nodes){
  n <- unique(c(as.character(edges$source), as.character(edges$target)))
  all(n %in% nodes$id)
}
