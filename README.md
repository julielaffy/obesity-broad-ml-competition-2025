# Obesity Broad ML Competition 2025

Program analysis for identifying adipocyte cell programs in Perturb-seq data of differentiating adipocyte cells.

## Data

Sample data provided in `data/m.allgenes.logcpm.rds` (subset of all cells and genes for faster execution).

## Usage

```r
rmarkdown::render("program_analysis.Rmd")
```

To execute the code (not just display), set `eval = TRUE` in the setup chunk.
