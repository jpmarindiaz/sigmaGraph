#devtools::install()
library(shiny)
library(sigmaGraph)

edges <- read_csv(system.file("data/edges-whois-co-1.csv", package = "sigmaGraph"))
edges$label <- sample(LETTERS, nrow(edges))
nodes <- read_csv(system.file("data/nodes-whois-co-1.csv", package = "sigmaGraph"))
nodes <- nodes %>% mutate(title = id)
opts <- list(
  data = list(
    nodesColorVar = "entity",
    nodesLabelVar = "title"
    #edgesLabelVar = "type"
  ),
  plugins = list(
    forceAtlas = FALSE,
    forceAtlasTime = 10
  ),
  sigma = list(
    drawEdgeLabels = TRUE,
    mouseWheelEnabled = TRUE,
    #edgeLabelThreshold = 0,
    enableEdgeHovering = TRUE
  )
)



ui = shinyUI(fluidPage(
  checkboxInput("drawEdgeLabels", "Draw Edge Labels", value = TRUE),
  checkboxInput("drawNodes", "Draw Nodes", value = TRUE),
  sigmaGraphOutput('sigma')
))

server = function(input, output) {
  output$sigma <- renderSigmaGraph({
    if(is.null(input$drawEdges) || is.null(input$drawEdgeLabels))
    opts <- list(
      sigma = list(
        drawEdgeLabels = input$drawEdgeLabels,
        drawNodes = input$drawNodes
      )
    )
    sigmaGraph(edges, nodes = nodes, opts = opts, debug = TRUE)
  })
}

shinyApp(ui = ui, server = server)
