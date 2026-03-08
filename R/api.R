# Internal API plumbing for the Jolpica (Ergast-compatible) F1 API

f1_base_url <- function() {
  "https://api.jolpi.ca/ergast/f1"
}

#' Build and perform a single API request
#' @param endpoint Character vector of path segments
#' @param limit Max results per page (API default 30, max 100)
#' @param offset Pagination offset
#' @return Parsed JSON as a list
#' @noRd
f1_request <- function(endpoint, limit = 100, offset = 0) {
  url <- paste(c(f1_base_url(), endpoint), collapse = "/")
  full_url <- paste0(url, "/?limit=", limit, "&offset=", offset, "&format=json")

  resp <- httr::GET(
    full_url,
    httr::user_agent("pitlaneR R package (https://github.com/benjackman/pitlaneR)"),
    httr::timeout(30)
  )

  if (httr::http_error(resp)) {
    cli::cli_abort("Jolpica API error: HTTP {httr::status_code(resp)}")
  }

  jsonlite::fromJSON(httr::content(resp, as = "text", encoding = "UTF-8"),
                     simplifyVector = TRUE)
}

#' Fetch all pages of results from an API endpoint
#'
#' @param endpoint Character vector of path segments
#' @param table_name Name of the table key inside the response (e.g., "RaceTable")
#' @param array_name Name of the array inside the table (e.g., "Races")
#' @param limit Per-page limit (max 100)
#' @return The full array of results
#' @noRd
f1_fetch_all <- function(endpoint, table_name, array_name, limit = 100) {
  first <- f1_request(endpoint, limit = limit, offset = 0)
  mr <- first[["MRData"]]
  total <- as.integer(mr[["total"]])

  if (total == 0) {
    return(tibble::tibble())
  }

  result <- mr[[table_name]][[array_name]]
  fetched <- as.integer(mr[["limit"]])

  if (fetched < total) {
    offsets <- seq(fetched, total - 1, by = limit)
    if (length(offsets) > 1) {
      cli::cli_progress_bar(
        "Fetching F1 data",
        total = length(offsets),
        clear = FALSE
      )
    }
    for (off in offsets) {
      page <- f1_request(endpoint, limit = limit, offset = off)
      page_data <- page[["MRData"]][[table_name]][[array_name]]
      result <- dplyr::bind_rows(result, page_data)
      if (length(offsets) > 1) cli::cli_progress_update()
    }
    if (length(offsets) > 1) cli::cli_progress_done()
  }

  result
}
