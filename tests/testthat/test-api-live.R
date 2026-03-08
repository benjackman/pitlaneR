# Live API tests — these hit the real Jolpica API.
# Skip on CRAN and in CI if no internet.

skip_if_offline <- function() {
  tryCatch(
    {
      httr::GET("https://api.jolpi.ca/ergast/f1/seasons/?limit=1&format=json",
                httr::timeout(5))
    },
    error = function(e) skip("Jolpica API not reachable")
  )
}

test_that("f1_seasons returns a tibble with expected columns", {
  skip_on_cran()
  skip_if_offline()

  result <- f1_seasons()
  expect_s3_class(result, "tbl_df")
  expect_true("season" %in% names(result))
  expect_true(nrow(result) > 70)
  expect_type(result$season, "integer")
})

test_that("f1_results returns data for a known race", {
  skip_on_cran()
  skip_if_offline()

  result <- f1_results(2024, 1)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) == 20)
  expect_true("driver_given_name" %in% names(result))
  expect_true("position" %in% names(result))
  expect_true("points" %in% names(result))
})

test_that("f1_drivers returns a tibble", {
  skip_on_cran()
  skip_if_offline()

  result <- f1_drivers(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 20)
  expect_true("driver_id" %in% names(result))
})

test_that("f1_races returns schedule data", {
  skip_on_cran()
  skip_if_offline()

  result <- f1_races(2024)
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 20)
  expect_true("race_name" %in% names(result))
})

test_that("f1_circuits returns circuit data", {
  skip_on_cran()
  skip_if_offline()

  result <- f1_circuits(2024)
  expect_s3_class(result, "tbl_df")
  expect_true("circuit_id" %in% names(result))
  expect_true("location_lat" %in% names(result))
})
