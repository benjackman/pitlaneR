# Unit tests for f1_circuits (live API tests in test-api-live.R)

test_that("f1_circuits returns expected column types", {
  skip_if_api_unavailable()
  Sys.sleep(1)

  result <- f1_circuits(2024)
  expect_type(result$circuit_id, "character")
  expect_type(result$circuit_name, "character")
  expect_type(result$location_lat, "double")
  expect_type(result$location_long, "double")
  expect_type(result$location_locality, "character")
  expect_type(result$location_country, "character")
})
