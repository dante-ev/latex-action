# latex-action [![GitHub Actions Status](https://github.com/dante-ev/latex-action/workflows/Test%20Github%20Action/badge.svg)](https://github.com/dante-ev/latex-action/actions)

> GitHub Action to compile LaTeX documents.

This actions runs on docker using a [maximal TeXLive environment](https://hub.docker.com/r/danteev/texlive/) installed.

## Inputs

* `root_file`

    The root LaTeX file to be compiled. This input is required.

* `working_directory`

    The working directory for the latex compiler to be invoked.

* `compiler`

    The LaTeX engine to be used. By default [`latexmk`](https://ctan.org/pkg/latexmk) is used. `latexmk` automates the process of generating LaTeX documents by issuing the appropriate sequence of commands to be run.

* `args`

    The extra arguments to be passed to the compiler. By default, it is `-pdf -latexoption=-file-line-error -latexoption=-interaction=nonstopmode`. This tells `latexmk` to use `pdflatex`. Refer to [`latexmk` document](http://texdoc.net/texmf-dist/doc/support/latexmk/latexmk.pdf) for more information.

* `extra_system_packages`

    The extra packages to be installed by [`apt-get`](https://en.wikipedia.org/wiki/APT_(Package_Manager)) separated by space.

## Examples

### Build `main.tex` using `latexmk`

Note that by default [`latexmk`](https://ctan.org/pkg/latexmk) is used.
`latexmk` automates the process of generating LaTeX documents by issuing the appropriate sequence of commands to be run.

```yaml
name: Build LaTeX document
on: [push]
jobs:
  build_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2
      - name: Compile LaTeX document
        uses: dante-ev/latex-action@latest
        with:
          root_file: main.tex
```

### Build `example-class-relations--svg.tex` using `lualatex`

This is required if one does not trust latexmk and wants to build "by hand"

```yaml
name: Build LaTeX document
on: [push]
jobs:
  build_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2
      - name: example-class-relations--svg
        uses: dante-ev/latex-action@latest
        with:
          root_file: example-class-relations--svg.tex
          compiler: lualatex
          args: -interaction=nonstopmode -shell-escape
```

### "Real" document

In a "real" document, one would have to encode all steps one after another:

```yaml
name: Build LaTeX document
on: [push]
jobs:
  build_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2
      - name: pdflatex main
        uses: dante-ev/latex-action@latest
        with:
          root_file: main.tex
          compiler: pdflatex
          args: -interaction=nonstopmode -shell-escape
      - name: bibtex main
        uses: dante-ev/latex-action@latest
        with:
          root_file: main.tex
          compiler: bibtex
          args: 
      - name: pdflatex main
        uses: dante-ev/latex-action@latest
        with:
          root_file: main.tex
          compiler: pdflatex
          args: -interaction=nonstopmode -shell-escape
```

### Custom build script

When using a custom shell script for building, one can pass this as follows:

```yaml
name: Build LaTeX document
on: [push]
jobs:
  build_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v2
      - name: release.sh
        uses: dante-ev/latex-action@latest
        with:
          entrypoint: ./release.sh
```

Real life example: <https://github.com/koppor/plantuml/blob/main/.github/workflows/build-and-publish.yml>

## FAQs

### How to use XeLaTeX or LuaLaTeX instead of pdfLaTeX?

By default, this action uses pdfLaTeX. If you want to use XeLaTeX or LuaLaTeX, you can set the `args` to `-xelatex -latexoption=-file-line-error -latexoption=-interaction=nonstopmode` or `-lualatex -latexoption=-file-line-error -latexoption=-interaction=nonstopmode` respectively. Alternatively, you could create a `.latexmkrc` file. Refer to the [`latexmk` document](https://mg.readthedocs.io/latexmk.html) for more information.
Please mind that it is **not recommend** to change the `compiler` parameter, as the by default used `latexmk` has the advantage of determinating the (re)compilation steps automatically and executes them.

### How to enable `--shell-escape`?

To enable `--shell-escape`, you should add it to `args`. For example, set `args` to `-pdf -latexoption=-file-line-error -latexoption=-interaction=nonstopmode -latexoption=-shell-escape` when using pdfLaTeX.

### Where does the initial code come from?

The initial code is from [xu-cheng/latex-action](https://github.com/xu-cheng/latex-action).
The idea there is to initially provide all packages instead of using [texliveonfly](https://ctan.org/pkg/texliveonfly).
Using a full installation, this action also offers to use packages such as [pax](https://ctan.org/pkg/pax), which require other tooling such as perl.
More reasoning is given in [ADR-0002](https://github.com/dante-ev/docker-texlive/blob/master/docs/adr/0002-provide-all-packages.md#provide-all-packages).

### How can I speedup the build?

You can try to use [caching](https://docs.github.com/en/actions/guides/caching-dependencies-to-speed-up-workflows), though be careful as sometimes a LaTeX document needs to be rebuilt completly in order to have a proper result.

Here is an example that rebuilds uses the cache at most once a day. The files to cache [are taken from the well-known GitHub `.gitignore` templates](https://github.com/github/gitignore/blob/master/TeX.gitignore):

```yaml
      # https://github.com/actions/cache#creating-a-cache-key
      # http://man7.org/linux/man-pages/man1/date.1.html
      - name: Get Date
        id: get-date
        run: |
          echo "::set-output name=date::$(/bin/date -u "+%Y%m%d")"
        shell: bash

      - name: Cache
        uses: actions/cache@v2.1.3
        with:
          # A list of files, directories, and wildcard patterns to cache and restore
          path: |
            *.aux
            *.lof
            *.lot
            *.fls
            *.out
            *.toc
            *.fmt
            *.fot
            *.cb
            *.cb2
            .*.lb
            *.bbl
            *.bcf
            *.blg
            *-blx.aux
            *-blx.bib
            *.run.xml
          key: ${{ runner.os }}-${{ steps.get-date.outputs.date }}
```

## Where to find my PDF?

Please use an appropriate GitHub action.
One option is [upload-artifact](https://github.com/actions/upload-artifact), which collects the build artifacts and stores them into a GitHub space.
Another option is to use rsync via [action-rsyncer](https://github.com/Pendect/action-rsyncer).

## Available versions

* `@latest` points to the latest release of [DANTE e.V.'s docker-texlive](https://github.com/dante-ev/docker-texlive)
* `@edge` is the latest development version of [DANTE e.V.'s docker-texlive](https://github.com/dante-ev/docker-texlive)

## License

MIT
