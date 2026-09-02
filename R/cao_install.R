# cao_install.R -- Install what is available; report the rest honestly.

#' Install roster members from the r-universe and CRAN repositories
#'
#' @description
#' Installs the requested roster members, one at a time, so that one
#' unavailable or still-private member never stops the rest of the install.
#' Every outcome -- already installed, freshly installed, failed, or
#' unavailable -- is reported per member; the function itself never raises
#' an error for a member it could not install.
#'
#' @param members Either a length-one character scalar naming a tier
#'   (`"core"`, `"supporting"`, or `"all"`, the default), or an explicit
#'   character vector of package names (need not be limited to the roster --
#'   `"orchestraManifest"` is a legitimate extra name).
#' @param repos A named character vector of repository URLs passed to
#'   [utils::install.packages()]. Defaults to the `max578` r-universe
#'   mirror followed by CRAN, so a package available on either resolves.
#' @param dry_run Logical scalar. When `TRUE`, no installation is attempted
#'   and the resolved install plan is returned instead.
#'
#' @returns When `dry_run = TRUE`, a data.frame with columns `member` and
#'   `repos` (the plan, not yet executed). Otherwise, invisibly, a
#'   data.frame with columns `member`, `repos`, and `result` (one of
#'   `"already_installed"`, `"installed"`, `"failed"`, `"unavailable"`).
#'
#' @seealso [cao_roster()], [cao_check()]
#' @family roster
#' @author Max Moldovan, \email{max.moldovan@@adelaide.edu.au}
#'
#' @examplesIf interactive()
#' cao_install(members = "core", dry_run = TRUE)
#'
#' @export
cao_install <- function(members = "all",
                         repos = c(
                           runiverse = "https://max578.r-universe.dev",
                           CRAN = "https://cloud.r-project.org"
                         ),
                         dry_run = FALSE) {
  resolved <- .resolve_members(members)
  plan <- data.frame(
    member = resolved,
    repos = paste(repos, collapse = ", "),
    stringsAsFactors = FALSE
  )
  if (isTRUE(dry_run)) {
    return(plan)
  }
  # ---- Install each member, never erroring as a whole --------------------
  result <- vapply(
    resolved,
    .install_one,
    character(1L),
    repos = repos
  )
  plan$result <- unname(result)
  return(invisible(plan))
}
