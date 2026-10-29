# Check the release against the fleet's gate scripts, or fall back

When `workspace` names an existing ORCHESTRA leader workspace, runs its
two fleet gate scripts (`integration/test_refusal_contract.R` and
`integration/test_manifest_conformance.R`) and reports pass or fail for
each. When `workspace` is not supplied, or does not exist, falls back to
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md)
plus a load-check
([`requireNamespace()`](https://rdrr.io/r/base/ns-load.html)) of every
member that is installed.

## Usage

``` r
cao_check(workspace = NULL)
```

## Arguments

- workspace:

  `NULL` (the default), or a character scalar path to the ORCHESTRA
  leader workspace whose `integration/` directory holds the gate
  scripts.

## Value

An object of class `"cao_check"`. In workspace mode, a list with
elements `mode = "workspace"`, `workspace`, and `gates` (a data.frame
with columns `gate`, `script`, `exists`, `status`, `exit_code`). In
fallback mode, a list with elements `mode = "fallback"`, `status` (the
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md)
object, with a `loadable` column added to its `versions` data.frame),
`n_loadable`, and `n_load_failed`. Has a `print` method.

## See also

[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md)

Other roster:
[`cao_install()`](https://max578.github.io/cropOrchestra/reference/cao_install.md),
[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md),
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md),
[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md)

## Author

Max Moldovan, <max.moldovan@adelaide.edu.au>

## Examples

``` r
if (FALSE) { # interactive()
cao_check()
cao_check(workspace = "/path/to/ORCHESTRA_dev")
}
```
