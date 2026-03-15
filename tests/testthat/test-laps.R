# Unit tests for f1_laps (live API tests in test-api-live.R)

test_that("f1_laps requires season and round arguments", {
  expect_error(f1_laps())
})

test_that("f1_laps returns empty tibble for pre-1996 season", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_laps(1990, 1)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0)
})

Sys.sleep(1)

test_that("f1_laps column ordering has race/lap info first", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_laps(2024, 1, lap = 1)
  expect_equal(names(result)[1:4], c("season", "round", "race_name", "lap"))
})
