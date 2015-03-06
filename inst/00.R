
library(devtools)
library(htmlwidgets)

#load_all()  
document()
install()

library(sigmaGraph)

edges <- read.csv("inst/data/edges.csv")
nodes <- read.csv("inst/data/nodes.csv")

sigmaGraphSimple(edges, nodes)
sigmaGraphDrag(edges, nodes)
sigmaGraphForce(edges, nodes)
sigmaGraphNeighbors(edges, nodes)

sigmaGraphSimple(edges[,2:3])

nodes$imageUrl <- "http://www.htmlwidgets.org/images/carousel-leaflet.png"
sigmaGraphImage(edges, nodes)

s <- sigmaGraphSimple(edges, nodes)
saveNetwork(s, "tmp.html")



