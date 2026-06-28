# Changelog

All notable changes to this project will be documented in this file.

This project cannot adhere to [Semantic Versioning](https://semver.org/), because it builds on TeXLive, which introduces breaking changes now and then.
Thus, each new version would lead to a new major version.
Instead, we version `YYYY-R`, where `YYYY` is TeXLive version this image is based on and `R` is numbering different releases in that cycle using characters.
E.g., `2021-A`, `2021-B`, ...
We use letters instead of numbers to avoid confusion with the automatic builds such as `2021-05-15`.

## [edge]

This version is continuously built based on [DANTE e.V.'s docker-texlive `edge` build](https://github.com/dante-ev/docker-texlive/).

## [2026-A] - 2026-06-28

### Changed

- Base on [DANTE e.V.'s docker-texlive 2026-A](https://github.com/dante-ev/docker-texlive/releases/tag/2026-A)

## [2025-A] - 2025-05-10

### Changed

- Base on [DANTE e.V.'s docker-texlive 2025-A](https://github.com/dante-ev/docker-texlive/releases/tag/2025-A)

## [2024-B] - 2025-02-13

### Changed

- Base on [DANTE e.V.'s docker-texlive 2024-B](https://github.com/dante-ev/docker-texlive/releases/tag/2024-B)

## [2024-A] - 2025-02-13

### Changed

- Base on [DANTE e.V.'s docker-texlive 2024-A](https://github.com/dante-ev/docker-texlive/releases/tag/2024-A)

## [2023-A] - 2023-05-12

### Added

- Added support for `extra_font_packages` to install fonts from zip files

### Changed

- Base on [DANTE e.V.'s docker-texlive 2023-A](https://github.com/dante-ev/docker-texlive/releases/tag/2023-A)

## [2020-A] - 2021-09-18

### Changed

- Base on [DANTE e.V.'s docker-texlive 2020-A](https://github.com/dante-ev/docker-texlive/releases/tag/2020-A)

## [2019-A] - 2021-09-15

### Changed

- Base on [DANTE e.V.'s docker-texlive 2019-A](https://github.com/dante-ev/docker-texlive/releases/tag/2019-A)

## [2021-C] - 2021-08-04

### Changed

- Base on [DANTE e.V.'s docker-texlive 2021-C](https://github.com/dante-ev/docker-texlive/releases/tag/2021-C)

## [2021-B] - 2021-06-11

### Changed

- Base on [DANTE e.V.'s docker-texlive 2021-B](https://github.com/dante-ev/docker-texlive/releases/tag/2021-B)

## [2021-A] - 2021-05-18

### Changed

- Base on [DANTE e.V.'s docker-texlive 2021-A](https://github.com/dante-ev/docker-texlive/releases/tag/2021-A)
- Offer `@edge` and `@latest` tags

## [0.2.0] - 2019-09-25

### Changed

- Changed name and description of the GitHub action

## [0.1.0] - 2019-09-25

### Added

- Initial public release

[edge]: https://github.com/dante-ev/latex-action/compare/2026-A...edge
[2026-A]: https://github.com/dante-ev/latex-action/compare/2025-A...2026-A
[2025-A]: https://github.com/dante-ev/latex-action/compare/2024-B...2025-A
[2024-B]: https://github.com/dante-ev/latex-action/compare/2024-A...2024-B
[2024-A]: https://github.com/dante-ev/latex-action/compare/2023-A...2024-A
[2023-A]: https://github.com/dante-ev/latex-action/compare/2021-C...2023-A
[2021-C]: https://github.com/dante-ev/latex-action/compare/2021-B...2021-C
[2021-B]: https://github.com/dante-ev/latex-action/compare/2021-A...2021-B
[2021-A]: https://github.com/dante-ev/latex-action/compare/v0.2.0...2021-A
[2020-A]: https://github.com/dante-ev/latex-action/compare/2019-A...2020-A
[2019-A]: https://github.com/dante-ev/latex-action/compare/2021-C...2019-A
[0.2.0]: https://github.com/dante-ev/latex-action/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/dante-ev/latex-action/releases/tag/v0.1.0
