# Report installed-and-matching, drifted, or missing, for every member

Classifies every roster member into one of three states –
`"installed_matching"`, `"installed_drifted"`, or `"missing"` – and, for
every missing member, gives the reason it may be missing (its repository
is not yet public, or it is public but not yet on
`max578.r-universe.dev`).

## Usage

``` r
cao_status(verbose = TRUE)
```

## Arguments

- verbose:

  Logical scalar. When `TRUE` (the default), the report is printed to
  the console via its `print` method before being returned. When
  `FALSE`, the report is built and returned silently.

## Value

Invisibly, an object of class `"cao_status"`: a list with elements
`versions` (the
[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md)
data.frame with `status` and `reason` columns added), `freeze_date`
(character scalar), and the counts `n_matching`, `n_drifted`,
`n_missing`. Has a `print` method.

## See also

[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md),
[`cao_check()`](https://max578.github.io/cropOrchestra/reference/cao_check.md)

Other roster:
[`cao_check()`](https://max578.github.io/cropOrchestra/reference/cao_check.md),
[`cao_install()`](https://max578.github.io/cropOrchestra/reference/cao_install.md),
[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md),
[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md)

## Author

Max Moldovan, <max.moldovan@adelaide.edu.au>

## Examples

``` r
if (FALSE) { # interactive()
cao_status()
}
```
