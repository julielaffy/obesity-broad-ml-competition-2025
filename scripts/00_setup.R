# Install and load required packages for this analysis

# Set CRAN mirror (needed for non-interactive/vanilla mode)
options(repos = c(CRAN = "https://cloud.r-project.org"))

# CRAN packages
cran_packages <- c("Matrix", "dplyr", "tidyr", "tibble", "reshape2")

# Install missing CRAN packages
install.packages(setdiff(cran_packages, rownames(installed.packages())))

# BiocManager for Bioconductor packages (scalop depends on these)
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Install scalop
if (!"scalop" %in% rownames(installed.packages())) {
  BiocManager::install("jlaffy/scalop")
}

# Load all
lapply(c(cran_packages, "scalop"), library, character.only = TRUE)

