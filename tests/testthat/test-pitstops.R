# Unit tests for f1_pit_stops (live API tests in test-api-live.R)

test_that("f1_pit_stops requires season and round arguments", {
  expect_error(f1_pit_stops())
})

test_that("f1_pit_stops returns empty tibble for pre-2012 season", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_pit_stops(2010, 1)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0)
})

Sys.sleep(1)

test_that("f1_pit_stops column ordering has race info first", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_pit_stops(2024, 1)
  expect_equal(names(result)[1:3], c("season", "round", "race_name"))
})
