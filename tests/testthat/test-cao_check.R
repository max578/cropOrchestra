# test-cao_check.R -- Both branches (workspace and fallback), guarded so
# neither depends on external state beyond files already on this machine.

test_that("cao_check() with no workspace falls back to a status report", {
  check <- cao_check()
  expect_s3_class(check, "cao_check")
  expect_identical(check$mode, "fallback")
  expect_s3_class(check$status, "cao_status")
  expect_true(check$n_loadable + check$n_load_failed <= nrow(cao_roster()))
})

test_that("cao_check() falls back when the workspace path does not exist", {
  check <- cao_check(workspace = tempfile("does-not-exist-"))
  expect_identical(check$mode, "fallback")
})

test_that("cao_check() runs workspace mode when the directory exists", {
  workspace <- tempfile("cao-check-workspace-")
  dir.create(file.path(workspace, "integration"), recursive = TRUE)
  check <- cao_check(workspace = workspace)
  expect_identical(check$mode, "workspace")
  expect_identical(check$workspace, workspace)
  expect_equal(nrow(check$gates), 2L)
  expect_true(all(check$gates$status == "not_found"))
  unlink(workspace, recursive = TRUE)
})

test_that("print.cao_check() prints and returns its argument invisibly", {
  check <- cao_check()
  expect_invisible(print(check))
  expect_output(print(check), "Crop Analytics Orchestra")
})

test_that(".run_gate_script() reports not_found for a missing script", {
  result <- .run_gate_script(tempfile("no-such-script-", fileext = ".R"))
  expect_identical(result$status, "not_found")
})

test_that(".run_gate_script() reports invalid_script for a non-R file", {
  bad_script <- tempfile("gate-", fileext = ".sh")
  writeLines("echo hi", bad_script)
  result <- .run_gate_script(bad_script)
  expect_identical(result$status, "invalid_script")
  unlink(bad_script)
})
