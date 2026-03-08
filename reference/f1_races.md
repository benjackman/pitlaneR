# Get F1 race schedule

Retrieves the race schedule for a given season, including circuit
information, dates, and session times.

## Usage

``` r
f1_races(season = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). Defaults to the
  current year.

## Value

A tibble with one row per race, including columns:

- season:

  Integer. Season year.

- round:

  Integer. Round number.

- race_name:

  Character. Name of the Grand Prix.

- date:

  Date. Date of the race.

- time:

  Character. Scheduled start time (UTC).

- url:

  Character. Wikipedia URL for the race.

- circuit\_Circuit details (id, name, location, coordinates).
  first_practice\_:

  First practice session date and time.

- qualifying\_Qualifying session date and time. sprint\_:

  Sprint session date and time (where applicable).

## See also

[`f1_circuits()`](https://benjackman.github.io/pitlaneR/reference/f1_circuits.md)
for detailed circuit information.

Other reference data:
[`f1_circuits()`](https://benjackman.github.io/pitlaneR/reference/f1_circuits.md),
[`f1_constructors()`](https://benjackman.github.io/pitlaneR/reference/f1_constructors.md),
[`f1_drivers()`](https://benjackman.github.io/pitlaneR/reference/f1_drivers.md),
[`f1_seasons()`](https://benjackman.github.io/pitlaneR/reference/f1_seasons.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Race schedule for a specific season
f1_races(2024)

# Current season schedule
f1_races()
} # }
```
