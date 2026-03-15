# Unit tests for standings functions (live API tests in test-api-live.R)

test_that("f1_constructor_standings errors for seasons before 1958", {
  expect_error(f1_constructor_standings(1957), "only available from 1958")
  expect_error(f1_constructor_standings(1950), "only available from 1958")
  expect_error(f1_constructor_standings("1955"), "only available from 1958")
})

test_that("f1_constructor_standings accepts 1958 without guard error", {
  expect_no_error(tryCatch(
    f1_constructor_standings(1958),
    error = function(e) {
      if (grepl("only available from 1958", conditionMessage(e))) stop(e)
    }
  ))
})

test_that("f1_driver_standings column ordering has season and round first", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_driver_standings(2024)
  expect_equal(names(result)[1:2], c("season", "standings_round"))
})

Sys.sleep(1)

test_that("f1_constructor_standings column ordering has season and round first", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_constructor_standings(2024)
  expect_equal(names(result)[1:2], c("season", "standings_round"))
})
