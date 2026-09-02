# cropOrchestra

The Crop Analytics Orchestra front door -- a roster, a version checker, an
installer, and a gate runner over the fifteen released `max578` R packages
that take a grain-production question from data to a recorded decision.
`cropOrchestra` ships no models of its own; every scientific verb lives in a
released member.

## Installation

```r
install.packages(
  "cropOrchestra",
  repos = c("https://max578.r-universe.dev", "https://cloud.r-project.org")
)
```

## Usage

```r
library(cropOrchestra)

# What is in the release: nine core members, six supporting.
cao_roster()

# What is actually installed against what was frozen.
cao_versions()

# An honest report: matching, drifted, or missing, and why.
cao_status()

# Install what is available; report the rest, never erroring as a whole.
cao_install(members = "core", dry_run = TRUE)
cao_install(members = "core")

# Run the fleet's own gate scripts against a leader workspace, or fall
# back to a status-plus-load-check.
cao_check(workspace = "/path/to/ORCHESTRA_dev")
cao_check()
```

See `vignette("crop_analytics_orchestra")` for the release story: what the
orchestra is, the necessity principle behind the roster, and the headline
result from Study A0 (a controlled synthetic-belt exercise, labelled as such
throughout).

## Licence

MIT (c) Max Moldovan.
