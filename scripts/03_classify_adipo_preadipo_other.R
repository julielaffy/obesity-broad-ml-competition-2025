
score_results = "data/permuted_scores.adipo_preadipo_sigs.rds"
fdr_cutoff = 0.01 
diff_cutoff = 0.3

# Load scores
scores = readRDS(score_results)

# Prepare data
scores_wide = scores %>%
	dplyr::select(id, sig, score, fdr) %>%
  	tidyr::pivot_wider(names_from = sig, values_from = c(score, fdr)) %>%
  	dplyr::mutate(
			max_adipo = pmax(score_adipomap.Ad, score_yi.AD),
  	  		max_preadipo = pmax(score_adipomap.ASPC, score_yi.ASPC),
  	  		score_diff = max_adipo - max_preadipo,
  	  		max_overall = pmax(score_adipomap.Ad,
					   score_yi.AD, 
					   score_adipomap.ASPC, 
					   score_yi.ASPC)
	)

# Classify cells
# Adipo logic: 
# - score_diff > {diff_cutoff} (adipo score higher than preadipo score)
# - both ASPC (preadipo) signatures must be non-significant (fdr >= {fdr_cutoff})
# - at least one adipocyte signature must be significant ({fdr_cutoff})
# Preadipo logic: 
# - score_diff < -{diff_cutoff} (preadipo score higher than adipo score)
# - both adipo signatures must be non-significant (fdr >= {fdr_cutoff})
# - at least one ASPC (preadipocyte) signature must be significant ({fdr_cutoff})
# Other: everything else (ambiguous, dual-identity, neither) 

scores_wide = scores_wide %>%
	dplyr::mutate(
		      compartment = dplyr::case_when(
						     score_diff > diff_cutoff & 
							     (fdr_adipomap.ASPC >= fdr_cutoff & fdr_yi.ASPC >= fdr_cutoff) &
							     (fdr_adipomap.Ad < fdr_cutoff | fdr_yi.AD < fdr_cutoff) ~ "Adipo",
						     score_diff < -1 * diff_cutoff & 
   			     				     (fdr_adipomap.Ad >= fdr_cutoff & fdr_yi.AD >= fdr_cutoff) &
   			     				     (fdr_adipomap.ASPC < fdr_cutoff | fdr_yi.ASPC < fdr_cutoff) ~ "Preadipo",
						     TRUE ~ "Other"
		      )
	)				

print(table(scores_wide$compartment))

# Extract cell IDs for each compartment
adipo_cells = scores_wide$id[scores_wide$compartment == "Adipo"]
preadipo_cells = scores_wide$id[scores_wide$compartment == "Preadipo"]
other_cells = scores_wide$id[scores_wide$compartment == "Other"]

# Save cell ID lists
cat("\nSaving cell ID lists...\n")
saveRDS(adipo_cells, 'data/cells.adipo.rds')
saveRDS(preadipo_cells, 'data/cells.preadipo.rds')
saveRDS(other_cells, 'data/cells.other.rds')

