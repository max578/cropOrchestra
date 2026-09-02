# internal_functions.R -- Shared, un-exported helpers for the four verbs.
#
# Every Suggests access in this package is guarded by requireNamespace() and
# funnelled through the helpers below, so a missing or not-yet-public member
# never raises an error -- it is reported, plainly, as missing.

#' Look up a member's installed version, or NA
#'
#' @param member Character scalar, a package name from the roster.
#'
#' @returns A character scalar: the installed version string, or
#'   `NA_character_` when the package is not installed.
#'
#' @noRd
#' @keywords internal
.installed_version <- function(member) {
  if (!requireNamespace(member, quietly = TRUE)) {
    return(NA_character_)
  }
  return(as.character(utils::packageVersion(member)))
}

#' Explain why a roster member may be missing from the library
#'
#' @param visibility Character scalar, `"public"` or `"private"`, from the
#'   roster's `visibility` column.
#'
#' @returns A character scalar, a short stated reason.
#'
#' @noRd
#' @keywords internal
.missing_reason <- function(visibility) {
  if (identical(visibility, "private")) {
    return("private repo, not yet public")
  }
  return("public repo, not yet on r-universe (or not yet installed)")
}

#' Resolve a `members` argument to an explicit character vector
#'
#' @param members Either a length-one character scalar naming a tier
#'   (`"core"`, `"supporting"`, `"all"`) or an explicit character vector of
#'   package names.
#'
#' @returns A character vector of package names.
#'
#' @noRd
#' @keywords internal
.resolve_members <- function(members) {
  .check_members_arg(members)
  roster <- cao_roster()
  if (length(members) == 1L && members %in% c("core", "supporting", "all")) {
    if (identical(members, "all")) {
      return(roster$member)
    }
    return(roster$member[roster$tier == members])
  }
  return(as.character(members))
}

#' Validate the `members` argument shape
#'
#' @param members The argument as passed to [cao_install()].
#'
#' @returns Invisible `NULL`; called for its side effect of raising an
#'   error on a malformed argument.
#'
#' @noRd
#' @keywords internal
.check_members_arg <- function(members) {
  if (!is.character(members) || length(members) < 1L) {
    stop(call. = FALSE, "`members` must be a non-empty character vector.")
  }
  return(invisible(NULL))
}

#' Install one package, catching any failure as a reported status
#'
#' @param member Character scalar, the package name to install.
#' @param repos Named character vector of repository URLs, passed to
#'   [utils::install.packages()].
#'
#' @returns A character scalar: `"already_installed"`, `"installed"`,
#'   `"failed"`, or `"unavailable"` (installed without error but still not
#'   loadable afterwards).
#'
#' @noRd
#' @keywords internal
.install_one <- function(member, repos) {
  if (requireNamespace(member, quietly = TRUE)) {
    return("already_installed")
  }
  install_ok <- tryCatch(
    {
      utils::install.packages(member, repos = repos, quiet = TRUE)
      TRUE
    },
    error = function(e) FALSE,
    warning = function(w) FALSE
  )
  if (!isTRUE(install_ok)) {
    return("failed")
  }
  if (requireNamespace(member, quietly = TRUE)) {
    return("installed")
  }
  return("unavailable")
}

#' Run one fleet gate script and classify its exit status
#'
#' @param script_path Character scalar, an absolute or relative path to an
#'   `.R` gate script.
#'
#' @returns A list with elements `status` (one of `"pass"`, `"fail"`,
#'   `"not_found"`, `"invalid_script"`, `"error"`) and `exit_code` (integer
#'   or `NA_integer_`).
#'
#' @noRd
#' @keywords internal
.run_gate_script <- function(script_path) {
  if (!file.exists(script_path)) {
    return(list(status = "not_found", exit_code = NA_integer_))
  }
  if (!identical(tools::file_ext(script_path), "R")) {
    return(list(status = "invalid_script", exit_code = NA_integer_))
  }
  rscript_bin <- file.path(R.home("bin"), "Rscript")
  exit_code <- tryCatch(
    system2(
      rscript_bin,
      args = shQuote(script_path),
      stdout = FALSE,
      stderr = FALSE
    ),
    error = function(e) NA_integer_
  )
  if (is.na(exit_code)) {
    return(list(status = "error", exit_code = NA_integer_))
  }
  status <- if (exit_code == 0L) "pass" else "fail"
  return(list(status = status, exit_code = exit_code))
}
