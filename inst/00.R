

devtools::document()
devtools::install()

library(sigmaGraph)
library(tidyverse)


edges <- read_csv(system.file("data/edges-whois-co-1.csv", package = "sigmaGraph"))
edges$label <- sample(LETTERS, nrow(edges))
edges$weight <- runif(nrow(edges))
nodes <- read_csv(system.file("data/nodes-whois-co-1.csv", package = "sigmaGraph"))
nodes <- nodes %>% mutate(title = id)
opts <- list(
  data = list(
    nodesColorVar = "entity",
    nodesLabelVar = "title",
    edgesSizeVar = "weight"
    #edgesLabelVar = "type"
  ),
  plugins = list(
    forceAtlas = TRUE,
    forceAtlasTime = 2000,
    forceAtlasConfig = list(
      scalingRatio = 0.5
    )
  ),
  sigma = list(
    drawEdgeLabels = TRUE,
    mouseWheelEnabled = TRUE,
    #edgeLabelThreshold = 0,
    enableEdgeHovering = TRUE,
    defaultEdgeType = "tapered"
  )
)
sigmaGraph(edges, nodes = nodes, opts = opts, debug = TRUE)





#edges <- read.csv("inst/data/edges.csv", stringsAsFactors=FALSE)
#nodes <- read.csv("inst/data/nodes.csv", stringsAsFactors=FALSE)

ed <- read_csv(system.file("data/edges.csv", package = "sigmaGraph"))
nd <- read_csv(system.file("data/nodes.csv", package = "sigmaGraph"))
ed <- ed %>% filter(source %in% nd$id, target %in% nd$id)

sigmaGraph(ed, opts = list(plugins = list(forceAtlas = TRUE, forceAtlasTime = 4000)))


tidyverse <- c("forcats", "ggplot2", "haven", "lubridate", "magrittr", "purrr",
               "readr", "readxl", "stringr", "tibble", "tidyr", "tidyverse")
tidyverseLogos <- paste0("http://",tidyverse,".tidyverse.org/logo.png")
nd$image <- sample(tidyverseLogos,nrow(nd),replace = TRUE)

sigmaGraph(ed, nd, opts = list(plugins = list(images = TRUE, neighbors = TRUE),
                               sigma = list(imageThreshold = 0,minNodeSize = 20,maxNodeSize = 20,
                                            drawLabels = FALSE, drawEdges = TRUE)))

sigmaGraph(ed, nd, opts = list(data = list(nodeImageVar = "images"),
                               plugins = list(images = TRUE)))


sigmaGraph(ed, opts = list(sigma = list(minNodeSize = 30,maxNodeSize = 30)))

sigmaGraph(ed, opts = list(plugins = list(forceAtlas = TRUE, forceAtlasTime = 4000)))
sigmaGraph(ed, opts = list(plugins = list(dragNodes = TRUE,forceAtlas = TRUE, forceAtlasTime = 20)))
sigmaGraph(ed, opts = list(plugins = list(dragNodes = TRUE)))

sigmaGraph(ed, nd, opts = list(sigma = list(zoomMin = 0.05, zoomMax = 50)))
sigmaGraph(ed, nd)


sigmaGraph(ed, nd, opts = list(plugins = list(dragNodes = TRUE)))

sigmaGraph(ed, nd, opts = list(plugins = list(dragNodes = TRUE,forceAtlas = TRUE, forceAtlasTime = 20)))

ed$label <- 1:nrow(ed)
sigmaGraph(ed, nd,
           opts = list(
                  plugins = list(dragNodes = TRUE,forceAtlas = TRUE, forceAtlasTime = 20),
                  sigma = list(drawEdgeLabels = TRUE)
                  )
          )



