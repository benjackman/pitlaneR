# Unit tests for f1_results (live API tests in test-api-live.R)

test_that("f1_results column ordering has race info first", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_results(2024, 1)
  race_cols <- c("season", "round", "race_name", "race_date")
  expect_equal(names(result)[1:4], race_cols)
})
