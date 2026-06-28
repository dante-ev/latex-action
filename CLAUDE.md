# latex-action

GitHub Action that compiles LaTeX documents inside the
[`ghcr.io/dante-ev/texlive`](https://github.com/dante-ev/docker-texlive) image.
It is a thin wrapper: `action.yml` (inputs) + `Dockerfile` (FROM the texlive
image, copies `entrypoint.sh`).

The default branch is **`edge`** (not `main`).

## Versioning

Mirrors [dante-ev/docker-texlive](https://github.com/dante-ev/docker-texlive):
**`YYYY-R`** (e.g. `2026-A`), one release per docker-texlive release it is based
on. Non-semver on purpose — see `CHANGELOG.md`.

## Base image & reproducibility

- **`edge` (default branch) uses `ghcr.io/dante-ev/texlive:edge`** so it tracks
  the latest docker-texlive build.
- **A tagged release pins** the base to the matching `:<year>-R`, e.g.
  `ghcr.io/dante-ev/texlive:2026-A`. That release can only be cut **after** the
  docker-texlive image of the same tag is published, since the build pulls it.

## Test locally

The action's entrypoint takes positional args:
`root_file working_directory compiler args extra_system_packages extra_font_packages`.

```bash
docker build -t latex-action-test .
docker run --rm -v "$PWD/test":/data latex-action-test \
  test.tex /data latexmk \
  "-pdf -latexoption=-file-line-error -latexoption=-interaction=nonstopmode" "" ""
# -> test.pdf appears in test/
```

(The Dockerfile sets `WORKDIR /root`; pass the mount path as `working_directory`
so the compiler finds the sources. GitHub Actions injects the workspace dir
automatically, so real workflows don't need this.)

## Cutting a release (e.g. `2026-A`)

1. `CHANGELOG.md`: add a `## [<year>-R] - <date>` section + compare link.
2. `Dockerfile`: pin `FROM ghcr.io/dante-ev/texlive:<year>-R`.
3. Commit `Release <year>-R` and tag `<year>-R`.
4. Commit `Switch back to edge`.

## CHANGELOG checks

`CHANGELOG.md` is validated in CI by `.github/workflows/check-changelog.yml`
([heylogs](https://github.com/nbbrd/heylogs)). `heylogs.properties` disables the
rules that clash with this changelog's custom layout. Run locally via
`jbang com.github.nbbrd.heylogs:heylogs-cli:0.18.1:bin check CHANGELOG.md`.
