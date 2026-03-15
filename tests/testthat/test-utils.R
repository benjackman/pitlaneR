# --- to_snake_case ---

test_that("to_snake_case converts camelCase", {
  expect_equal(to_snake_case("driverId"), "driver_id")
  expect_equal(to_snake_case("givenName"), "given_name")
  expect_equal(to_snake_case("circuitName"), "circuit_name")
  expect_equal(to_snake_case("dateOfBirth"), "date_of_birth")
})

test_that("to_snake_case handles already-snake and edge cases", {
  expect_equal(to_snake_case("already_snake"), "already_snake")
  expect_equal(to_snake_case("URL"), "url")
  expect_equal(to_snake_case("simpleword"), "simpleword")
  expect_equal(to_snake_case("ABCDef"), "abc_def")
})

test_that("to_snake_case handles vectors", {
  expect_equal(
    to_snake_case(c("driverId", "givenName", "URL")),
    c("driver_id", "given_name", "url")
  )
})

# --- safe_numeric ---

test_that("safe_numeric converts valid strings", {
  expect_equal(safe_numeric("42"), 42)
  expect_equal(safe_numeric("3.14"), 3.14)
  expect_equal(safe_numeric("-7.5"), -7.5)
  expect_equal(safe_numeric("0"), 0)
})

test_that("safe_numeric returns NA for non-numeric", {
  expect_true(is.na(safe_numeric("not_a_number")))
  expect_true(is.na(safe_numeric(NA)))
  expect_true(is.na(safe_numeric("")))
})

test_that("safe_numeric works on vectors", {
  result <- safe_numeric(c("1", "2.5", "bad", NA))
  expect_equal(result[1], 1)
  expect_equal(result[2], 2.5)
  expect_true(is.na(result[3]))
  expect_true(is.na(result[4]))
})

# --- safe_date ---

test_that("safe_date parses valid dates", {
  expect_equal(safe_date("2024-03-02"), as.Date("2024-03-02"))
  expect_equal(safe_date("1950-05-13"), as.Date("1950-05-13"))
})

test_that("safe_date returns NA for invalid input", {
  expect_true(is.na(safe_date(NA)))
  expect_true(is.na(safe_date("not-a-date")))
})

test_that("safe_date works on vectors", {
  result <- safe_date(c("2024-01-01", NA, "2024-12-31"))
  expect_equal(result[1], as.Date("2024-01-01"))
  expect_true(is.na(result[2]))
  expect_equal(result[3], as.Date("2024-12-31"))
})

# --- resolve_season ---

test_that("resolve_season defaults to current year", {
  expect_equal(resolve_season(NULL), as.character(as.integer(format(Sys.Date(), "%Y"))))
})

test_that("resolve_season passes through explicit values as character", {
  expect_equal(resolve_season(2024), "2024")
  expect_equal(resolve_season("2023"), "2023")
  expect_equal(resolve_season(1950L), "1950")
})

# --- flatten_and_rename ---

test_that("flatten_and_rename handles empty data frames", {
  expect_equal(nrow(flatten_and_rename(tibble::tibble())), 0)
  expect_s3_class(flatten_and_rename(tibble::tibble()), "tbl_df")
})

test_that("flatten_and_rename returns empty tibble for non-data-frame input", {
  expect_equal(nrow(flatten_and_rename(list())), 0)
})

test_that("flatten_and_rename flattens a simple data frame", {
  df <- data.frame(driverId = "max_verstappen", givenName = "Max",
                   stringsAsFactors = FALSE)
  result <- flatten_and_rename(df)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1)
  expect_true("driver_id" %in% names(result))
  expect_true("given_name" %in% names(result))
})

test_that("flatten_and_rename flattens nested data frame columns", {
  inner <- data.frame(locality = "Melbourne", country = "Australia",
                      stringsAsFactors = FALSE)
  df <- data.frame(circuitId = "albert_park", stringsAsFactors = FALSE)
  df$Location <- inner

  result <- flatten_and_rename(df)
  expect_true("location_locality" %in% names(result))
  expect_true("location_country" %in% names(result))
  expect_true("circuit_id" %in% names(result))
})

