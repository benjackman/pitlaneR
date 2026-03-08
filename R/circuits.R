#' Get F1 circuit information
#'
#' Retrieves circuit information, optionally filtered to circuits used in a
#' specific season.
#'
#' @param season Integer or character. The season year (e.g., `2024`). If
#'   `NULL` (default), returns all circuits in the database.
#'
#' @return A tibble with one row per circuit, including columns:
#'   \describe{
#'     \item{circuit_id}{Character. Unique circuit identifier.}
#'     \item{circuit_name}{Character. Full circuit name.}
#'     \item{location_locality}{Character. City or locality.}
#'     \item{location_country}{Character. Country.}
#'     \item{location_lat}{Numeric. Latitude.}
#'     \item{location_long}{Numeric. Longitude.}
#'     \item{url}{Character. Wikipedia URL.}
#'   }
#'
#' @family reference data
#' @seealso [f1_races()] for the race schedule including circuit details.
#' @export
#' @examples
#' \dontrun{
#' # All circuits in the database
#' f1_circuits()
#'
#' # Circuits used in a specific season
#' f1_circuits(2024)
#' }
f1_circuits <- function(season = NULL) {
  endpoint <- if (!is.null(season)) {
    c(resolve_season(season), "circuits")
  } else {
    "circuits"
  }

  data <- f1_fetch_cached(endpoint, "CircuitTable", "Circuits")
  if (nrow(data) == 0) return(tibble::tibble())

  data <- flatten_and_rename(data)
  apply_type_conversions(data)
}
