# Getting Started with pitlaneR

pitlaneR provides tidy access to Formula 1 data from the [Jolpica
API](https://api.jolpi.ca/ergast/), a free, community-maintained
successor to the Ergast API. It covers the entire history of the F1
World Championship from 1950 to the present — no API key or Python
dependency required.

Important: the current version of this R package was largely produce by
Claude, as part of Posit’s AI beta. This code is only partially tested,
and so should be treated with caution. Read about this process [on my
blog](https://benjackman.github.io/tinkering/#claude-builds-an-r-package).

All functions return tibbles with snake_case column names and automatic
type conversion. API responses are cached in memory for one hour, so
repeated calls are fast.

``` r
library(pitlaneR)
```

## Seasons

[`f1_seasons()`](https://benjackman.github.io/pitlaneR/reference/f1_seasons.md)
returns every F1 season available in the database.

``` r
f1_seasons()
```

## Race schedule

[`f1_races()`](https://benjackman.github.io/pitlaneR/reference/f1_races.md)
returns the race calendar for a given season, including circuit details
and session times. It defaults to the current year.

``` r
# Current season
f1_races()

# A specific season
f1_races(2024)
```

## Circuits

[`f1_circuits()`](https://benjackman.github.io/pitlaneR/reference/f1_circuits.md)
returns circuit information, including geographic coordinates. Pass a
season to see only circuits used that year, or omit it for all circuits
in the database.

``` r
# Circuits used in 2024
f1_circuits(2024)

# All circuits ever used in F1
f1_circuits()
```

## Drivers and constructors

[`f1_drivers()`](https://benjackman.github.io/pitlaneR/reference/f1_drivers.md)
and
[`f1_constructors()`](https://benjackman.github.io/pitlaneR/reference/f1_constructors.md)
return reference information about drivers and teams. Both accept an
optional season to filter to participants from that year.

``` r
# Drivers who raced in 2024
f1_drivers(2024)

# All constructors in the database
f1_constructors()
```

## Race results

[`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md)
returns finishing results for a season, or for a specific round within a
season. Each row represents one driver’s result for one race.

``` r
# All results for the 2024 season
f1_results(2024)

# Just round 1
f1_results(2024, round = 1)
```

The returned tibble includes grid position, finishing position, points,
status, driver and constructor details, and (where available) fastest
lap information.

## Qualifying results

[`f1_qualifying()`](https://benjackman.github.io/pitlaneR/reference/f1_qualifying.md)
returns qualifying session results, including Q1, Q2, and Q3 lap times.

**Note:** Qualifying data is only available from the 1994 season onward.
Requesting an earlier season will raise an error.

``` r
f1_qualifying(2024, round = 1)
```

## Sprint results

[`f1_sprint()`](https://benjackman.github.io/pitlaneR/reference/f1_sprint.md)
returns results from sprint races, which were introduced in the 2021
season. The function returns an empty tibble for seasons or rounds
without sprints.

``` r
# All sprint results from 2024
f1_sprint(2024)
```

## Championship standings

[`f1_driver_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_driver_standings.md)
and
[`f1_constructor_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_constructor_standings.md)
return the championship table for a given season. By default they return
the final (or latest available) standings; pass a round number to see
the standings at a specific point in the season.

``` r
# Final 2024 drivers' championship
f1_driver_standings(2024)

# Constructors' standings after round 10
f1_constructor_standings(2024, round = 10)
```

## Lap times

[`f1_laps()`](https://benjackman.github.io/pitlaneR/reference/f1_laps.md)
returns lap-by-lap timing data for a specific race. Both `season` and
`round` are required. You can optionally request a single lap.

**Note:** Lap time data is available from the 1996 season onward. This
endpoint can return a large volume of data; a progress bar is shown for
multi-page fetches.

``` r
# All laps from the 2024 Bahrain GP (round 1)
f1_laps(2024, round = 1)

# Just the first lap
f1_laps(2024, round = 1, lap = 1)
```

## Pit stops

[`f1_pit_stops()`](https://benjackman.github.io/pitlaneR/reference/f1_pit_stops.md)
returns pit stop data for a specific race, including the stop number,
lap, time of day, and duration.

**Note:** Pit stop data is available from the 2012 season onward.

``` r
f1_pit_stops(2024, round = 1)
```

## Caching

API responses are cached in memory for up to one hour to avoid redundant
requests. If you need fresh data (e.g. during a live race weekend),
clear the cache:

``` r
f1_clear_cache()
```

## Summary of functions

| Function                                                                                                    | Description                          | Data availability |
|:------------------------------------------------------------------------------------------------------------|:-------------------------------------|:------------------|
| [`f1_seasons()`](https://benjackman.github.io/pitlaneR/reference/f1_seasons.md)                             | All F1 seasons                       | 1950–present      |
| [`f1_races()`](https://benjackman.github.io/pitlaneR/reference/f1_races.md)                                 | Race schedule and session times      | 1950–present      |
| [`f1_circuits()`](https://benjackman.github.io/pitlaneR/reference/f1_circuits.md)                           | Circuit information and coordinates  | 1950–present      |
| [`f1_drivers()`](https://benjackman.github.io/pitlaneR/reference/f1_drivers.md)                             | Driver information                   | 1950–present      |
| [`f1_constructors()`](https://benjackman.github.io/pitlaneR/reference/f1_constructors.md)                   | Constructor (team) information       | 1950–present      |
| [`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md)                             | Race finishing results               | 1950–present      |
| [`f1_qualifying()`](https://benjackman.github.io/pitlaneR/reference/f1_qualifying.md)                       | Qualifying session results           | 1994–present      |
| [`f1_sprint()`](https://benjackman.github.io/pitlaneR/reference/f1_sprint.md)                               | Sprint race results                  | 2021–present      |
| [`f1_driver_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_driver_standings.md)           | Drivers’ championship standings      | 1950–present      |
| [`f1_constructor_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_constructor_standings.md) | Constructors’ championship standings | 1958–present      |
| [`f1_laps()`](https://benjackman.github.io/pitlaneR/reference/f1_laps.md)                                   | Lap-by-lap timing data               | 1996–present      |
| [`f1_pit_stops()`](https://benjackman.github.io/pitlaneR/reference/f1_pit_stops.md)                         | Pit stop data                        | 2012–present      |
| [`f1_clear_cache()`](https://benjackman.github.io/pitlaneR/reference/f1_clear_cache.md)                     | Clear cached API responses           | —                 |
