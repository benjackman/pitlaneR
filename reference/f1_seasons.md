# Get all F1 seasons

Retrieves a list of all Formula 1 World Championship seasons available
in the database, covering 1950 to the present.

## Usage

``` r
f1_seasons()
```

## Value

A tibble with one row per season, including columns:

- season:

  Integer. The season year.

- url:

  Character. Wikipedia URL for the season.

## See also

Other reference data:
[`f1_circuits()`](https://benjackman.github.io/pitlaneR/reference/f1_circuits.md),
[`f1_constructors()`](https://benjackman.github.io/pitlaneR/reference/f1_constructors.md),
[`f1_drivers()`](https://benjackman.github.io/pitlaneR/reference/f1_drivers.md),
[`f1_races()`](https://benjackman.github.io/pitlaneR/reference/f1_races.md)

## Examples

``` r
if (FALSE) { # \dontrun{
f1_seasons()
} # }
```
