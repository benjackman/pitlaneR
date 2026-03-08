# Get F1 constructor information

Retrieves constructor (team) information, optionally filtered to
constructors that participated in a specific season.

## Usage

``` r
f1_constructors(season = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). If `NULL`
  (default), returns all constructors in the database.

## Value

A tibble with one row per constructor, including columns:

- constructor_id:

  Character. Unique constructor identifier.

- name:

  Character. Constructor name.

- nationality:

  Character. Constructor nationality.

- url:

  Character. Wikipedia URL.

## See also

[`f1_drivers()`](https://benjackman.github.io/pitlaneR/reference/f1_drivers.md)
for driver information.

Other reference data:
[`f1_circuits()`](https://benjackman.github.io/pitlaneR/reference/f1_circuits.md),
[`f1_drivers()`](https://benjackman.github.io/pitlaneR/reference/f1_drivers.md),
[`f1_races()`](https://benjackman.github.io/pitlaneR/reference/f1_races.md),
[`f1_seasons()`](https://benjackman.github.io/pitlaneR/reference/f1_seasons.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Constructors from a specific season
f1_constructors(2024)

# All constructors in the database
f1_constructors()
} # }
```
