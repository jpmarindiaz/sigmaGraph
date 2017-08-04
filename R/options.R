


sigmaGraphOpts <- function(){
  list(
    data = list(
      nodesSizeVar = "size",
      nodesColorVar = "color",
      edgesSourceVar = "source",
      edgesTargetVar = "target",
      noSingleNodes = FALSE
    ),
    plugins = list(
      dragNoes = TRUE
    )
  )
}

parseOpts <- function(opts = NULL, ...){
  .dotOpts <- list(...)
  if(!is.empty(opts)){
    if(!is.empty(.dotOpts)){
      opts <- modifyList(opts,.dotOpts)
    }
    opts <- modifyList(sigmaGraphOpts(),opts)
  }else{
    if(!is.empty(.dotOpts)){
      opts <- modifyList(sigmaGraphOpts(),.dotOpts)
    }else{
      opts <- sigmaGraphOpts()
    }
  }
  opts
}
