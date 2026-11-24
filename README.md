# meta-forest-sizing

Minimal reproduction comparing PDF and PNG rendering from `meta::forest(..., filename = ...)` across Linux, Windows, and macOS.

## Why this happens

`forest_dims_internal()` measures column widths and row heights on an offscreen `pdf(file = NULL)` device (using PostScript Helvetica AFM font metrics), even when saving to another format. When `ragg` is installed, `forest(..., filename = "*.png")` renders with `ragg::agg_png()`.

- On Windows and macOS, `ragg` uses Arial / Helvetica, whose metrics are close to PDF's Helvetica AFM.
- On Linux (`ubuntu-latest`), `ragg` resolves `sans` to **DejaVu Sans**, which is wider than Helvetica AFM. As a result, the PNG width is underestimated and text can be clipped, while the corresponding PDF output fits.

## Run locally

With `meta` and `ragg` installed:

```sh
Rscript --vanilla reproduce.R
```

This writes `results/forest.pdf` and `results/forest.png` using `forest()`'s default automatic sizing.

## Run on GitHub Actions

1. Open **Actions > Forest saving example > Run workflow**.
2. Once finished, download the `forest-ubuntu-latest`, `forest-windows-latest`, and `forest-macos-latest` artifacts to compare the PDF and PNG outputs across OSes.
