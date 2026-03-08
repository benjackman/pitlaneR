# Get F1 pit stop data

Retrieves pit stop data for a specific race, including stop number, lap,
time of day, and duration.

## Usage

``` r
f1_pit_stops(season, round)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). **Required** (no
  default).

- round:

  Integer or character. The round number. **Required** (no default).

## Value

A tibble with one row per pit stop, including columns:

- season:

  Integer. Season year.

- round:

  Integer. Round number.

- race_name:

  Character. Name of the Grand Prix.

- driver_id:

  Character. Unique driver identifier.

- stop:

  Integer. Pit stop number for that driver (1st, 2nd, etc.).

- lap:

  Integer. Lap on which the pit stop occurred.

- time:

  Character. Time of day of the pit stop.

- duration:

  Character. Duration of the pit stop.

## Details

Pit stop data is available from the 2012 season onward.

## See also

[`f1_laps()`](https://benjackman.github.io/pitlaneR/reference/f1_laps.md)
for lap-by-lap timing data,
[`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md)
for final race results.

Other detailed timing:
[`f1_laps()`](https://benjackman.github.io/pitlaneR/reference/f1_laps.md)

## Examples

``` r
if (FALSE) { # \dontrun{
f1_pit_stops(2024, 1)
} # }
```
