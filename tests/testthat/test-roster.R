# test-roster.R -- Shape and invariants of the frozen roster.

test_that("cao_roster() has exactly the fifteen released members", {
  roster <- cao_roster()
  expect_s3_class(roster, "data.frame")
  expect_equal(nrow(roster), 15L)
  expect_equal(
    length(unique(roster$member)),
    15L,
    label = "member names are unique"
  )
})

test_that("cao_roster() carries the expected columns", {
  roster <- cao_roster()
  expect_named(
    roster,
    c("member", "version", "tier", "role", "visibility", "repo")
  )
})

test_that("tier is one of core or supporting, split nine and six", {
  roster <- cao_roster()
  expect_true(all(roster$tier %in% c("core", "supporting")))
  expect_equal(sum(roster$tier == "core"), 9L)
  expect_equal(sum(roster$tier == "supporting"), 6L)
})

test_that("visibility is one of public or private", {
  roster <- cao_roster()
  expect_true(all(roster$visibility %in% c("public", "private")))
})

test_that("version and role are non-empty character strings for every row", {
  roster <- cao_roster()
  expect_true(all(nzchar(roster$version)))
  expect_true(all(nzchar(roster$role)))
  expect_true(all(nzchar(roster$repo)))
  expect_true(all(!is.na(roster$version)))
})

test_that("repo follows the max578 namespace convention", {
  roster <- cao_roster()
  expect_true(all(startsWith(roster$repo, "max578/")))
  expect_equal(roster$repo, paste0("max578/", roster$member))
})

test_that("the freeze date attribute is present and correct", {
  roster <- cao_roster()
  expect_identical(attr(roster, "freeze_date"), "2026-09-02")
})

test_that("cao_roster() returns a fresh copy each call", {
  first <- cao_roster()
  first$tier[1L] <- "mutated"
  second <- cao_roster()
  expect_false(identical(first$tier, second$tier))
})
