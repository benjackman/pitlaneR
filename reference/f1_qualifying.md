# Get F1 qualifying results

Retrieves qualifying session results for a given season and optionally a
specific round. Qualifying data is only available from the **1994 season
onward**; requesting earlier seasons will raise an error.

## Usage

``` r
f1_qualifying(season = NULL, round = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`), must be 1994 or
  later (the Jolpica API does not provide qualifying results earlier
  than 1994). Defaults to the current year.

- round:

  Integer or character. The round number within the season. If `NULL`
  (default), returns qualifying results for all rounds in the season.

## Value

A tibble with one row per driver per qualifying session, including
columns:

- season:

  Integer. Season year.

- round:

  Integer. Round number.

- race_name:

  Character. Name of the Grand Prix.

- race_date:

  Date. Date of the race.

- position:

  Integer. Final qualifying position.

- q1, q2, q3:

  Character. Lap times set in each qualifying session. Missing if the
  driver did not participate in that session.

- driver\_Driver details (id, code, given/family name, etc.).
  constructor\_:

  Constructor details (id, name, nationality).

## See also

[`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md)
for race results,
[`f1_sprint()`](https://benjackman.github.io/pitlaneR/reference/f1_sprint.md)
for sprint results.

Other race results:
[`f1_results()`](https://benjackman.github.io/pitlaneR/reference/f1_results.md),
[`f1_sprint()`](https://benjackman.github.io/pitlaneR/reference/f1_sprint.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Qualifying for a specific race
f1_qualifying(2024, 1)

# All qualifying results for a season
f1_qualifying(2024)
} # }
```
