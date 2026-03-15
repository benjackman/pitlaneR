# Live API tests — these hit the real Jolpica API.
# Skip on CRAN and in CI if no internet.
# The Jolpica API has a burst limit of 4 req/s, so we add small sleeps
# between tests to avoid HTTP 429 errors.

# --- f1_seasons ---

test_that("f1_seasons returns a tibble with expected columns", {
  skip_if_api_unavailable()

  result <- f1_seasons()
  expect_s3_class(result, "tbl_df")
  expect_true("season" %in% names(result))
  expect_true("url" %in% names(result))
  expect_true(nrow(result) > 70)
  expect_type(result$season, "integer")
})

Sys.sleep(1)

# --- f1_results ---

test_that("f1_results returns data for a known race", {
  skip_if_api_unavailable()

  result <- f1_results(2024, 1)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) == 20)
  expect_true("driver_given_name" %in% names(result))
  expect_true("position" %in% names(result))
  expect_true("points" %in% names(result))
  expect_type(result$position, "integer")
  expect_type(result$points, "double")
})

Sys.sleep(1)

test_that("f1_results returns all rounds for a season", {
  skip_if_api_unavailable()

  result <- f1_results(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 100)
  expect_true("season" %in% names(result))
  expect_true("round" %in% names(result))
  expect_true("race_name" %in% names(result))
})

Sys.sleep(2)

# --- f1_drivers ---

test_that("f1_drivers returns drivers for a season", {
  skip_if_api_unavailable()

  result <- f1_drivers(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 20)
  expect_true("driver_id" %in% names(result))
  expect_true("given_name" %in% names(result))
  expect_true("family_name" %in% names(result))
  expect_true("date_of_birth" %in% names(result))
  expect_s3_class(result$date_of_birth, "Date")
})

Sys.sleep(1)

# --- f1_constructors ---

test_that("f1_constructors returns constructors for a season", {
  skip_if_api_unavailable()

  result <- f1_constructors(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 10)
  expect_true("constructor_id" %in% names(result))
  expect_true("name" %in% names(result))
  expect_true("nationality" %in% names(result))
})

Sys.sleep(1)

test_that("f1_constructors without season returns all constructors", {
  skip_if_api_unavailable()

  result <- f1_constructors()
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 50)
})

Sys.sleep(2)

# --- f1_races ---

test_that("f1_races returns schedule data", {
  skip_if_api_unavailable()

  result <- f1_races(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 20)
  expect_true("race_name" %in% names(result))
  expect_true("season" %in% names(result))
  expect_true("round" %in% names(result))
  expect_true("date" %in% names(result))
  expect_s3_class(result$date, "Date")
})

Sys.sleep(1)

# --- f1_circuits ---

test_that("f1_circuits returns circuit data for a season", {
  skip_if_api_unavailable()

  result <- f1_circuits(2024)
  expect_s3_class(result, "tbl_df")
  expect_true("circuit_id" %in% names(result))
  expect_true("circuit_name" %in% names(result))
  expect_true("location_lat" %in% names(result))
  expect_true("location_long" %in% names(result))
  expect_type(result$location_lat, "double")
  expect_type(result$location_long, "double")
})

Sys.sleep(1)

test_that("f1_circuits without season returns all circuits", {
  skip_if_api_unavailable()

  result <- f1_circuits()
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 50)
})

Sys.sleep(2)

# --- f1_qualifying ---

test_that("f1_qualifying returns data for a known race", {
  skip_if_api_unavailable()

  result <- f1_qualifying(2024, 1)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 15)
  expect_true("position" %in% names(result))
  expect_true("season" %in% names(result))
  expect_true("race_name" %in% names(result))
})

Sys.sleep(1)

# --- f1_sprint ---

test_that("f1_sprint returns data for a season with sprints", {
  skip_if_api_unavailable()

  result <- f1_sprint(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 0)
  expect_true("position" %in% names(result))
  expect_true("season" %in% names(result))
})

Sys.sleep(1)

