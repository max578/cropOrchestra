# Install roster members from the r-universe and CRAN repositories

Installs the requested roster members, one at a time, so that one
unavailable or still-private member never stops the rest of the install.
Every outcome – already installed, freshly installed, failed, or
unavailable – is reported per member; the function itself never raises
an error for a member it could not install.

## Usage

``` r
cao_install(
  members = "all",
  repos = c(runiverse = "https://max578.r-universe.dev", CRAN =
    "https://cloud.r-project.org"),
  dry_run = FALSE
)
```

## Arguments

- members:

  Either a length-one character scalar naming a tier (`"core"`,
  `"supporting"`, or `"all"`, the default), or an explicit character
  vector of package names (need not be limited to the roster –
  `"orchestraManifest"` is a legitimate extra name).

- repos:

  A named character vector of repository URLs passed to
  [`utils::install.packages()`](https://rdrr.io/r/utils/install.packages.html).
  Defaults to the `max578` r-universe mirror followed by CRAN, so a
  package available on either resolves.

- dry_run:

  Logical scalar. When `TRUE`, no installation is attempted and the
  resolved install plan is returned instead.

## Value

When `dry_run = TRUE`, a data.frame with columns `member` and `repos`
(the plan, not yet executed). Otherwise, invisibly, a data.frame with
columns `member`, `repos`, and `result` (one of `"already_installed"`,
`"installed"`, `"failed"`, `"unavailable"`).

## See also

[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md),
[`cao_check()`](https://max578.github.io/cropOrchestra/reference/cao_check.md)

Other roster:
[`cao_check()`](https://max578.github.io/cropOrchestra/reference/cao_check.md),
[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md),
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md),
[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md)

## Author

Max Moldovan, <max.moldovan@adelaide.edu.au>

## Examples

``` r
if (FALSE) { # interactive()
cao_install(members = "core", dry_run = TRUE)
}
```
