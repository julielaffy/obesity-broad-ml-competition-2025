
# get cell assignment file paths
cell_files = list.files("data", full.names = T, pattern = "^cells")

# read in cell assignments
cell_list = sapply(cell_files, readRDS, simplify=F)

# fix names and reorder groups
names(cell_list) = scalop::substri(basename(names(cell_list)),pos=2)
ord = c('adipo','preadipo','other','lipogenic')
cell_list = cell_list[ord]

# get cell proportions
n_cells = lengths(cell_list)
frac_cells = n_cells/sum(n_cells[-4])
print(frac_cells)
