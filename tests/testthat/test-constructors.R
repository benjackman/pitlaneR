# Unit tests for f1_constructors (live API tests in test-api-live.R)

test_that("f1_constructors for a season returns fewer results than all", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  all <- f1_constructors()
  Sys.sleep(1)
  season <- f1_constructors(2024)
  expect_true(nrow(season) < nrow(all))
})
