# Obesity Broad Machine Learning Competition 2025

![Downloads](https://img.shields.io/github/downloads/julielaffy/obesity-broad-ml-competition-2025/total?v=2)
![Python](https://img.shields.io/badge/Python-%3E%3D3.10-blue?logo=python)
![R](https://img.shields.io/badge/R-%3E%3D4.0-blue?logo=r)
![License](https://img.shields.io/github/license/julielaffy/obesity-broad-ml-competition-2025?v=2)

Program analysis pipeline to calculate proportions of adipocyte cell programs in Perturb-seq data.

**View the notebook:**
[Python version (HTML)](https://julielaffy.github.io/obesity-broad-ml-competition-2025/program_analysis_py.html) ·
[Python notebook on GitHub](program_analysis.ipynb) ·
[R version (HTML)](https://julielaffy.github.io/obesity-broad-ml-competition-2025/program_analysis.html)

## Data

Sample data provided in `data/m.allgenes.logcpm.parquet` (Python) and `data/m.allgenes.logcpm.rds` (R) — a subset of cells and genes.

## Usage

**Python:** Open `program_analysis.ipynb` in Jupyter or run:

```bash
jupyter nbconvert --to notebook --execute --inplace program_analysis.ipynb
```

**R:** Open `program_analysis.Rmd` and run interactively or render:

```r
rmarkdown::render("program_analysis.Rmd")
```

To execute code, set `eval = TRUE` in the setup chunk.

## Requirements

**Python:**

```bash
pip install pyscalop pandas pyarrow
```

**R:**

```r
install.packages(c("tidyverse", "Matrix", "reshape2"))
BiocManager::install("jlaffy/scalop")
```
