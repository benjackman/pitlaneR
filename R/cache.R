# Session-level caching for API requests

# Package-level cache environment
.pitlane_cache <- new.env(parent = emptyenv())

.onLoad <- function(libname, pkgname) {
.pitlane_cache$mem <- cachem::cache_mem(max_age = 3600)
}

#' Cached version of f1_fetch_all
#' @noRd
f1_fetch_cached <- function(endpoint, table_name, array_name, limit = 100) {
  cache <- .pitlane_cache$mem
  key <- tolower(gsub("[^a-zA-Z0-9]", "", paste(c(endpoint, table_name, array_name), collapse = "")))

  cached <- cache$get(key)
  if (!cachem::is.key_missing(cached)) {
    return(cached)
  }

  result <- f1_fetch_all(endpoint, table_name, array_name, limit = limit)
  cache$set(key, result)
  result
}

#' Clear the pitlaneR session cache
#'
#' Removes all cached API responses from the current R session. API responses
#' are cached in memory for one hour to reduce redundant requests. Use this
#' function to force fresh data from the API on subsequent calls.
#'
#' @return Invisible `NULL`. A success message is printed via [cli::cli_alert_success()].
#' @export
#' @examples
#' f1_clear_cache()
f1_clear_cache <- function() {
  .pitlane_cache$mem$reset()
  cli::cli_alert_success("pitlaneR cache cleared.")
  invisible(NULL)
}
