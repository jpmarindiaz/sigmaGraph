context("Options")

library(tidyverse)

test_that("Options",{

  expect_equal(parseOpts(),sigmaGraphOpts())
  opts <- NULL
  expect_equal(parseOpts(opts),sigmaGraphOpts())
  opts <- list(..a = 1)
  expect_equal(parseOpts(opts),c(sigmaGraphOpts(),opts))
  expect_equal(parseOpts(..a = 1),c(sigmaGraphOpts(),opts))
  expect_equal(parseOpts(opts, ..a = 2),c(sigmaGraphOpts(),list(..a = 2)))

  opts <- sigmaGraphOpts()


})

context("Clean Graph")


test_that("clean graph",{

  ed <- readr::read_csv(system.file("data/edges.csv", package = "sigmaGraph"))
  nd <- readr::read_csv(system.file("data/nodes.csv", package = "sigmaGraph"))

  # cleanGraph(edges, nodes = NULL,
  #            nodeSizeVar = NULL,
  #            nodeColorVar = NULL,
  #            palette = NULL,
  #            noSingleNodes = NULL)

  expect_error(cleanGraph(NULL), "No edges data.frame")

  expect_error(cleanGraphe(d, opts = NULL))

  opts <- list(data = list(edgesSourceVar = "src", edgesTargetVar = "tgt"))
  opts <- parseOpts(opts)
  edges <- data.frame(src = c(1,NA), tgt = c(2,1))

  expect_warning(cleanGraph(edges, opts = opts),"Removing edges with NA")
  cleanGraph(edges, opts = opts)


})
