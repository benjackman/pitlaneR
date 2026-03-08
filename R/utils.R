# Shared utility functions for tidying API responses

#' Convert camelCase or PascalCase to snake_case
#' @noRd
to_snake_case <- function(x) {
  x <- gsub("([a-z])([A-Z])", "\\1_\\2", x)
  x <- gsub("([A-Z]+)([A-Z][a-z])", "\\1_\\2", x)
  tolower(x)
}

#' Safely convert a column to numeric, leaving NAs for non-numeric values
#' @noRd
safe_numeric <- function(x) {
  suppressWarnings(as.numeric(x))
}

#' Safely convert a column to Date
#' @noRd
safe_date <- function(x) {
  as.Date(x, format = "%Y-%m-%d")
}

#' Flatten nested data frame columns and snake_case all names
#'
#' Takes a data frame that may contain nested data frame columns (from JSON)
#' and flattens them into a single level with prefix_name convention, then
#' converts all column names to snake_case.
#'
#' @param df A data frame, possibly with nested data frame columns
#' @param prefix Optional prefix for column names
#' @return A tibble with flattened, snake_case column names
#' @noRd
flatten_and_rename <- function(df, prefix = NULL) {
  if (!is.data.frame(df) || nrow(df) == 0) {
    return(tibble::tibble())
  }

  result <- tibble::tibble(.rows = nrow(df))

  for (col_name in names(df)) {
    col <- df[[col_name]]
    full_name <- if (!is.null(prefix)) paste0(prefix, "_", col_name) else col_name

    if (is.data.frame(col)) {
      nested <- flatten_and_rename(col, prefix = full_name)
      result <- dplyr::bind_cols(result, nested)
    } else {
      result[[full_name]] <- col
    }
  }

  names(result) <- to_snake_case(names(result))

  # Deduplicate stuttered prefixes: "driver_driver_id" -> "driver_id"
  names(result) <- gsub("^([a-z]+)_\\1_", "\\1_", names(result))

  result
}

#' Apply standard type conversions to known column patterns
#' @noRd
apply_type_conversions <- function(df) {
  numeric_patterns <- c(
    "position", "points", "grid", "laps", "number", "wins",
    "permanent_number", "lat", "long", "millis", "stop", "rank",
    "duration"
  )
  date_patterns <- c("date", "date_of_birth")
  integer_patterns <- c("position", "grid", "laps", "number", "wins",
                        "permanent_number", "stop", "rank", "round", "season")

  for (col in names(df)) {
    if (any(vapply(date_patterns, function(p) col == p || endsWith(col, p),
                   logical(1)))) {
      df[[col]] <- safe_date(df[[col]])
    } else if (any(vapply(integer_patterns, function(p) col == p || endsWith(col, p),
                          logical(1)))) {
      df[[col]] <- suppressWarnings(as.integer(df[[col]]))
    } else if (any(vapply(numeric_patterns, function(p) col == p || endsWith(col, p),
                          logical(1)))) {
      df[[col]] <- safe_numeric(df[[col]])
    }
  }

  df
}

#' Standard season argument handling
#' @noRd
resolve_season <- function(season = NULL) {
  if (is.null(season)) {
    as.character(as.integer(format(Sys.Date(), "%Y")))
  } else {
    as.character(as.integer(season))
  }
}
