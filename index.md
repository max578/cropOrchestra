# cropOrchestra

The Crop Analytics Orchestra front door – a roster, a version checker,
an installer, and a gate runner over the fifteen `max578` R packages of
the 2026-09-02 release roster that take a grain-production question from
data to a recorded decision. `cropOrchestra` ships no models of its own;
every scientific verb lives in a released member.

## Related packages

- [tidyverse](https://CRAN.R-project.org/package=tidyverse) installs and
  loads the core tidyverse packages in a single step.
- [tidymodels](https://CRAN.R-project.org/package=tidymodels) does the
  same for the tidymodels collection of modelling packages.
- [easystats](https://CRAN.R-project.org/package=easystats) is a
  meta-package that installs and loads the easystats packages for
  statistical modelling, visualisation and reporting.

These meta-packages depend on their members, so installing one installs
the whole collection. cropOrchestra depends on none of its members and
attaches none of them. It lists the release roster, compares the
installed versions with the frozen release, installs the members you
choose, and reports each one that is missing or fails instead of
stopping.

## Installation

Install `cropOrchestra` from GitHub:

``` r

remotes::install_github("max578/cropOrchestra")
```

`cropOrchestra` itself imports only `tools` and `utils`. The roster
members are optional and are not installed with it.

[`cao_install()`](https://max578.github.io/cropOrchestra/reference/cao_install.md)
installs members with
[`install.packages()`](https://rdrr.io/r/utils/install.packages.html)
from `https://max578.r-universe.dev` and CRAN. That repository currently
serves seven members:

| Package     | Installed from        |
|-------------|-----------------------|
| `masque`    | max578.r-universe.dev |
| `PESTO`     | max578.r-universe.dev |
| `kernR`     | max578.r-universe.dev |
| `proxymix`  | max578.r-universe.dev |
| `gpfield`   | max578.r-universe.dev |
| `decideR`   | max578.r-universe.dev |
| `grainPlan` | max578.r-universe.dev |

The other eight roster members (`flexyBayes`, `apsimR`, `quorum`,
`terroir`, `kalmix`, `koine`, `optimix`, `cdzoo`) are not on r-universe
or CRAN yet.
[`cao_install()`](https://max578.github.io/cropOrchestra/reference/cao_install.md)
reports each of them as failed or unavailable and carries on with the
rest;
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md)
says which are missing.

## Usage

``` r

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

See
[`vignette("crop_analytics_orchestra")`](https://max578.github.io/cropOrchestra/articles/crop_analytics_orchestra.md)
for the release story: what the orchestra is, the necessity principle
behind the roster, and the headline result from Study A0 (a controlled
synthetic-belt exercise, labelled as such throughout).

## Licence

MIT (c) Max Moldovan.
