counts <- read.csv("dataset_1/count_table.csv", row.names = 1)
true_adj <- read.csv("dataset_1/adj.csv", row.names = 1)

counts <- as.matrix(counts)
true_adj <- as.matrix(true_adj)

dim(counts)
dim(true_adj)

head(counts)
summary(counts)


library(mbImpute)

counts_imputed <- mbImpute(otu_tab = counts)
counts_norm <- counts_imputed$imp_count_mat_origlibsize


library(edgeR)
dge <- DGEList(counts = counts_norm)
dge <- calcNormFactors(dge, method = "TMM")

norm_counts <- cpm(dge, log = TRUE, prior.count = 1)

