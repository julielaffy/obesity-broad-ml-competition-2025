
score_results = "data/permuted_scores.thermo_sigs.rds"
cell_out = "data/ThermoScores_cell.csv"
perturbation_out = "data/ThermoScores_perturbation.csv"

# Load per-(cell, sig) scores from script 08
scores = readRDS(score_results)

# 1. Z-score each signature across all adipocyte cells
# z = (raw_score - mean_across_cells) / sd_across_cells
scores = scores %>%
  dplyr::group_by(sig) %>%
  dplyr::mutate(z_score = (score - mean(score)) / stats::sd(score)) %>%
  dplyr::ungroup()

# 2. Derive perturbation (gene) from cell id prefix.
#    TF150 convention only — otherwise use AnnData `.obs['gene']` / cell metadata.
scores$gene = sub("_.*", "", as.character(scores$id))

# 3. Per-cell wide table: one row per cell, sig columns for raw score, z_-prefixed columns for z-score
cell_wide = scores %>%
  dplyr::select(cell_id = id, gene, sig, score, z_score) %>%
  tidyr::pivot_wider(names_from = sig, values_from = c(score, z_score),
                     names_glue = "{ifelse(.value == 'score', '', 'z_')}{sig}")

write.csv(cell_wide, cell_out, row.names = FALSE)

# 4. Per-perturbation aggregation:
#    - mean z-score per (gene, sig) across all cells of that perturbation
#    - agg_top3_z = mean of the top-3 sig z-scores for that perturbation
#    - rank perturbations from highest to lowest agg_top3_z
perturb_long = scores %>%
  dplyr::group_by(gene, sig) %>%
  dplyr::summarise(mean_z = mean(z_score), .groups = "drop")

perturb_wide = perturb_long %>%
  tidyr::pivot_wider(names_from = sig, values_from = mean_z)

agg_top3 = function(row) mean(sort(unlist(row), decreasing = TRUE)[1:3])

sig_cols = setdiff(names(perturb_wide), "gene")
perturb_wide$agg_top3_z = apply(perturb_wide[, sig_cols], 1, agg_top3)
perturb_wide = perturb_wide %>% dplyr::arrange(dplyr::desc(agg_top3_z))
perturb_wide$rank = seq_len(nrow(perturb_wide))

write.csv(perturb_wide, perturbation_out, row.names = FALSE)
