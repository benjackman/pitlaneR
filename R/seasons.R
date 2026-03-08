#' Get all F1 seasons
#'
#' Retrieves a list of all Formula 1 World Championship seasons available in
#' the database, covering 1950 to the present.
#'
#' @return A tibble with one row per season, including columns:
#'   \describe{
#'     \item{season}{Integer. The season year.}
#'     \item{url}{Character. Wikipedia URL for the season.}
#'   }
#'
#' @family reference data
#' @export
#' @examples
#' \dontrun{
#' f1_seasons()
#' }
f1_seasons <- function() {
  data <- f1_fetch_cached("seasons", "SeasonTable", "Seasons")
  if (nrow(data) == 0) return(tibble::tibble())

  data <- flatten_and_rename(data)
  apply_type_conversions(data)
}
