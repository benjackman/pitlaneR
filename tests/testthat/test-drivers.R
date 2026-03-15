# Unit tests for f1_drivers (live API tests in test-api-live.R)

test_that("f1_drivers without season returns all drivers", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_drivers()
  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) > 100)
  expect_true("driver_id" %in% names(result))
})

Sys.sleep(1)

test_that("f1_drivers returns expected column types", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_drivers(2024)
  expect_type(result$driver_id, "character")
  expect_type(result$given_name, "character")
  expect_type(result$family_name, "character")
  expect_s3_class(result$date_of_birth, "Date")
})
