
proc_matrix = "data/m.adipo.logcpm.rds"
gene_sigs = "sigs/thermo_sigs.rds"
n_genes_retained = 2
score_results = "data/permuted_scores.thermo_sigs.rds"

# Read in processed adipocyte expression matrix
m = readRDS(proc_matrix)

# Read in the 12 thermogenic gene signatures
sigs = readRDS(gene_sigs)

# Trim each signature to genes present in the matrix
sigs_present = sapply(sigs, function(x) x[x %in% rownames(m)], simplify = FALSE)

# Keep only sigs with at least {n_genes_retained} of their genes in the matrix
sigs_to_score = sigs_present[lengths(sigs_present) >= n_genes_retained]

# Score each signature against each cell (raw score + permutation-based FDR)
scores = permuteSigScores(m, sigs_to_score, conserved.genes = 0)

# Annotate each row with how many genes the signature contributed
scores$n_genes_used = lengths(sigs_to_score)[as.character(scores$sig)]

# Save long per-(cell, sig) table: id, sig, score, fdr, n_genes_used
saveRDS(scores, score_results)
