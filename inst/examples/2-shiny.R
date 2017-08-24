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
  verbatimTextOutput("debug"),
  sigmaGraphOutput('sigma'),
  sigmaGraphOutput('sigma2')
))

server = function(input, output) {
  output$debug <- renderPrint({
    paste0("Sigma1: ",input$sigma_clicked_node,
           "\nSigma2: ", input$sigma2_clicked_node)
  })

  output$sigma2 <- renderSigmaGraph({
    if(is.null(input$drawEdges) || is.null(input$drawEdgeLabels))
      opts2 <- list(
        plugins = list(
          forceAtlas = TRUE,
          forceAtlasTime = 4000,
          forceAtlasConfig = list(
            strongGravityMode = TRUE
          )
        ),
        sigma = list(
          drawEdgeLabels = FALSE,
          drawNodes = TRUE
        )
      )
    sigmaGraph(edges, nodes = nodes, opts = opts2, debug = TRUE, height = 200)
  })

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
