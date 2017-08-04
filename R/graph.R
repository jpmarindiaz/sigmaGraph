cleanGraph <- function(edges, nodes = NULL, opts = NULL){

  if (is.null(edges)){
    stop("No edges data.frame")
  }
  if(is.null(opts))
    stop("need to provide opts list")
  vars <- list()
  sourceVar <- opts$data$edgesSourceVar
  if(!sourceVar %in% names(edges))
    stop("No source var in edges")
  targetVar <- opts$data$edgesTargetVar
  if(!targetVar %in% names(edges))
    stop("No target var in edges")
  edges <- edges %>% select_(.dots = c(sourceVar, targetVar))
  names(edges) <- c("source","target")

  if(any_row_with_na(edges))
    warning("Removing edges with NA")

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
  if(class(c(edges$source,edges$target)) != class(nodes$id))
    stop("Class of edges and nodes must be the same")

  if (is.null(nodes$id)){
    stop("No node id provided")
  }

  #   if (is.null(nodes$label)){
  #     message("No node labels provided: using labels as id")
  #     nodes$label <- nodes$id
  #   }

  if (is.null(nodes$x) || is.null(nodes$y)){
    message("No node position provided: using automatic")
    positions <- FALSE
  }

  if(!is.null(nodeSizeVar)){
    nodes$size <- nodes[[nodeSizeVar]]
  }else{
    nodeSizeVar <- "size"
  }

  if (is.null(nodes$size)){
    message("No node size provided: using random value")
    nodes$size <- 1
  }else{
    vars$size <- nodeSizeVar
  }

  if (is.null(nodeColorVar)){
    if(is.null(nodes$color)){
      nodes$color <- "#FE34A0"
    }
  }else{
    if(!nodeColorVar %in% names(nodes))
      stop("nodeColorVar not in nodes")
    nodes$color <- getColors(nodes[[nodeColorVar]], palette)
  }

  if(is.null(nodes$label)){
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
  if (is.null(edges$size)){
    message("No edge size provided: using 1")
    edges$size <- 1
  }
  if (is.null(edges$label)){
    message("No edge label provided")
    edges$label <- ""
  }

  if(noSingleNodes){
    nodesInEdges <- nodes$id[nodes$id %in% c(edges$source,edges$target)]
    nodes <- nodes %>% filter(id %in% nodesInEdges)
  }

  #   if (is.null(edges$type)){
  #     message("No edge type provided: using random")
  #     etypes <- c("line","arrow","curvedArrow","curve")
  #     edges$type <- sample(etypes,1)
  #   }

  #   nodes <- apply(nodes, 1,function(r){
  #     as.list(r)
  #   })
  #
  #   edges <- apply(edges, 1,function(r){
  #     as.list(r)
  #   })

  g <- list(nodes=nodes, edges=edges, positions = positions, vars = vars)
  data <- g
  data
}
