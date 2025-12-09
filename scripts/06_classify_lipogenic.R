
score_results = "data/permuted_scores.lipogenic_sigs.rds"
fdr_cutoff = 0.01
score_cutoff = 0.3
n_sigs = 2

# Load scores
scores = readRDS(score_results)

# Prepare data
scores_wide = scores %>%
  dplyr::select(id, sig, score, fdr) %>%
  tidyr::pivot_wider(names_from = sig, values_from = c(score, fdr))

# Count how many signatures pass criteria per cell
n_pass = rowSums(sapply(names(scores_wide)[grepl("^score_", names(scores_wide))], function(score_col) {
  fdr_col = sub("^score_", "fdr_", score_col)
  scores_wide[[score_col]] > score_cutoff & scores_wide[[fdr_col]] < fdr_cutoff
}))

# Filter for cells that have at least {n_sigs} lipogenic signatures passing cutoffs
lipogenic_cells = scores_wide$id[n_pass >= n_sigs]

# Save cell ID list
saveRDS(lipogenic_cells, "data/cells.lipogenic.rds")






