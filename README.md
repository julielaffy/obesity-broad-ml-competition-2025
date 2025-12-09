# Obesity Broad Machine Learning Competition 2025

![Downloads](https://img.shields.io/github/downloads/julielaffy/obesity-broad-ml-competition-2025/total)
![R](https://img.shields.io/badge/R-%3E%3D4.0-blue?logo=r)
![License](https://img.shields.io/github/license/julielaffy/obesity-broad-ml-competition-2025)

Program analysis pipeline to calculate proportions of adipocyte cell programs in Perturb-seq data.

[View program_analysis.html](https://julielaffy.github.io/obesity-broad-ml-competition-2025/program_analysis.html)

## Data

Sample data provided in `data/m.allgenes.logcpm.rds` (subset of all cells and genes).

## Usage

Open `program_analysis.Rmd` and run interactively or render:

```r
rmarkdown::render("program_analysis.Rmd")
```

To execute code, set `eval = TRUE` in the setup chunk.

## Requirements

```r
install.packages(c("tidyverse", "Matrix", "reshape2"))
BiocManager::install("jlaffy/scalop")
```
