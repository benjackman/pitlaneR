test_that("f1_clear_cache runs without error", {
  expect_invisible(f1_clear_cache())
})

test_that("f1_clear_cache returns NULL invisibly", {
  result <- f1_clear_cache()
  expect_null(result)
})

test_that("f1_clear_cache prints success message", {
  expect_message(f1_clear_cache(), "cache cleared")
})
