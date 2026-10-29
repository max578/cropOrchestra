# The frozen Crop Analytics Orchestra roster

Returns the fifteen members released at the 2026-09-02 freeze: nine core
and six supporting, each carrying its necessity-register role, the
`max578` repository it publishes (or will publish) through, and whether
that repository is public yet.

## Usage

``` r
cao_roster()
```

## Value

A data.frame of 15 rows with columns `member` (character), `version`
(character, the frozen version string), `tier` (character, one of
`"core"` or `"supporting"`), `role` (character, a one-line
necessity-register description), `visibility` (character, one of
`"public"` or `"private"` at the freeze date), and `repo` (character,
the `max578` namespace path). The freeze date is carried as the
`"freeze_date"` attribute on the returned object.

## Details

The roster is fixed data, not a live query – it answers "what did the
release ratify", not "what is installed right now" (that is
[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md)).
A member's absence from this data.frame means it is not in the v1.0
release; the necessity register at `release/necessity_register.md` in
the ORCHESTRA leader workspace records why each row is here and what was
held for v1.1.

## See also

[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md),
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md)

Other roster:
[`cao_check()`](https://max578.github.io/cropOrchestra/reference/cao_check.md),
[`cao_install()`](https://max578.github.io/cropOrchestra/reference/cao_install.md),
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md),
[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md)

## Author

Max Moldovan, <max.moldovan@adelaide.edu.au>

## Examples

``` r
if (FALSE) { # interactive()
cao_roster()
}
```
