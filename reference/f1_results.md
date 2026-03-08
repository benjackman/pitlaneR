# Get F1 race results

Retrieves race results for a given season and optionally a specific
round.

## Usage

``` r
f1_results(season = NULL, round = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). Defaults to the
  current year.

- round:

  Integer or character. The round number within the season. If `NULL`
  (default), returns results for all rounds in the season.

## Value

A tibble with one row per driver per race, including columns:

- season:

  Integer. Season year.

- round:

  Integer. Round number.

- race_name:

  Character. Name of the Grand Prix.

- race_date:

  Date. Date of the race.

- number:

  Integer. Driver's car number.

- position:

  Integer. Finishing position.

- points:

  Numeric. Points awarded.

- grid:

  Integer. Starting grid position.

- laps:

  Integer. Number of laps completed.

- status:

  Character. Finishing status (e.g., "Finished", "+1 Lap").

- driver\_Driver details (id, code, given/family name, etc.).
  constructor\_:

  Constructor details (id, name, nationality).

- time\_Race time information (where available). fastest_lap\_:

  Fastest lap details (where available).

## See also

[`f1_qualifying()`](https://benjackman.github.io/pitlaneR/reference/f1_qualifying.md)
for qualifying session results,
[`f1_sprint()`](https://benjackman.github.io/pitlaneR/reference/f1_sprint.md)
for sprint race results.

Other race results:
[`f1_qualifying()`](https://benjackman.github.io/pitlaneR/reference/f1_qualifying.md),
[`f1_sprint()`](https://benjackman.github.io/pitlaneR/reference/f1_sprint.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Results for a specific race
f1_results(2024, 1)

# All results for a season
f1_results(2024)
} # }
```
