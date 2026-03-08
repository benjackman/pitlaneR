#' Get F1 race results
#'
#' Retrieves race results for a given season and optionally a specific round.
#'
#' @param season Integer or character. The season year (e.g., `2024`). Defaults
#'   to the current year.
#' @param round Integer or character. The round number within the season. If
#'   `NULL` (default), returns results for all rounds in the season.
#'
#' @return A tibble with one row per driver per race, including columns:
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
#'     \item{status}{Character. Finishing status (e.g., "Finished", "+1 Lap").}
#'     \item{driver_*}{Driver details (id, code, given/family name, etc.).}
#'     \item{constructor_*}{Constructor details (id, name, nationality).}
#'     \item{time_*}{Race time information (where available).}
#'     \item{fastest_lap_*}{Fastest lap details (where available).}
#'   }
#'
#' @family race results
#' @seealso [f1_qualifying()] for qualifying session results,
#'   [f1_sprint()] for sprint race results.
#' @export
#' @examples
#' \dontrun{
#' # Results for a specific race
#' f1_results(2024, 1)
#'
#' # All results for a season
#' f1_results(2024)
#' }
f1_results <- function(season = NULL, round = NULL) {
  season <- resolve_season(season)
  endpoint <- if (!is.null(round)) {
    c(season, as.character(round), "results")
  } else {
    c(season, "results")
  }

  raw <- f1_fetch_cached(endpoint, "RaceTable", "Races")
  if (length(raw) == 0) return(tibble::tibble())

  # Results are nested inside each Race — unnest them
  races <- if (is.data.frame(raw)) raw else dplyr::bind_rows(raw)
  if (nrow(races) == 0 || !"Results" %in% names(races)) return(tibble::tibble())

  # Extract race-level info and bind with results
  rows <- lapply(seq_len(nrow(races)), function(i) {
    race <- races[i, ]
    results_df <- race[["Results"]]
    if (is.null(results_df) || length(results_df) == 0) return(NULL)
    if (is.list(results_df) && !is.data.frame(results_df)) {
      results_df <- results_df[[1]]
    }
    if (!is.data.frame(results_df) || nrow(results_df) == 0) return(NULL)

    results_flat <- flatten_and_rename(results_df)
    results_flat$race_name <- race[["raceName"]]
    results_flat$round <- race[["round"]]
    results_flat$season <- race[["season"]]
    results_flat$race_date <- race[["date"]]
    results_flat
  })

  result <- dplyr::bind_rows(rows)
  if (nrow(result) == 0) return(tibble::tibble())

  # Reorder so race info comes first
  race_cols <- c("season", "round", "race_name", "race_date")
  other_cols <- setdiff(names(result), race_cols)
  result <- result[, c(race_cols, other_cols)]

  apply_type_conversions(result)
}
