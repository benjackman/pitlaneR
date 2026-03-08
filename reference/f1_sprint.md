# Get F1 sprint race results

Retrieves sprint race results for a given season and optionally a
specific round. Sprint races were introduced in 2021 and are shorter
races held on Saturday at selected events.

## Usage

``` r
f1_sprint(season = NULL, round = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). Defaults to the
  current year.

- round:

  Integer or character. The round number within the season. If `NULL`
  (default), returns sprint results for all rounds in the season.

## Value

A tibble with one row per driver per sprint race, including columns:

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

  Character. Finishing status.

- driver\_Driver details (id, code, given/family name, etc.).
  constructor\_:

  Constructor details (id, name, nationality).

Returns an empty tibble for seasons or rounds without sprint races.

## See also

[`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md)
for main race results,
[`f1_qualifying()`](https://benjackman.github.io/pitlaneR/reference/f1_qualifying.md)
for qualifying results.

Other race results:
[`f1_qualifying()`](https://benjackman.github.io/pitlaneR/reference/f1_qualifying.md),
[`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Sprint results for a specific race
f1_sprint(2024, 1)

# All sprint results for a season
f1_sprint(2024)
} # }
```
