# cao_check.R -- Run the fleet's own gates, or fall back to a status check.

#' Check the release against the fleet's gate scripts, or fall back
#'
#' @description
#' When `workspace` names an existing ORCHESTRA leader workspace, runs its
#' two fleet gate scripts (`integration/test_refusal_contract.R` and
#' `integration/test_manifest_conformance.R`) and reports pass or fail for
#' each. When `workspace` is not supplied, or does not exist, falls back to
#' [cao_status()] plus a load-check ([requireNamespace()]) of every member
#' that is installed.
#'
#' @param workspace `NULL` (the default), or a character scalar path to the
#'   ORCHESTRA leader workspace whose `integration/` directory holds the
#'   gate scripts.
#'
#' @returns An object of class `"cao_check"`. In workspace mode, a list with
#'   elements `mode = "workspace"`, `workspace`, and `gates` (a data.frame
#'   with columns `gate`, `script`, `exists`, `status`, `exit_code`). In
#'   fallback mode, a list with elements `mode = "fallback"`, `status` (the
#'   [cao_status()] object, with a `loadable` column added to its
#'   `versions` data.frame), `n_loadable`, and `n_load_failed`. Has a
#'   `print` method.
#'
#' @seealso [cao_status()]
#' @family roster
#' @author Max Moldovan, \email{max.moldovan@@adelaide.edu.au}
#'
#' @examplesIf interactive()
#' cao_check()
#' cao_check(workspace = "/path/to/ORCHESTRA_dev")
#'
#' @export
cao_check <- function(workspace = NULL) {
  if (!is.null(workspace) && dir.exists(workspace)) {
    return(.cao_check_workspace(workspace))
  }
  return(.cao_check_fallback())
}

#' Run the two fleet gate scripts in a leader workspace
#'
#' @param workspace Character scalar, an existing directory path.
#'
#' @returns An object of class `"cao_check"` in workspace mode.
#'
#' @noRd
#' @keywords internal
.cao_check_workspace <- function(workspace) {
  gate_refusal <- file.path(workspace, "integration", "test_refusal_contract.R")
  gate_manifest <- file.path(
    workspace, "integration", "test_manifest_conformance.R"
  )
  refusal_result <- .run_gate_script(gate_refusal)
  manifest_result <- .run_gate_script(gate_manifest)
  gates <- data.frame(
    gate = c("refusal_contract", "manifest_conformance"),
    script = c(gate_refusal, gate_manifest),
    exists = c(file.exists(gate_refusal), file.exists(gate_manifest)),
    status = c(refusal_result$status, manifest_result$status),
    exit_code = c(refusal_result$exit_code, manifest_result$exit_code),
    stringsAsFactors = FALSE
  )
  out <- list(mode = "workspace", workspace = workspace, gates = gates)
  class(out) <- "cao_check"
  return(out)
}

#' Fall back to a status report plus a load-check of installed members
#'
#' @returns An object of class `"cao_check"` in fallback mode.
#'
#' @noRd
#' @keywords internal
.cao_check_fallback <- function() {
  status <- cao_status(verbose = FALSE)
  loadable <- vapply(status$versions$member, function(member) {
    if (is.na(.installed_version(member))) {
      return(NA)
    }
    return(requireNamespace(member, quietly = TRUE))
  }, logical(1L))
  status$versions$loadable <- unname(loadable)
  out <- list(
    mode = "fallback",
    status = status,
    n_loadable = sum(loadable, na.rm = TRUE),
    n_load_failed = sum(!loadable, na.rm = TRUE)
  )
  class(out) <- "cao_check"
  return(out)
}

#' Print a `cao_check` report
#'
#' @param x An object of class `"cao_check"`, from [cao_check()].
#' @param ... Unused; present for S3 method consistency.
#'
#' @returns Invisibly, `x`.
#'
#' @noRd
#' @export
print.cao_check <- function(x, ...) {
  if (identical(x$mode, "workspace")) {
    cat("Crop Analytics Orchestra -- fleet gate check\n")
    cat("  workspace:", x$workspace, "\n\n")
    for (i1 in seq_len(nrow(x$gates))) {
      row <- x$gates[i1, ]
      cat(sprintf(
        "  [%s] %s (%s)\n", toupper(row$status), row$gate, row$script
      ))
    }
    return(invisible(x))
  }
  cat("Crop Analytics Orchestra -- fallback check (no workspace supplied)\n")
  cat(sprintf(
    "  %d loadable, %d failed to load (of the installed members)\n\n",
    x$n_loadable, x$n_load_failed
  ))
  print(x$status)
  return(invisible(x))
}
