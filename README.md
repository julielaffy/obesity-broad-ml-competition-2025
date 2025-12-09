# Obesity Broad Machine Learning Competition 2025

![Views](https://komarev.com/ghpvc/?username=julielaffy&repo=obesity-broad-ml-competition-2025&color=blue)
![Downloads](https://img.shields.io/github/downloads/julielaffy/obesity-broad-ml-competition-2025/total)

Program analysis pipeline to calculate proportions of adipocyte cell programs in Perturb-seq data.

## Data

Sample data provided in `data/m.allgenes.logcpm.rds` (subset of all cells and genes).

## Usage

Open `program_analysis.Rmd` and run interactively or render:

```r
rmarkdown::render("program_analysis.Rmd")
```

To execute code, set `eval = TRUE` in the setup chunk.
