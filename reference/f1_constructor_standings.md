# Get F1 constructor championship standings

Retrieves the World Constructors' Championship standings for a given
season, optionally at a specific round. The Constructors' Championship
has been awarded since 1958.

## Usage

``` r
f1_constructor_standings(season = NULL, round = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). Defaults to the
  current year.

- round:

  Integer or character. The round number. If `NULL` (default), returns
  the final (or latest available) standings for the season.

## Value

A tibble with one row per constructor, including columns:

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

- constructor\_\*:

  Constructor details (id, name, nationality).

## See also

[`f1_driver_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_driver_standings.md)
for the drivers' championship.

Other standings:
[`f1_driver_standings()`](https://benjackman.github.io/pitlaneR/reference/f1_driver_standings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Final standings for a season
f1_constructor_standings(2024)

# Standings after round 5
f1_constructor_standings(2024, 5)
} # }
```
