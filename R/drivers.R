#' Get F1 driver information
#'
#' Retrieves driver information, optionally filtered to drivers who
#' participated in a specific season.
#'
#' @param season Integer or character. The season year (e.g., `2024`). If
#'   `NULL` (default), returns all drivers in the database.
#'
#' @return A tibble with one row per driver, including columns:
#'   \describe{
#'     \item{driver_id}{Character. Unique driver identifier.}
#'     \item{permanent_number}{Integer. Driver's permanent car number.}
#'     \item{code}{Character. Three-letter driver code (e.g., `"VER"`).}
#'     \item{given_name}{Character. Driver's first name.}
#'     \item{family_name}{Character. Driver's last name.}
#'     \item{date_of_birth}{Date. Driver's date of birth.}
#'     \item{nationality}{Character. Driver's nationality.}
#'     \item{url}{Character. Wikipedia URL.}
#'   }
#'
#'   Some columns (e.g., `permanent_number`, `code`) may be `NA` for drivers
#'   from earlier seasons where the data was not recorded by the API. See the
#'   [Jolpica API documentation](https://github.com/jolpica/jolpica-f1/blob/main/docs/README.md)
#'   for details on data availability.
#'
#' @family reference data
#' @seealso [f1_constructors()] for team information.
#' @export
#' @examples
#' \dontrun{
#' # Drivers from a specific season
#' f1_drivers(2024)
#'
#' # All drivers in the database
#' f1_drivers()
#' }
f1_drivers <- function(season = NULL) {
  expected_cols <- c(
    "driver_id", "permanent_number", "code", "url",
    "given_name", "family_name", "date_of_birth", "nationality"
  )

  endpoint <- if (!is.null(season)) {
    c(resolve_season(season), "drivers")
  } else {
    "drivers"
  }

  data <- f1_fetch_cached(endpoint, "DriverTable", "Drivers")
  if (nrow(data) == 0) return(tibble::tibble())

  data <- flatten_and_rename(data)
  data <- ensure_columns(data, expected_cols)
  apply_type_conversions(data)
}
