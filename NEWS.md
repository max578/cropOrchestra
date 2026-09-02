# cropOrchestra (development version)

* Roster entry renamed: `flexyBayesOrchestra` is now `quorum` (`quorum_dev/quorum`,
  `max578/quorum`), following the 2026-09-02 upstream rename and
  re-dedication as the consensus layer. `cao_roster()`, the DESCRIPTION
  `Suggests` list, and the vignette roster table are updated to match.
* The vignette is brought to the orchestra vignette quality bar v1: one
  question stated in a new user's words, the Why/What/Do/Read/Limits/What
  to read next/Reproduce shape, a colourblind-safe tiered figure of roster
  status on the rendering machine, and every number computed live rather
  than typed by hand. `ggplot2` added to `Suggests` for the figure.

# cropOrchestra 0.1.0

## New features

* Initial release: the Crop Analytics Orchestra front door.
* `cao_roster()` returns the fifteen-member release roster (nine core, six
  supporting) frozen 2026-09-02, with each member's tier, necessity-register
  role, `max578` repository, and visibility.
* `cao_versions()` joins the roster with what is actually installed in the
  current R session, `NA` where a member is not installed.
* `cao_status()` classifies every member as installed-and-matching,
  installed-but-drifted, or missing, and for a missing member gives the
  honest reason (private repository not yet public, or not yet mirrored on
  r-universe).
* `cao_install()` installs the requested tier or an explicit set of package
  names from the `max578` r-universe mirror and CRAN, one member at a time,
  so one unavailable member never stops the rest; `dry_run = TRUE` returns
  the plan without installing anything.
* `cao_check()` runs the fleet's own gate scripts (the refusal contract and
  the manifest conformance suite) against a supplied ORCHESTRA leader
  workspace, or falls back to `cao_status()` plus a load-check of every
  installed member.
