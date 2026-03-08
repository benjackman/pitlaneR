test_that("to_snake_case converts correctly", {
  expect_equal(to_snake_case("driverId"), "driver_id")
  expect_equal(to_snake_case("givenName"), "given_name")
  expect_equal(to_snake_case("circuitName"), "circuit_name")
  expect_equal(to_snake_case("dateOfBirth"), "date_of_birth")
  expect_equal(to_snake_case("already_snake"), "already_snake")
  expect_equal(to_snake_case("URL"), "url")
})

test_that("safe_numeric handles various inputs", {
  expect_equal(safe_numeric("42"), 42)
  expect_equal(safe_numeric("3.14"), 3.14)
  expect_true(is.na(safe_numeric("not_a_number")))
  expect_true(is.na(safe_numeric(NA)))
})

test_that("safe_date parses dates correctly", {
  expect_equal(safe_date("2024-03-02"), as.Date("2024-03-02"))
  expect_true(is.na(safe_date(NA)))
})

test_that("resolve_season defaults to current year", {
  expect_equal(resolve_season(NULL), as.character(as.integer(format(Sys.Date(), "%Y"))))
  expect_equal(resolve_season(2024), "2024")
  expect_equal(resolve_season("2023"), "2023")
})

test_that("flatten_and_rename handles empty data frames", {
  expect_equal(nrow(flatten_and_rename(tibble::tibble())), 0)
})
