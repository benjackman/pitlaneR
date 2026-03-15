skip_if_offline <- function() {
  tryCatch(
    {
      httr::GET("https://api.jolpi.ca/ergast/f1/seasons/?limit=1&format=json",
                httr::timeout(5))
    },
    error = function(e) skip("Jolpica API not reachable")
  )
}

skip_if_api_unavailable <- function() {
  skip_on_cran()
  skip_if_offline()
}