test_that("flatten_and_rename deduplicates stuttered prefixes", {
  inner <- data.frame(driverId = "ham", code = "HAM", stringsAsFactors = FALSE)
  df <- data.frame(position = "1", stringsAsFactors = FALSE)
  df$Driver <- inner

  result <- flatten_and_rename(df)
  # "Driver" prefix + "driverId" -> "driver_driver_id" -> deduplicated to "driver_id"
  expect_true("driver_id" %in% names(result))
  expect_true("driver_code" %in% names(result))
})

test_that("flatten_and_rename applies prefix argument", {
  df <- data.frame(id = "ver", name = "Max", stringsAsFactors = FALSE)
  result <- flatten_and_rename(df, prefix = "myPrefix")
  expect_true(all(grepl("^my_prefix_", names(result))))
})

# --- apply_type_conversions ---

# --- ensure_columns ---

test_that("ensure_columns adds missing columns as NA", {
  df <- tibble::tibble(a = 1:3, b = c("x", "y", "z"))
  result <- ensure_columns(df, c("a", "b", "c", "d"))
  expect_true("c" %in% names(result))
  expect_true("d" %in% names(result))
  expect_true(all(is.na(result$c)))
  expect_true(all(is.na(result$d)))
})

test_that("ensure_columns preserves existing columns", {
  df <- tibble::tibble(a = 1:3, b = c("x", "y", "z"))
  result <- ensure_columns(df, c("a", "b"))
  expect_equal(result$a, 1:3)
  expect_equal(result$b, c("x", "y", "z"))
})

test_that("ensure_columns reorders to match expected order", {
  df <- tibble::tibble(b = 1, a = 2)
  result <- ensure_columns(df, c("a", "b"))
  expect_equal(names(result)[1:2], c("a", "b"))
})

test_that("ensure_columns keeps extra columns after expected ones", {
  df <- tibble::tibble(a = 1, extra = "bonus")
  result <- ensure_columns(df, c("a", "b"))
  expect_equal(names(result), c("a", "b", "extra"))
  expect_true(is.na(result$b))
  expect_equal(result$extra, "bonus")
})

# --- apply_type_conversions ---

test_that("apply_type_conversions converts date columns", {
  df <- tibble::tibble(date = "2024-03-02", date_of_birth = "1997-09-30")
  result <- apply_type_conversions(df)
  expect_s3_class(result$date, "Date")
  expect_s3_class(result$date_of_birth, "Date")
})

test_that("apply_type_conversions converts integer columns", {
  df <- tibble::tibble(position = "1", grid = "3", laps = "57",
                       lap = "12", round = "5", season = "2024")
  result <- apply_type_conversions(df)
  expect_type(result$position, "integer")
  expect_type(result$grid, "integer")
  expect_type(result$laps, "integer")
  expect_type(result$lap, "integer")
  expect_type(result$round, "integer")
  expect_type(result$season, "integer")
})

test_that("apply_type_conversions converts numeric columns", {
  df <- tibble::tibble(points = "25.0", lat = "-37.849", long = "144.968")
  result <- apply_type_conversions(df)
  expect_type(result$points, "double")
  expect_type(result$lat, "double")
  expect_type(result$long, "double")
})

test_that("apply_type_conversions leaves character columns unchanged", {
  df <- tibble::tibble(driver_id = "verstappen", status = "Finished")
  result <- apply_type_conversions(df)
  expect_type(result$driver_id, "character")
  expect_type(result$status, "character")
})

test_that("apply_type_conversions handles NA values gracefully", {
  df <- tibble::tibble(position = c("1", NA), date = c("2024-01-01", NA))
  result <- apply_type_conversions(df)
  expect_true(is.na(result$position[2]))
  expect_true(is.na(result$date[2]))
})

test_that("apply_type_conversions integer patterns take priority over numeric", {
  # "position" matches both integer and numeric patterns; integer should win
  df <- tibble::tibble(position = "1")
  result <- apply_type_conversions(df)
  expect_type(result$position, "integer")
})
