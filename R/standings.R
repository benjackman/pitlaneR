#' Get F1 driver championship standings
#'
#' Retrieves the World Drivers' Championship standings for a given season,
#' optionally at a specific round.
#'
#' @param season Integer or character. The season year (e.g., `2024`). Defaults
#'   to the current year.
#' @param round Integer or character. The round number. If `NULL` (default),
#'   returns the final (or latest available) standings for the season.
#'
#' @return A tibble with one row per driver, including columns:
#'   \describe{
#'     \item{season}{Integer. Season year.}
#'     \item{standings_round}{Integer. Round number at which the standings apply.}
#'     \item{position}{Integer. Championship position.}
#'     \item{points}{Numeric. Total championship points.}
#'     \item{wins}{Integer. Number of race wins.}
#'     \item{driver_*}{Driver details (id, code, given/family name, etc.).}
#'     \item{constructor_*}{Constructor details for the driver's team.}
#'   }
#'
#'   Some columns (e.g., `driver_permanent_number`, `driver_code`) may be `NA`
#'   for earlier seasons where the data was not recorded by the API. See the
#'   [Jolpica API documentation](https://github.com/jolpica/jolpica-f1/blob/main/docs/README.md)
#'   for details on data availability.
#'
#' @family standings
#' @seealso [f1_constructor_standings()] for the constructors' championship.
#' @export
#' @examples
#' \dontrun{
#' # Final standings for a season
#' f1_driver_standings(2024)
#'
#' # Standings after round 5
#' f1_driver_standings(2024, 5)
#' }
f1_driver_standings <- function(season = NULL, round = NULL) {
  # Expected non-list columns (constructors is a list-column, always present)
  expected_cols <- c(
    "season", "standings_round",
    "position", "position_text", "points", "wins",
    "driver_id", "driver_permanent_number", "driver_code",
    "driver_url", "driver_given_name", "driver_family_name",
    "driver_date_of_birth", "driver_nationality",
    "constructors"
  )

  season <- resolve_season(season)
  endpoint <- if (!is.null(round)) {
    c(season, as.character(round), "driverstandings")
  } else {
    c(season, "driverstandings")
  }

  raw <- f1_fetch_cached(endpoint, "StandingsTable", "StandingsLists")
  if (length(raw) == 0) return(tibble::tibble())

  standings_list <- if (is.data.frame(raw)) raw else dplyr::bind_rows(raw)
  if (nrow(standings_list) == 0) return(tibble::tibble())

  rows <- lapply(seq_len(nrow(standings_list)), function(i) {
    sl <- standings_list[i, ]
    ds <- sl[["DriverStandings"]]
    if (is.null(ds) || length(ds) == 0) return(NULL)
    if (is.list(ds) && !is.data.frame(ds)) ds <- ds[[1]]
    if (!is.data.frame(ds) || nrow(ds) == 0) return(NULL)

    ds_flat <- flatten_and_rename(ds)
    ds_flat$season <- sl[["season"]]
    ds_flat$standings_round <- sl[["round"]]
    ds_flat
  })

  result <- dplyr::bind_rows(rows)
  if (nrow(result) == 0) return(tibble::tibble())

  # Move season/round to front
  front <- c("season", "standings_round")
  other <- setdiff(names(result), front)
  result <- result[, c(front, other)]

  # Ensure non-list columns are present; skip "constructors" list-col
  non_list_cols <- setdiff(expected_cols, "constructors")
  missing <- setdiff(non_list_cols, names(result))
  for (col in missing) {
    result[[col]] <- NA_character_
  }

  apply_type_conversions(result)
}

#' Get F1 constructor championship standings
#'
#' Retrieves the World Constructors' Championship standings for a given season,
#' optionally at a specific round. The Constructors' Championship has been
#' awarded since **1958**; requesting earlier seasons will raise an error.
#'
#' @param season Integer or character. The season year (e.g., `2024`), must be
#'   1958 or later (the Constructors' Championship did not exist before 1958).
#'   Defaults to the current year.
#' @param round Integer or character. The round number. If `NULL` (default),
#'   returns the final (or latest available) standings for the season.
#'
#' @return A tibble with one row per constructor, including columns:
#'   \describe{
#'     \item{season}{Integer. Season year.}
#'     \item{standings_round}{Integer. Round number at which the standings apply.}
#'     \item{position}{Integer. Championship position.}
#'     \item{points}{Numeric. Total championship points.}
#'     \item{wins}{Integer. Number of race wins.}
#'     \item{constructor_*}{Constructor details (id, name, nationality).}
#'   }
#'
#' @family standings
#' @seealso [f1_driver_standings()] for the drivers' championship.
#' @export
#' @examples
#' \dontrun{
#' # Final standings for a season
#' f1_constructor_standings(2024)
#'
#' # Standings after round 5
#' f1_constructor_standings(2024, 5)
#' }
f1_constructor_standings <- function(season = NULL, round = NULL) {
  season <- resolve_season(season)

  if (as.integer(season) < 1958L) {
    stop(
      "Constructor standings are only available from 1958 onward. ",
      "The Constructors' Championship did not exist in the ",
      season, " season.",
      call. = FALSE
    )
  }

  endpoint <- if (!is.null(round)) {
    c(season, as.character(round), "constructorstandings")
  } else {
    c(season, "constructorstandings")
  }

  raw <- f1_fetch_cached(endpoint, "StandingsTable", "StandingsLists")
  if (length(raw) == 0) return(tibble::tibble())

  standings_list <- if (is.data.frame(raw)) raw else dplyr::bind_rows(raw)
  if (nrow(standings_list) == 0) return(tibble::tibble())

  rows <- lapply(seq_len(nrow(standings_list)), function(i) {
    sl <- standings_list[i, ]
    cs <- sl[["ConstructorStandings"]]
    if (is.null(cs) || length(cs) == 0) return(NULL)
    if (is.list(cs) && !is.data.frame(cs)) cs <- cs[[1]]
    if (!is.data.frame(cs) || nrow(cs) == 0) return(NULL)

    cs_flat <- flatten_and_rename(cs)
    cs_flat$season <- sl[["season"]]
    cs_flat$standings_round <- sl[["round"]]
    cs_flat
  })

  result <- dplyr::bind_rows(rows)
  if (nrow(result) == 0) return(tibble::tibble())

  front <- c("season", "standings_round")
  other <- setdiff(names(result), front)
  result <- result[, c(front, other)]

  apply_type_conversions(result)
}
