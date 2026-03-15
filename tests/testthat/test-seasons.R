# Unit tests for f1_seasons (live API tests in test-api-live.R)

test_that("f1_seasons includes historic seasons starting from 1950", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_seasons()
  expect_true(min(result$season) == 1950L)
  expect_true(max(result$season) >= 2024L)
})
