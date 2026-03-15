#' Get F1 race schedule
#'
#' Retrieves the race schedule for a given season, including circuit
#' information, dates, and session times.
#'
#' @param season Integer or character. The season year (e.g., `2024`). Defaults
#'   to the current year.
#'
#' @return A tibble with one row per race, including columns:
#'   \describe{
#'     \item{season}{Integer. Season year.}
#'     \item{round}{Integer. Round number.}
#'     \item{race_name}{Character. Name of the Grand Prix.}
#'     \item{date}{Date. Date of the race.}
#'     \item{time}{Character. Scheduled start time (UTC).}
#'     \item{url}{Character. Wikipedia URL for the race.}
#'     \item{circuit_*}{Circuit details (id, name, location, coordinates).}
#'     \item{first_practice_*}{First practice session date and time.}
#'     \item{qualifying_*}{Qualifying session date and time.}
#'     \item{sprint_*}{Sprint session date and time (where applicable).}
#'   }
#'
#'   Some columns (e.g., session times, sprint dates) may be `NA` for earlier
#'   seasons where the data was not recorded by the API. See the
#'   [Jolpica API documentation](https://github.com/jolpica/jolpica-f1/blob/main/docs/README.md)
#'   for details on data availability.
#'
#' @family reference data
#' @seealso [f1_circuits()] for detailed circuit information.
#' @export
#' @examples
#' \dontrun{
#' # Race schedule for a specific season
#' f1_races(2024)
#'
#' # Current season schedule
#' f1_races()
#' }
f1_races <- function(season = NULL) {
  expected_cols <- c(
    "season", "round", "url", "race_name",
    "circuit_id", "circuit_url", "circuit_name",
    "circuit_location_lat", "circuit_location_long",
    "circuit_location_locality", "circuit_location_country",
    "date", "time",
    "first_practice_date", "first_practice_time",
    "second_practice_date", "second_practice_time",
    "third_practice_date", "third_practice_time",
    "qualifying_date", "qualifying_time",
    "sprint_date", "sprint_time",
    "sprint_qualifying_date", "sprint_qualifying_time"
  )

  season <- resolve_season(season)
  data <- f1_fetch_cached(c(season, "races"), "RaceTable", "Races")
  if (nrow(data) == 0) return(tibble::tibble())

  data <- flatten_and_rename(data)
  data <- ensure_columns(data, expected_cols)
  apply_type_conversions(data)
}
