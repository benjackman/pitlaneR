# Get F1 lap time data

Retrieves lap-by-lap timing data for a specific race. This endpoint can
return a large amount of data; a progress bar is shown for multi-page
fetches.

## Usage

``` r
f1_laps(season, round, lap = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). **Required** (no
  default).

- round:

  Integer or character. The round number. **Required** (no default).

- lap:

  Integer or character. A specific lap number. If `NULL` (default),
  returns timing data for all laps in the race.

## Value

A tibble with one row per driver per lap, including columns:

- season:

  Integer. Season year.

- round:

  Integer. Round number.

- race_name:

  Character. Name of the Grand Prix.

- lap:

  Integer. Lap number.

- driver_id:

  Character. Unique driver identifier.

- position:

  Integer. Position at end of this lap.

- time:

  Character. Lap time.

## Details

Lap time data is available from the 1996 season onward.

## See also

[`f1_pit_stops()`](https://benjackman.github.io/pitlaneR/reference/f1_pit_stops.md)
for pit stop data,
[`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md)
for final race results.

Other detailed timing:
[`f1_pit_stops()`](https://benjackman.github.io/pitlaneR/reference/f1_pit_stops.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# All lap times for a race
f1_laps(2024, 1)

# First lap only
f1_laps(2024, 1, lap = 1)
} # }
```
