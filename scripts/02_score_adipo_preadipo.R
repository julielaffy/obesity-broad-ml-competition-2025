proc_matrix = "data/m.logcpm.rds" 
gene_sigs = "sigs/adipo_preadipo_sigs.rds"
frac_genes_retained = 0.5
n_genes_retained = 10
score_results = "data/permuted_scores.adipo_preadipo_sigs.rds"

# Read in processed expression matrix
m = readRDS(proc_matrix)

# Read in gene signatures to score cells by
# there are 2 adipocyte signatures: "adipomap.Ad" and "yi.AD"
# and 2 pre-adipocyte (progenitor) signatures: "adipomap.ASPC" and "yi.ASPC"
sigs = readRDS(gene_sigs)

# Filter out signatures whose genes are poorly represented in {proc_matrix}
# A signature is kept if at least 10 genes and 50% of the signature exist in {proc_matrix}
# {frac_genes_retained} and {n_genes_retained}
sigs_filt = sigs[sapply(sigs, function(x) sum(x %in% rownames(m)) >= n_genes_retained)]

# Calculate single-cell expression scores for each signature and FDRs
scores_permuted = permuteSigScores(m, sigs_filt, conserved.genes=frac_genes_retained)

# Save results
saveRDS(scores_permuted, score_results)
