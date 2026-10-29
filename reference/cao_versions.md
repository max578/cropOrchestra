# Join the frozen roster with installed versions

Returns the roster from
[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md)
with two columns added: `installed_version`, the version actually
loadable in this R session (`NA` where the package is not installed),
and `match`, whether the installed version equals the frozen version.

## Usage

``` r
cao_versions()
```

## Value

A data.frame: the 15-row roster from
[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md)
plus `installed_version` (character, `NA` where not installed) and
`match` (logical, `TRUE` only where the installed version string equals
the frozen version string).

## Details

Every member's installed version is looked up through
[`requireNamespace()`](https://rdrr.io/r/base/ns-load.html), never
through a hard [`library()`](https://rdrr.io/r/base/library.html) call,
so a member that is not installed – expected for any of the eight
members whose repository is still private at the freeze date – is
reported as `NA` rather than raising an error.

## See also

[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md),
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md)

Other roster:
[`cao_check()`](https://max578.github.io/cropOrchestra/reference/cao_check.md),
[`cao_install()`](https://max578.github.io/cropOrchestra/reference/cao_install.md),
[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md),
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md)

## Author

Max Moldovan, <max.moldovan@adelaide.edu.au>

## Examples

``` r
if (FALSE) { # interactive()
cao_versions()
}
```
