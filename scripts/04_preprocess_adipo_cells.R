
adipo_cells = "data/cells.adipo.rds"
full_matrix = "data/m.allgenes.logcpm.rds"
proc_matrix = "data/m.adipo.logcpm.rds"
gene_cutoff = 3

# read expression matrix and cells classified as Adipo
cells = readRDS(adipo_cells)
m = readRDS(full_matrix)
m = as.matrix(m)

# filter to keep only Adipo cells 
m_adipo = m[, cells]

# calculate average gene expression
avg = scalop::aggr_gene_expr(m_adipo, isBulk=F)

# filter genes that do not pass minimum gene expression cutoff
m2 = m_adipo[avg >= gene_cutoff, ]

# save filtered matrix
saveRDS(m2, proc_matrix)

