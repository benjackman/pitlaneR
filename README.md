# pitlaneR

Access Formula 1 data from R using the free [Jolpica API](https://jolpi.ca) (Ergast-compatible). No API key or Python dependency required.

Important: the current version of this R package was largely produce by Claude, as part of Posit's AI beta. This code is only partially tested, and so should be treated with caution. Read about this process [on my blog](https://benjackman.github.io/tinkering/#claude-builds-an-r-package).

## Installation

```r
# Install from GitHub
# install.packages("pak")
pak::pak("benjackman/pitlaneR")
```

## Quick start

```r
library(pitlaneR)

# Race results for a specific round
f1_results(2024, 1)

# Full season results
f1_results(2024)

# Current championship standings
f1_driver_standings(2024)
f1_constructor_standings(2024)

# Qualifying results
f1_qualifying(2024, 1)

# Drivers and constructors
f1_drivers(2024)
f1_constructors(2024)

# Race schedule
f1_races(2024)

# Circuit info
f1_circuits()

# Lap times (available from 1996+)
f1_laps(2024, 1)

# Pit stops (available from 2012+)
f1_pit_stops(2024, 1)

# Sprint results
f1_sprint(2024)

# All F1 seasons
f1_seasons()
```

## Features

- **Tidy output**: All functions return tibbles with snake_case column names
- **Automatic pagination**: Large result sets are fetched across multiple API pages automatically
- **Session caching**: Repeated calls are served from an in-memory cache (reset with `f1_clear_cache()`)
- **Historical coverage**: Data from 1950 to the present season

## Data source

All data comes from the [Jolpica F1 API](https://jolpi.ca), a free, community-maintained successor to the Ergast Motor Racing API.

## License

MIT
