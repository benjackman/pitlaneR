# Get F1 circuit information

Retrieves circuit information, optionally filtered to circuits used in a
specific season.

## Usage

``` r
f1_circuits(season = NULL)
```

## Arguments

- season:

  Integer or character. The season year (e.g., `2024`). If `NULL`
  (default), returns all circuits in the database.

## Value

A tibble with one row per circuit, including columns:

- circuit_id:

  Character. Unique circuit identifier.

- circuit_name:

  Character. Full circuit name.

- location_locality:

  Character. City or locality.

- location_country:

  Character. Country.

- location_lat:

  Numeric. Latitude.

- location_long:

  Numeric. Longitude.

- url:

  Character. Wikipedia URL.

## See also

[`f1_races()`](https://benjackman.github.io/pitlaneR/reference/f1_races.md)
for the race schedule including circuit details.

Other reference data:
[`f1_constructors()`](https://benjackman.github.io/pitlaneR/reference/f1_constructors.md),
[`f1_drivers()`](https://benjackman.github.io/pitlaneR/reference/f1_drivers.md),
[`f1_races()`](https://benjackman.github.io/pitlaneR/reference/f1_races.md),
[`f1_seasons()`](https://benjackman.github.io/pitlaneR/reference/f1_seasons.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# All circuits in the database
f1_circuits()

# Circuits used in a specific season
f1_circuits(2024)
} # }
```
