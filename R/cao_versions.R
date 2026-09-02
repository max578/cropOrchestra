# cao_versions.R -- The roster joined with what is actually installed.

#' Join the frozen roster with installed versions
#'
#' @description
#' Returns the roster from [cao_roster()] with two columns added:
#' `installed_version`, the version actually loadable in this R session
#' (`NA` where the package is not installed), and `match`, whether the
#' installed version equals the frozen version.
#'
#' @details
#' Every member's installed version is looked up through
#' [requireNamespace()], never through a hard `library()` call, so a member
#' that is not installed -- expected for any of the eight members whose
#' repository is still private at the freeze date -- is reported as `NA`
#' rather than raising an error.
#'
#' @returns A data.frame: the 15-row roster from [cao_roster()] plus
#'   `installed_version` (character, `NA` where not installed) and `match`
#'   (logical, `TRUE` only where the installed version string equals the
#'   frozen version string).
#'
#' @seealso [cao_roster()], [cao_status()]
#' @family roster
#' @author Max Moldovan, \email{max.moldovan@@adelaide.edu.au}
#'
#' @examplesIf interactive()
#' cao_versions()
#'
#' @export
cao_versions <- function() {
  roster <- cao_roster()
  installed_version <- vapply(roster$member, .installed_version, character(1L))
  roster$installed_version <- unname(installed_version)
  roster$match <- !is.na(roster$installed_version) &
    roster$installed_version == roster$version
  return(roster)
}
