#' Get F1 lap time data
#'
#' Retrieves lap-by-lap timing data for a specific race. This endpoint can
#' return a large amount of data; a progress bar is shown for multi-page
#' fetches.
#'
#' Lap time data is available from the 1996 season onward.
#'
#' @param season Integer or character. The season year (e.g., `2024`).
#'   **Required** (no default).
#' @param round Integer or character. The round number. **Required** (no
#'   default).
#' @param lap Integer or character. A specific lap number. If `NULL` (default),
#'   returns timing data for all laps in the race.
#'
#' @return A tibble with one row per driver per lap, including columns:
#'   \describe{
#'     \item{season}{Integer. Season year.}
#'     \item{round}{Integer. Round number.}
#'     \item{race_name}{Character. Name of the Grand Prix.}
#'     \item{lap}{Integer. Lap number.}
#'     \item{driver_id}{Character. Unique driver identifier.}
#'     \item{position}{Integer. Position at end of this lap.}
#'     \item{time}{Character. Lap time.}
#'   }
#'
#' @family detailed timing
#' @seealso [f1_pit_stops()] for pit stop data, [f1_results()] for final race
#'   results.
#' @export
#' @examples
#' \dontrun{
#' # All lap times for a race
#' f1_laps(2024, 1)
#'
#' # First lap only
#' f1_laps(2024, 1, lap = 1)
#' }
f1_laps <- function(season, round, lap = NULL) {
  season <- resolve_season(season)
  endpoint <- if (!is.null(lap)) {
    c(season, as.character(round), "laps", as.character(lap))
  } else {
    c(season, as.character(round), "laps")
  }

  raw <- f1_fetch_cached(endpoint, "RaceTable", "Races")
  if (length(raw) == 0) return(tibble::tibble())

  races <- if (is.data.frame(raw)) raw else dplyr::bind_rows(raw)
  if (nrow(races) == 0 || !"Laps" %in% names(races)) return(tibble::tibble())

  rows <- lapply(seq_len(nrow(races)), function(i) {
    race <- races[i, ]
    laps_data <- race[["Laps"]]
    if (is.null(laps_data) || length(laps_data) == 0) return(NULL)
    if (is.list(laps_data) && !is.data.frame(laps_data)) {
      laps_data <- laps_data[[1]]
    }
    if (!is.data.frame(laps_data) || nrow(laps_data) == 0) return(NULL)

    # Each lap has a list of Timings
    lap_rows <- lapply(seq_len(nrow(laps_data)), function(j) {
      lap_row <- laps_data[j, ]
      timings <- lap_row[["Timings"]]
      if (is.null(timings) || length(timings) == 0) return(NULL)
      if (is.list(timings) && !is.data.frame(timings)) timings <- timings[[1]]
      if (!is.data.frame(timings) || nrow(timings) == 0) return(NULL)

      timings$lap <- lap_row[["number"]]
      timings
    })

    lap_df <- dplyr::bind_rows(lap_rows)
    if (nrow(lap_df) == 0) return(NULL)

    lap_df$race_name <- race[["raceName"]]
    lap_df$round <- race[["round"]]
    lap_df$season <- race[["season"]]
    lap_df
  })

  result <- dplyr::bind_rows(rows)
  if (nrow(result) == 0) return(tibble::tibble())

  result <- flatten_and_rename(result)

  front <- c("season", "round", "race_name", "lap")
  other <- setdiff(names(result), front)
  result <- result[, c(front, other)]

  apply_type_conversions(result)
}
