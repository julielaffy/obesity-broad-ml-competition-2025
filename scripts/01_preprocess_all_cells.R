library(Matrix)
library(scalop)

full_matrix = "data/m.allgenes.logcpm.rds"
proc_matrix = "data/m.logcpm.rds" 
gene_cutoff = 3

# read in expression matrix
# already in form log2(CPM/10 + 1)
m <- readRDS(full_matrix)
m <- as.matrix(m)

# calculate average gene expression
avg <- scalop::aggr_gene_expr(m, isBulk=F)

# filter genes that do not pass minimum gene expression cutoff
m2 <- m[avg >= gene_cutoff, ]

# save filtered matrix
saveRDS(m2, proc_matrix)

