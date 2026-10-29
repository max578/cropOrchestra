# cropOrchestra: The Crop Analytics Orchestra

Purpose-built R packages that analyse a grain-production question end to
end – typed manifests, typed refusals, provenance – with an installer
and status checker for the released roster.

## Details

`cropOrchestra` is a thin front door, not an analytical package: it does
not ship models, and it does not fail when a released member is not
installed. Its four verbs are
[`cao_roster()`](https://max578.github.io/cropOrchestra/reference/cao_roster.md)
(what is in the release),
[`cao_versions()`](https://max578.github.io/cropOrchestra/reference/cao_versions.md)
(what is installed against what was frozen),
[`cao_status()`](https://max578.github.io/cropOrchestra/reference/cao_status.md)
(a plain report, including why a member may be missing), and
[`cao_install()`](https://max578.github.io/cropOrchestra/reference/cao_install.md)
(fetch what is available).
[`cao_check()`](https://max578.github.io/cropOrchestra/reference/cao_check.md)
runs the fleet's gate scripts when a leader workspace is supplied, and
otherwise falls back to a status-plus-load-check.

## See also

Useful links:

- <https://github.com/max578/cropOrchestra>

- <https://max578.github.io/cropOrchestra/>

- Report bugs at <https://github.com/max578/cropOrchestra/issues>

## Author

**Maintainer**: Max Moldovan <max.moldovan@adelaide.edu.au>
([ORCID](https://orcid.org/0000-0001-9680-8474)) \[copyright holder\]

Authors:

- Max Moldovan <max.moldovan@adelaide.edu.au>
  ([ORCID](https://orcid.org/0000-0001-9680-8474)) \[copyright holder\]
