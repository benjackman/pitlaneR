# Get F1 driver information

Retrieves driver information, optionally filtered to drivers who
participated in a specific season.

## Usage

``` r
f1_drivers(season = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). If `NULL`
  (default), returns all drivers in the database.

## Value

A tibble with one row per driver, including columns:

- driver_id:

  Character. Unique driver identifier.

- permanent_number:

  Integer. Driver's permanent car number.

- code:

  Character. Three-letter driver code (e.g., `"VER"`).

- given_name:

  Character. Driver's first name.

- family_name:

  Character. Driver's last name.

- date_of_birth:

  Date. Driver's date of birth.

- nationality:

  Character. Driver's nationality.

- url:

  Character. Wikipedia URL.

## See also

[`f1_constructors()`](https://benjackman.github.io/pitlaneR/reference/f1_constructors.md)
for team information.

Other reference data:
[`f1_circuits()`](https://benjackman.github.io/pitlaneR/reference/f1_circuits.md),
[`f1_constructors()`](https://benjackman.github.io/pitlaneR/reference/f1_constructors.md),
[`f1_races()`](https://benjackman.github.io/pitlaneR/reference/f1_races.md),
[`f1_seasons()`](https://benjackman.github.io/pitlaneR/reference/f1_seasons.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Drivers from a specific season
f1_drivers(2024)

# All drivers in the database
f1_drivers()
} # }
```
