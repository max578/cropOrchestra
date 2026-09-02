# cropOrchestra-package.R -- Package-level documentation.
#
# The Crop Analytics Orchestra front door: a roster, a version checker, an
# installer, and a gate runner over the released member packages. Holds no
# analytical code of its own -- every scientific verb lives in a released
# member.

#' cropOrchestra: The Crop Analytics Orchestra
#'
#' @description
#' Purpose-built R packages that analyse a grain-production question end to
#' end -- typed manifests, typed refusals, provenance -- with an installer
#' and status checker for the released roster.
#'
#' @details
#' `cropOrchestra` is a thin front door, not an analytical package: it does
#' not ship models, and it does not fail when a released member is not
#' installed. Its four verbs are [cao_roster()] (what is in the release),
#' [cao_versions()] (what is installed against what was frozen),
#' [cao_status()] (a plain report, including why a member may be missing),
#' and [cao_install()] (fetch what is available). [cao_check()] runs the
#' fleet's gate scripts when a leader workspace is supplied, and otherwise
#' falls back to a status-plus-load-check.
#'
#' @keywords internal
"_PACKAGE"
