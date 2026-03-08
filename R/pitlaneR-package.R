#' pitlaneR: Access Formula 1 Data from the Jolpica API
#'
#' Provides tidy access to historical and current Formula 1 data via the free
#' Jolpica API (Ergast-compatible). All data is returned as tibbles with
#' snake_case column names and automatic type conversion. No API key or Python
#' dependency required.
#'
#' @section Main functions:
#'
#' **Race results:**
#' \itemize{
#'   \item [f1_results()] — Race results
#'   \item [f1_qualifying()] — Qualifying session results
#'   \item [f1_sprint()] — Sprint race results
#' }
#'
#' **Championship standings:**
#' \itemize{
#'   \item [f1_driver_standings()] — Drivers' championship
#'   \item [f1_constructor_standings()] — Constructors' championship
#' }
#'
#' **Reference data:**
#' \itemize{
#'   \item [f1_drivers()] — Driver information
#'   \item [f1_constructors()] — Constructor (team) information
#'   \item [f1_races()] — Race schedule
#'   \item [f1_circuits()] — Circuit information
#'   \item [f1_seasons()] — Available seasons
#' }
#'
#' **Detailed timing:**
#' \itemize{
#'   \item [f1_laps()] — Lap-by-lap timing (1996+)
#'   \item [f1_pit_stops()] — Pit stop data (2012+)
#' }
#'
#' **Caching:**
#' \itemize{
#'   \item [f1_clear_cache()] — Clear cached API responses
#' }
#'
#' @section Caching:
#' API responses are cached in memory for the duration of the R session (up to
#' one hour). Call [f1_clear_cache()] to force fresh requests.
#'
#' @section Data source:
#' Data is sourced from the [Jolpica API](https://api.jolpi.ca/ergast/),
#' a community-maintained successor to the Ergast API, covering the Formula 1
#' World Championship from 1950 to the present.
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom rlang .data
## usethis namespace: end
NULL
