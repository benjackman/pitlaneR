test_that("f1_qualifying() errors for seasons before 1994", {
  expect_error(f1_qualifying(1993), "only available from 1994")
  expect_error(f1_qualifying(1950), "only available from 1994")
  expect_error(f1_qualifying("1990"), "only available from 1994")
})

test_that("f1_qualifying() accepts 1994 and later without guard error", {
  # Should not error on the guard clause itself (may still fail on network)
  expect_no_error(tryCatch(
    f1_qualifying(1994),
    error = function(e) {
      if (grepl("only available from 1994", conditionMessage(e))) stop(e)
    }
  ))
})
