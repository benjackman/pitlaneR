#' Get F1 pit stop data
#'
#' Retrieves pit stop data for a specific race, including stop number, lap,
#' time of day, and duration.
#'
#' Pit stop data is available from the 2011 season onward.
#'
#' @param season Integer or character. The season year (e.g., `2024`).
#'   **Required** (no default).
#' @param round Integer or character. The round number. **Required** (no
#'   default).
#'
#' @return A tibble with one row per pit stop, including columns:
#'   \describe{
#'     \item{season}{Integer. Season year.}
#'     \item{round}{Integer. Round number.}
#'     \item{race_name}{Character. Name of the Grand Prix.}
#'     \item{driver_id}{Character. Unique driver identifier.}
#'     \item{stop}{Integer. Pit stop number for that driver (1st, 2nd, etc.).}
#'     \item{lap}{Integer. Lap on which the pit stop occurred.}
#'     \item{time}{Character. Time of day of the pit stop.}
#'     \item{duration}{Character. Duration of the pit stop.}
#'   }
#'
#' @family detailed timing
#' @seealso [f1_laps()] for lap-by-lap timing data, [f1_results()] for final
#'   race results.
#' @export
#' @examples
#' \dontrun{
#' f1_pit_stops(2024, 1)
#' }
f1_pit_stops <- function(season, round) {
  season <- resolve_season(season)
  endpoint <- c(season, as.character(round), "pitstops")

  raw <- f1_fetch_cached(endpoint, "RaceTable", "Races")
  if (length(raw) == 0) return(tibble::tibble())

  races <- if (is.data.frame(raw)) raw else dplyr::bind_rows(raw)
  if (nrow(races) == 0 || !"PitStops" %in% names(races)) return(tibble::tibble())

  rows <- lapply(seq_len(nrow(races)), function(i) {
    race <- races[i, ]
    pits <- race[["PitStops"]]
    if (is.null(pits) || length(pits) == 0) return(NULL)
    if (is.list(pits) && !is.data.frame(pits)) pits <- pits[[1]]
    if (!is.data.frame(pits) || nrow(pits) == 0) return(NULL)

    pits_flat <- flatten_and_rename(pits)
    pits_flat$race_name <- race[["raceName"]]
    pits_flat$round <- race[["round"]]
    pits_flat$season <- race[["season"]]
    pits_flat
  })

  result <- dplyr::bind_rows(rows)
  if (nrow(result) == 0) return(tibble::tibble())

  front <- c("season", "round", "race_name")
  other <- setdiff(names(result), front)
  result <- result[, c(front, other)]

  apply_type_conversions(result)
}
