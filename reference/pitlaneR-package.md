# pitlaneR: Access Formula 1 Data from the Jolpica API

Provides tidy access to historical and current Formula 1 data via the
free Jolpica API (Ergast-compatible). All data is returned as tibbles
with snake_case column names and automatic type conversion. No API key
or Python dependency required.

## Main functions

**Race results:**

- [`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md)
  — Race results

- [`f1_qualifying()`](https://benjackman.github.io/pitlaneR/reference/f1_qualifying.md)
  — Qualifying session results

- [`f1_sprint()`](https://benjackman.github.io/pitlaneR/reference/f1_sprint.md)
  — Sprint race results

**Championship standings:**

- [`f1_driver_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_driver_standings.md)
  — Drivers' championship

- [`f1_constructor_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_constructor_standings.md)
  — Constructors' championship

**Reference data:**

- [`f1_drivers()`](https://benjackman.github.io/pitlaneR/reference/f1_drivers.md)
  — Driver information

- [`f1_constructors()`](https://benjackman.github.io/pitlaneR/reference/f1_constructors.md)
  — Constructor (team) information

- [`f1_races()`](https://benjackman.github.io/pitlaneR/reference/f1_races.md)
  — Race schedule

- [`f1_circuits()`](https://benjackman.github.io/pitlaneR/reference/f1_circuits.md)
  — Circuit information

- [`f1_seasons()`](https://benjackman.github.io/pitlaneR/reference/f1_seasons.md)
  — Available seasons

**Detailed timing:**

- [`f1_laps()`](https://benjackman.github.io/pitlaneR/reference/f1_laps.md)
  — Lap-by-lap timing (1996+)

- [`f1_pit_stops()`](https://benjackman.github.io/pitlaneR/reference/f1_pit_stops.md)
  — Pit stop data (2012+)

**Caching:**

- [`f1_clear_cache()`](https://benjackman.github.io/pitlaneR/reference/f1_clear_cache.md)
  — Clear cached API responses

## Caching

API responses are cached in memory for the duration of the R session (up
to one hour). Call
[`f1_clear_cache()`](https://benjackman.github.io/pitlaneR/reference/f1_clear_cache.md)
to force fresh requests.

## Data source

Data is sourced from the [Jolpica API](https://api.jolpi.ca/ergast/), a
community-maintained successor to the Ergast API, covering the Formula 1
World Championship from 1950 to the present.

## See also

Useful links:

- <https://github.com/benjackman/pitlaneR>

- <https://benjackman.github.io/pitlaneR/>

- Report bugs at <https://github.com/benjackman/pitlaneR/issues>

## Author

**Maintainer**: Ben Jackman <ben@example.com>
