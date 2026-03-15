# Unit tests for f1_sprint (live API tests in test-api-live.R)

test_that("f1_sprint returns empty tibble for non-sprint round", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_sprint(2024, 1)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0)
})