test_that("f1_sprint returns empty tibble for pre-2021 season", {
  skip_if_api_unavailable()

  result <- f1_sprint(2020)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0)
})

Sys.sleep(1)

# --- f1_driver_standings ---

test_that("f1_driver_standings returns data for a known season", {
  skip_if_api_unavailable()

  result <- f1_driver_standings(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 20)
  expect_true("season" %in% names(result))
  expect_true("position" %in% names(result))
  expect_true("points" %in% names(result))
  expect_true("wins" %in% names(result))
  expect_type(result$position, "integer")
  expect_type(result$points, "double")
})

Sys.sleep(1)

test_that("f1_driver_standings respects round parameter", {
  skip_if_api_unavailable()

  result <- f1_driver_standings(2024, 5)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 20)
  expect_true("standings_round" %in% names(result))
})

Sys.sleep(1)

# --- f1_constructor_standings ---

test_that("f1_constructor_standings returns data for a known season", {
  skip_if_api_unavailable()

  result <- f1_constructor_standings(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 10)
  expect_true("season" %in% names(result))
  expect_true("position" %in% names(result))
  expect_true("points" %in% names(result))
  expect_true("wins" %in% names(result))
})

Sys.sleep(1)

test_that("f1_constructor_standings respects round parameter", {
  skip_if_api_unavailable()

  result <- f1_constructor_standings(2024, 5)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 10)
  expect_true("standings_round" %in% names(result))
})

Sys.sleep(1)

# --- f1_laps ---

test_that("f1_laps can retrieve a single lap", {
  skip_if_api_unavailable()

  result <- f1_laps(2024, 1, lap = 1)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 15)
  expect_true(all(result$lap == 1L))
  expect_true("season" %in% names(result))
  expect_true("round" %in% names(result))
  expect_true("driver_id" %in% names(result))
  expect_true("position" %in% names(result))
  expect_true("time" %in% names(result))
})

Sys.sleep(1)

# --- f1_pit_stops ---

# --- Column consistency for early years ---

test_that("f1_results has consistent columns for 1950", {
  skip_if_api_unavailable()

  recent <- f1_results(2024, 1)
  Sys.sleep(1)
  early <- f1_results(1950, 1)
  expect_equal(names(early), names(recent))
  # fastest_lap columns should be NA for 1950
  expect_true(all(is.na(early$fastest_lap_rank)))
})

Sys.sleep(1)

test_that("f1_drivers has consistent columns for 1950", {
  skip_if_api_unavailable()

  recent <- f1_drivers(2024)
  Sys.sleep(1)
  early <- f1_drivers(1950)
  expect_equal(names(early), names(recent))
  # permanent_number and code should be NA for 1950
  expect_true(all(is.na(early$permanent_number)))
})

Sys.sleep(1)

test_that("f1_qualifying has consistent columns for 1994", {
  skip_if_api_unavailable()

  recent <- f1_qualifying(2024, 1)
  Sys.sleep(1)
  early <- f1_qualifying(1994, 1)
  expect_equal(names(early), names(recent))
})

Sys.sleep(1)

test_that("f1_races has consistent columns for 1950", {
  skip_if_api_unavailable()

  recent <- f1_races(2024)
  Sys.sleep(1)
  early <- f1_races(1950)
  expect_equal(names(early), names(recent))
  # Session time columns should be NA for 1950
  expect_true(all(is.na(early$qualifying_date)))
})

Sys.sleep(1)

# --- f1_pit_stops ---

test_that("f1_pit_stops returns pit stop data for a known race", {
  skip_if_api_unavailable()

  result <- f1_pit_stops(2024, 1)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 0)
  expect_true("season" %in% names(result))
  expect_true("round" %in% names(result))
  expect_true("race_name" %in% names(result))
  expect_true("driver_id" %in% names(result))
  expect_true("stop" %in% names(result))
  expect_true("lap" %in% names(result))
  expect_type(result$stop, "integer")
  expect_type(result$lap, "integer")
})
