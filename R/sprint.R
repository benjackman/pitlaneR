#' Get F1 sprint race results
#'
#' Retrieves sprint race results for a given season and optionally a specific
#' round. Sprint races were introduced in 2021 and are shorter races held on
#' Saturday at selected events.
#'
#' @param season Integer or character. The season year (e.g., `2024`). Defaults
#'   to the current year.
#' @param round Integer or character. The round number within the season. If
#'   `NULL` (default), returns sprint results for all rounds in the season.
#'
#' @return A tibble with one row per driver per sprint race, including columns:
#'   \describe{
#'     \item{season}{Integer. Season year.}
#'     \item{round}{Integer. Round number.}
#'     \item{race_name}{Character. Name of the Grand Prix.}
#'     \item{race_date}{Date. Date of the race.}
#'     \item{number}{Integer. Driver's car number.}
#'     \item{position}{Integer. Finishing position.}
#'     \item{points}{Numeric. Points awarded.}
#'     \item{grid}{Integer. Starting grid position.}
#'     \item{laps}{Integer. Number of laps completed.}
#'     \item{status}{Character. Finishing status.}
#'     \item{driver_*}{Driver details (id, code, given/family name, etc.).}
#'     \item{constructor_*}{Constructor details (id, name, nationality).}
#'   }
#'
#'   Returns an empty tibble for seasons or rounds without sprint races.
#'   Some columns (e.g., `fastest_lap_*`) may be `NA` for earlier sprint
#'   seasons. See the
#'   [Jolpica API documentation](https://github.com/jolpica/jolpica-f1/blob/main/docs/README.md)
#'   for details on data availability.
#'
#' @family race results
#' @seealso [f1_results()] for main race results,
#'   [f1_qualifying()] for qualifying results.
#' @export
#' @examples
#' \dontrun{
#' # Sprint results for a specific race
#' f1_sprint(2024, 1)
#'
#' # All sprint results for a season
#' f1_sprint(2024)
#' }
f1_sprint <- function(season = NULL, round = NULL) {
  expected_cols <- c(
    "season", "round", "race_name", "race_date",
    "number", "position", "position_text", "points",
    "driver_id", "driver_permanent_number", "driver_code",
    "driver_url", "driver_given_name", "driver_family_name",
    "driver_date_of_birth", "driver_nationality",
    "constructor_id", "constructor_url", "constructor_name",
    "constructor_nationality",
    "grid", "laps", "status",
    "time_millis", "time_time",
    "fastest_lap_rank", "fastest_lap_lap", "fastest_lap_time_time"
  )

  season <- resolve_season(season)
  endpoint <- if (!is.null(round)) {
    c(season, as.character(round), "sprint")
  } else {
    c(season, "sprint")
  }

  raw <- f1_fetch_cached(endpoint, "RaceTable", "Races")
  if (length(raw) == 0) return(tibble::tibble())

  races <- if (is.data.frame(raw)) raw else dplyr::bind_rows(raw)
  if (nrow(races) == 0 || !"SprintResults" %in% names(races)) {
    return(tibble::tibble())
  }

  rows <- lapply(seq_len(nrow(races)), function(i) {
    race <- races[i, ]
    sprint_df <- race[["SprintResults"]]
    if (is.null(sprint_df) || length(sprint_df) == 0) return(NULL)
    if (is.list(sprint_df) && !is.data.frame(sprint_df)) {
      sprint_df <- sprint_df[[1]]
    }
    if (!is.data.frame(sprint_df) || nrow(sprint_df) == 0) return(NULL)

    sprint_flat <- flatten_and_rename(sprint_df)
    sprint_flat$race_name <- race[["raceName"]]
    sprint_flat$round <- race[["round"]]
    sprint_flat$season <- race[["season"]]
    sprint_flat$race_date <- race[["date"]]
    sprint_flat
  })

  result <- dplyr::bind_rows(rows)
  if (nrow(result) == 0) return(tibble::tibble())

  race_cols <- c("season", "round", "race_name", "race_date")
  other_cols <- setdiff(names(result), race_cols)
  result <- result[, c(race_cols, other_cols)]

  result <- ensure_columns(result, expected_cols)
  apply_type_conversions(result)
}
