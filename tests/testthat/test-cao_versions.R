# test-cao_versions.R -- Structure and logic, independent of what happens
# to be installed in the checking library.

test_that("cao_versions() adds installed_version and match to the roster", {
  versions <- cao_versions()
  expect_s3_class(versions, "data.frame")
  expect_equal(nrow(versions), 15L)
  expect_true(all(c("installed_version", "match") %in% names(versions)))
  expect_type(versions$installed_version, "character")
  expect_type(versions$match, "logical")
})

test_that("match is FALSE wherever installed_version is NA", {
  versions <- cao_versions()
  missing_rows <- is.na(versions$installed_version)
  expect_true(all(!versions$match[missing_rows]))
})

test_that("match is TRUE only where installed equals frozen", {
  versions <- cao_versions()
  installed_rows <- !is.na(versions$installed_version)
  installed_version <- versions$installed_version[installed_rows]
  frozen_version <- versions$version[installed_rows]
  expect_equal(
    versions$match[installed_rows],
    installed_version == frozen_version
  )
})

test_that("cao_versions() never errors when a member is not installed", {
  expect_no_error(cao_versions())
})
