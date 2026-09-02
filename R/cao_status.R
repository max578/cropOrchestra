# cao_status.R -- An honest per-member status report.

#' Report installed-and-matching, drifted, or missing, for every member
#'
#' @description
#' Classifies every roster member into one of three states --
#' `"installed_matching"`, `"installed_drifted"`, or `"missing"` -- and, for
#' every missing member, gives the honest reason it may be missing (its
#' repository is not yet public, or it is public but not yet on
#' `max578.r-universe.dev`).
#'
#' @param verbose Logical scalar. When `TRUE` (the default), the report is
#'   printed to the console via its `print` method before being returned.
#'   When `FALSE`, the report is built and returned silently.
#'
#' @returns Invisibly, an object of class `"cao_status"`: a list with
#'   elements `versions` (the [cao_versions()] data.frame with `status` and
#'   `reason` columns added), `freeze_date` (character scalar), and the
#'   counts `n_matching`, `n_drifted`, `n_missing`. Has a `print` method.
#'
#' @seealso [cao_versions()], [cao_check()]
#' @family roster
#' @author Max Moldovan, \email{max.moldovan@@adelaide.edu.au}
#'
#' @examplesIf interactive()
#' cao_status()
#'
#' @export
cao_status <- function(verbose = TRUE) {
  versions <- cao_versions()
  # ---- Classify each member ------------------------------------------
  status <- ifelse(
    is.na(versions$installed_version),
    "missing",
    ifelse(versions$match, "installed_matching", "installed_drifted")
  )
  reason <- vapply(seq_len(nrow(versions)), function(i1) {
    if (!identical(status[i1], "missing")) {
      return(NA_character_)
    }
    return(.missing_reason(versions$visibility[i1]))
  }, character(1L))
  versions$status <- status
  versions$reason <- reason
  out <- list(
    versions = versions,
    freeze_date = attr(cao_roster(), "freeze_date"),
    n_matching = sum(status == "installed_matching"),
    n_drifted = sum(status == "installed_drifted"),
    n_missing = sum(status == "missing")
  )
  class(out) <- "cao_status"
  if (isTRUE(verbose)) {
    print(out)
  }
  return(invisible(out))
}

#' Print a `cao_status` report
#'
#' @param x An object of class `"cao_status"`, from [cao_status()].
#' @param ... Unused; present for S3 method consistency.
#'
#' @returns Invisibly, `x`.
#'
#' @noRd
#' @export
print.cao_status <- function(x, ...) {
  cat("Crop Analytics Orchestra -- status at freeze", x$freeze_date, "\n")
  cat(sprintf(
    "  %d matching, %d drifted, %d missing (of %d members)\n\n",
    x$n_matching, x$n_drifted, x$n_missing, nrow(x$versions)
  ))
  for (i1 in seq_len(nrow(x$versions))) {
    row <- x$versions[i1, ]
    line <- sprintf(
      "  [%s] %-20s frozen %-10s installed %-10s (%s)",
      toupper(substr(row$status, 1L, 1L)),
      row$member,
      row$version,
      ifelse(is.na(row$installed_version), "-", row$installed_version),
      row$tier
    )
    if (identical(row$status, "missing")) {
      line <- paste0(line, " -- ", row$reason)
    }
    cat(line, "\n")
  }
  return(invisible(x))
}
