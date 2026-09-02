# test-cao_install.R -- The dry_run plan is a pure function of `members`;
# no installation is attempted anywhere in this file.

test_that("dry_run with members = \"all\" plans all 15 members", {
  plan <- cao_install(members = "all", dry_run = TRUE)
  expect_s3_class(plan, "data.frame")
  expect_equal(nrow(plan), 15L)
  expect_setequal(plan$member, cao_roster()$member)
})

test_that("dry_run with members = \"core\" plans only the nine core members", {
  plan <- cao_install(members = "core", dry_run = TRUE)
  expect_equal(nrow(plan), 9L)
  expect_setequal(plan$member, cao_roster()$member[cao_roster()$tier == "core"])
})

test_that("dry_run with members = \"supporting\" plans the six supporting", {
  plan <- cao_install(members = "supporting", dry_run = TRUE)
  expect_equal(nrow(plan), 6L)
  expect_setequal(
    plan$member,
    cao_roster()$member[cao_roster()$tier == "supporting"]
  )
})

test_that("dry_run with an explicit character vector plans exactly that", {
  plan <- cao_install(members = c("PESTO", "kernR"), dry_run = TRUE)
  expect_equal(nrow(plan), 2L)
  expect_setequal(plan$member, c("PESTO", "kernR"))
})

test_that("dry_run accepts a name outside the roster (orchestraManifest)", {
  plan <- cao_install(members = "orchestraManifest", dry_run = TRUE)
  expect_equal(plan$member, "orchestraManifest")
})

test_that("the default repos are the max578 r-universe mirror then CRAN", {
  plan <- cao_install(members = "PESTO", dry_run = TRUE)
  expect_true(grepl("max578.r-universe.dev", plan$repos, fixed = TRUE))
  expect_true(grepl("cloud.r-project.org", plan$repos, fixed = TRUE))
})

test_that("members must be a non-empty character vector", {
  expect_error(cao_install(members = character(0L), dry_run = TRUE))
  expect_error(cao_install(members = 1L, dry_run = TRUE))
})
