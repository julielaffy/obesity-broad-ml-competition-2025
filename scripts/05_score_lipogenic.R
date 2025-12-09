
proc_matrix = "data/m.adipo.logcpm.rds" 
gene_sigs = "sigs/lipogenic_sigs.rds"
frac_genes_retained = 0.5
n_genes_retained = 10
score_results = "data/permuted_scores.lipogenic_sigs.rds"

# Read in processed expression matrix
m = readRDS(proc_matrix)

# Read in gene signatures to score cells by
# These are a collection of lipogenic signatures
sigs = readRDS(gene_sigs)

# Filter out signatures whose genes are poorly represented in {proc_matrix}
# A signature is kept if at least 10 genes and 50% of the signature exist in {proc_matrix}
# {frac_genes_retained} and {n_genes_retained}
sigs_filt = sigs[sapply(sigs, function(x) sum(x %in% rownames(m)) >= n_genes_retained)]

# Calculate single-cell expression scores for each signature and FDRs
scores_permuted = permuteSigScores(m, sigs_filt, conserved.genes=frac_genes_retained)

# Save results
saveRDS(scores_permuted, score_results)

