
library(devtools)
library(htmlwidgets)

#load_all()  
document()
install()

library(sigmaGraph)

#edges <- read.csv("inst/data/edges.csv", stringsAsFactors=FALSE)
#nodes <- read.csv("inst/data/nodes.csv", stringsAsFactors=FALSE)

edges <- read.csv("inst/data/edges-empresarios.csv", stringsAsFactors=FALSE)
nodes <- read.csv("inst/data/nodes-empresarios.csv", stringsAsFactors=FALSE)

sigmaGraphImageNeighbors(edges, nodes)



sigmaGraphSimple(edges, nodes)
sigmaGraphDrag(edges, nodes)
sigmaGraphForce(edges, nodes)
sigmaGraphNeighbors(edges, nodes)

sigmaGraphSimple(edges[,2:3])

nodes$imageUrl <- "http://www.htmlwidgets.org/images/carousel-leaflet.png"
nodes$imageUrl <- "https://dl.dropboxusercontent.com/u/38618778/empresarios2015/desk.png"
sigmaGraphImage(edges, nodes)

s <- sigmaGraphSimple(edges, nodes)
saveNetwork(s, "tmp.html")



