# Get F1 driver championship standings

Retrieves the World Drivers' Championship standings for a given season,
optionally at a specific round.

## Usage

``` r
f1_driver_standings(season = NULL, round = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). Defaults to the
  current year.

- round:

  Integer or character. The round number. If `NULL` (default), returns
  the final (or latest available) standings for the season.

## Value

A tibble with one row per driver, including columns:

- season:

  Integer. Season year.

- standings_round:

  Integer. Round number at which the standings apply.

- position:

  Integer. Championship position.

- points:

  Numeric. Total championship points.

- wins:

  Integer. Number of race wins.

- driver\_Driver details (id, code, given/family name, etc.).
  constructor\_:

  Constructor details for the driver's team.

## See also

[`f1_constructor_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_constructor_standings.md)
for the constructors' championship.

Other standings:
[`f1_constructor_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_constructor_standings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Final standings for a season
f1_driver_standings(2024)

# Standings after round 5
f1_driver_standings(2024, 5)
} # }
```
