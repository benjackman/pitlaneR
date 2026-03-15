#' Get F1 qualifying results
#'
#' Retrieves qualifying session results for a given season and optionally a
#' specific round. Qualifying data is only available from the **1994 season
#' onward**; requesting earlier seasons will raise an error.
#'
#' @param season Integer or character. The season year (e.g., `2024`), must be
#'   1994 or later (the Jolpica API does not provide qualifying results earlier
#'   than 1994). Defaults to the current year.
#' @param round Integer or character. The round number within the season. If
#'   `NULL` (default), returns qualifying results for all rounds in the season.
#'
#' @return A tibble with one row per driver per qualifying session, including
#'   columns:
#'   \describe{
#'     \item{season}{Integer. Season year.}
#'     \item{round}{Integer. Round number.}
#'     \item{race_name}{Character. Name of the Grand Prix.}
#'     \item{race_date}{Date. Date of the race.}
#'     \item{position}{Integer. Final qualifying position.}
#'     \item{q1, q2, q3}{Character. Lap times set in each qualifying session.
#'       Missing if the driver did not participate in that session.}
#'     \item{driver_*}{Driver details (id, code, given/family name, etc.).}
#'     \item{constructor_*}{Constructor details (id, name, nationality).}
#'   }
#'
#'   Some columns (e.g., `q2`, `q3`, `driver_permanent_number`) may be `NA`
#'   for earlier seasons where the qualifying format differed or the data was
#'   not recorded by the API. See the
#'   [Jolpica API documentation](https://github.com/jolpica/jolpica-f1/blob/main/docs/README.md)
#'   for details on data availability.
#'
#' @family race results
#' @seealso [f1_results()] for race results, [f1_sprint()] for sprint results.
#' @export
#' @examples
#' \dontrun{
#' # Qualifying for a specific race
#' f1_qualifying(2024, 1)
#'
#' # All qualifying results for a season
#' f1_qualifying(2024)
#' }
f1_qualifying <- function(season = NULL, round = NULL) {
  expected_cols <- c(
    "season", "round", "race_name", "race_date",
    "number", "position",
    "driver_id", "driver_permanent_number", "driver_code",
    "driver_url", "driver_given_name", "driver_family_name",
    "driver_date_of_birth", "driver_nationality",
    "constructor_id", "constructor_url", "constructor_name",
    "constructor_nationality",
    "q1", "q2", "q3"
  )

  season <- resolve_season(season)

  if (as.integer(season) < 1994L) {
    stop(
      "Qualifying data is only available from 1994 onward. ",
      "The Jolpica API does not provide qualifying results for the ",
      season, " season.",
      call. = FALSE
    )
  }

  endpoint <- if (!is.null(round)) {
    c(season, as.character(round), "qualifying")
  } else {
    c(season, "qualifying")
  }

  raw <- f1_fetch_cached(endpoint, "RaceTable", "Races")
  if (length(raw) == 0) return(tibble::tibble())

  races <- if (is.data.frame(raw)) raw else dplyr::bind_rows(raw)
  if (nrow(races) == 0 || !"QualifyingResults" %in% names(races)) {
    return(tibble::tibble())
  }

  rows <- lapply(seq_len(nrow(races)), function(i) {
    race <- races[i, ]
    quali_df <- race[["QualifyingResults"]]
    if (is.null(quali_df) || length(quali_df) == 0) return(NULL)
    if (is.list(quali_df) && !is.data.frame(quali_df)) {
      quali_df <- quali_df[[1]]
    }
    if (!is.data.frame(quali_df) || nrow(quali_df) == 0) return(NULL)

    quali_flat <- flatten_and_rename(quali_df)
    quali_flat$race_name <- race[["raceName"]]
    quali_flat$round <- race[["round"]]
    quali_flat$season <- race[["season"]]
    quali_flat$race_date <- race[["date"]]
    quali_flat
  })

  result <- dplyr::bind_rows(rows)
  if (nrow(result) == 0) return(tibble::tibble())

  race_cols <- c("season", "round", "race_name", "race_date")
  other_cols <- setdiff(names(result), race_cols)
  result <- result[, c(race_cols, other_cols)]

  result <- ensure_columns(result, expected_cols)
  apply_type_conversions(result)
}
