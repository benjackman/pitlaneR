# Clear the pitlaneR session cache

Removes all cached API responses from the current R session. API
responses are cached in memory for one hour to reduce redundant
requests. Use this function to force fresh data from the API on
subsequent calls.

## Usage

``` r
f1_clear_cache()
```

## Value

Invisible `NULL`. A success message is printed via
[`cli::cli_alert_success()`](https://cli.r-lib.org/reference/cli_alert.html).

## Examples

``` r
f1_clear_cache()
#> ✔ pitlaneR cache cleared.
```
