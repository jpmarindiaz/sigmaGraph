
#' @export
cleanGraph <- function(edges, nodes){  
  if (is.null(edges)){
    stop("Must specify edges as dataframe")
  }
  
  if (is.null(nodes)){
    message("No nodes provided: taking nodes from edges list")
    n <- unique(c(as.character(edges$source), as.character(edges$target)))
    nodes <- data.frame(id = n)
  }
  
  if (is.null(nodes$label)){
    message("No node labels provided: using labels as id")
    nodes$label <- nodes$id
  }
  
  if (is.null(nodes$x)){
    message("No node x position provided: using random value")
    nodes$x <- runif(nrow(nodes),1,10)
  }
  
  if (is.null(nodes$y)){
    message("No node y position provided: using random value")
    nodes$y <- runif(nrow(nodes),1,10)
  }
  
  if (is.null(nodes$size)){
    message("No node size provided: using random value")
    nodes$size <- 1
  }
  
  if (is.null(nodes$color)){
    message("No node color provided: using default")
    nodes$color <- "#FE34A0"
  }
  
  if (is.null(nodes$type)){
    message("No edge type provided: using random")
    ntypes <- c("diamond","square","circle","star","equilateral")
    nodes$type <- sample(ntypes,1)
  }
  
  if(is.null(edges$id)){
    edges$id <- paste0("e",seq(1:nrow(edges)))
  } else {
    if(length(unique(edges$id))< nrow(edges)){
      message("edges id not unique: overriding edges id")
      edges$id <- seq(1:nrow(edges))
    }
  }
  
  if (is.null(edges$color)){
    message("No edge color provided: using default")
    edges$color <- "#1E34A0"
  }
  
  if (is.null(edges$type)){
    message("No edge type provided: using random")
    etypes <- c("line","arrow","curvedArrow","curve")
    edges$type <- sample(etypes,1)
  }
  
  g <- list(nodes=nodes, edges=edges)    
  data <- g  
  data <- RJSONIO::fromJSON(datapackager::listToJSON(g))
  data
}
