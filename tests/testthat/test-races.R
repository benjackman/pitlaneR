# Unit tests for f1_races (live API tests in test-api-live.R)

test_that("f1_races defaults to current season", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_races()
  current_year <- as.integer(format(Sys.Date(), "%Y"))
  expect_true(all(result$season == current_year))
})

Sys.sleep(1)

test_that("f1_races returns expected column types", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_races(2024)
  expect_type(result$season, "integer")
  expect_type(result$round, "integer")
  expect_type(result$race_name, "character")
  expect_s3_class(result$date, "Date")
})
