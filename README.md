# cropOrchestra

The Crop Analytics Orchestra front door -- a roster, a version checker, an
installer, and a gate runner over the fifteen `max578` R packages of the
2026-09-02 release roster that take a grain-production question from data to
a recorded decision.
`cropOrchestra` ships no models of its own; every scientific verb lives in a
released member.

## Installation

Install `cropOrchestra` from GitHub:

```r
remotes::install_github("max578/cropOrchestra")
```

`cropOrchestra` itself imports only `tools` and `utils`. The roster members
are optional and are not installed with it.

`cao_install()` installs members with `install.packages()` from
`https://max578.r-universe.dev` and CRAN. That repository currently serves
seven members:

| Package | Installed from |
|---|---|
| `masque` | max578.r-universe.dev |
| `PESTO` | max578.r-universe.dev |
| `kernR` | max578.r-universe.dev |
| `proxymix` | max578.r-universe.dev |
| `gpfield` | max578.r-universe.dev |
| `decideR` | max578.r-universe.dev |
| `grainPlan` | max578.r-universe.dev |

The other eight roster members (`flexyBayes`, `apsimR`, `quorum`, `terroir`,
`kalmix`, `koine`, `optimix`, `cdzoo`) are not on r-universe or CRAN yet.
`cao_install()` reports each of them as failed or unavailable and carries on
with the rest; `cao_status()` says which are missing.

## Usage

```r
library(cropOrchestra)

# What is in the release: nine core members, six supporting.
cao_roster()

# What is actually installed against what was frozen.
cao_versions()

# A plain report: matching, drifted, or missing, and why.
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
