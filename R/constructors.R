#' Get F1 constructor information
#'
#' Retrieves constructor (team) information, optionally filtered to
#' constructors that participated in a specific season.
#'
#' @param season Integer or character. The season year (e.g., `2024`). If
#'   `NULL` (default), returns all constructors in the database.
#'
#' @return A tibble with one row per constructor, including columns:
#'   \describe{
#'     \item{constructor_id}{Character. Unique constructor identifier.}
#'     \item{name}{Character. Constructor name.}
#'     \item{nationality}{Character. Constructor nationality.}
#'     \item{url}{Character. Wikipedia URL.}
#'   }
#'
#' @family reference data
#' @seealso [f1_drivers()] for driver information.
#' @export
#' @examples
#' \dontrun{
#' # Constructors from a specific season
#' f1_constructors(2024)
#'
#' # All constructors in the database
#' f1_constructors()
#' }
f1_constructors <- function(season = NULL) {
  endpoint <- if (!is.null(season)) {
    c(resolve_season(season), "constructors")
  } else {
    "constructors"
  }

  data <- f1_fetch_cached(endpoint, "ConstructorTable", "Constructors")
  if (nrow(data) == 0) return(tibble::tibble())

  data <- flatten_and_rename(data)
  apply_type_conversions(data)
}
