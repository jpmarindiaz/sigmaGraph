

devtools::document()
devtools::install()

library(sigmaGraph)
library(tidyverse)

#edges <- read.csv("inst/data/edges.csv", stringsAsFactors=FALSE)
#nodes <- read.csv("inst/data/nodes.csv", stringsAsFactors=FALSE)

ed <- read_csv(system.file("data/edges.csv", package = "sigmaGraph"))
nd <- read_csv(system.file("data/nodes.csv", package = "sigmaGraph"))

sigmaGraph(ed, opts = list(plugins = list(forceAtlas = TRUE, forceAtlasTime = 20)))
sigmaGraph(ed, opts = list(plugins = list(dragNodes = TRUE,forceAtlas = TRUE, forceAtlasTime = 20)))
sigmaGraph(ed, opts = list(plugins = list(dragNodes = TRUE)))

ed <- ed %>% filter(source %in% nd$id, target %in% nd$id)
sigmaGraph(ed, nd)

sigmaGraph(ed, nd, opts = list(plugins = list(dragNodes = TRUE)))

sigmaGraph(ed, nd, opts = list(plugins = list(dragNodes = TRUE,forceAtlas = TRUE, forceAtlasTime = 20)))



nodes$imageUrl <- NULL
edges$color <- "#136CB8"

sigmaGraph(edges, nodes)




sigmaGraphImageNeighbors(edges, nodes)

sigmaGraphNeighbors(edges, nodes)



sigmaGraphSimple(edges, nodes)
sigmaGraphDrag(edges, nodes)
sigmaGraphForce(edges, nodes)

sigmaGraphSimple(edges[,2:3])

nodes$imageUrl <- "http://www.htmlwidgets.org/images/carousel-leaflet.png"
nodes$imageUrl <- "https://dl.dropboxusercontent.com/u/38618778/empresarios2015/desk.png"
sigmaGraphImage(edges, nodes)

s <- sigmaGraphSimple(edges, nodes)
saveNetwork(s, "tmp.html")



