
fct_to_chr <- function(d) map_if(d,is.factor,as.character) %>% as_tibble
num_to_chr <- function(d) map_if(d,is.numeric,as.character) %>% as_tibble

any_row_with_na <- function(d) any(apply(d, 1, function(x) !any(is.na(x))))


#' @export
`%||%` <- function (x, y)
{
  if (is.empty(x))
    return(y)
  else if (is.null(x) || is.na(x))
    return(y)
  else if (class(x) == "character" && nchar(x) == 0)
    return(y)
  else x
}

is.empty <- function (x)
{
  !as.logical(length(x))
}
