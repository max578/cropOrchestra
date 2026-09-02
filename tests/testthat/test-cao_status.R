# test-cao_status.R -- Structure of the report and its print method; the
# underlying install state is whatever this library happens to hold, so
# these tests assert shape and invariants, not specific members.

test_that("cao_status(verbose = FALSE) returns a classed report silently", {
  expect_silent(status <- cao_status(verbose = FALSE))
  expect_s3_class(status, "cao_status")
  expect_named(
    status,
    c("versions", "freeze_date", "n_matching", "n_drifted", "n_missing")
  )
})

test_that("status counts sum to the roster size", {
  status <- cao_status(verbose = FALSE)
  expect_equal(
    status$n_matching + status$n_drifted + status$n_missing,
    nrow(status$versions)
  )
})

test_that("status is one of the three defined states for every row", {
  status <- cao_status(verbose = FALSE)
  expect_true(
    all(status$versions$status %in%
      c("installed_matching", "installed_drifted", "missing"))
  )
})

test_that("a reason is given for every missing member and no other", {
  status <- cao_status(verbose = FALSE)
  missing_rows <- status$versions$status == "missing"
  expect_true(all(!is.na(status$versions$reason[missing_rows])))
  expect_true(all(is.na(status$versions$reason[!missing_rows])))
})

test_that(".missing_reason() names visibility honestly", {
  expect_identical(.missing_reason("private"), "private repo, not yet public")
  expect_true(grepl("public repo", .missing_reason("public"), fixed = TRUE))
})

test_that("print.cao_status() prints and returns its argument invisibly", {
  status <- cao_status(verbose = FALSE)
  expect_invisible(print(status))
  expect_output(print(status), "Crop Analytics Orchestra")
})

test_that("cao_status(verbose = TRUE) prints to the console", {
  expect_output(cao_status(verbose = TRUE), "Crop Analytics Orchestra")
})
