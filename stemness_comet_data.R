##stemness
library(dplyr)
library(data.table)

# Load the function
stemness_comet_spe <- function(spe, ML_model_weight) {
  w <- ML_model_weight$w
  
  # Extract the counts assay from the SpatialExperiment object
  matrix_exp <- as.matrix(assays(spe)$counts)
  
  # Check the gene label between the model and the matrix_prediction
  print(length(intersect(rownames(matrix_exp), names(w))))
  
  # Filter matrix_prediction by stemness model genes
  matrix_exp <- matrix_exp[rownames(matrix_exp) %in% names(w), ]
  print(length(rownames(matrix_exp)))
  
  # Filter stemness model with 'predict.DATA'
  w <- w[rownames(matrix_exp)]
  print(length(intersect(names(w), rownames(matrix_exp))))
  print(length(names(w)))
  print(is.vector(w)) #TRUE
  
  # Score the predict.DATA using Spearman correlation
  s <- apply(matrix_exp, 2, function(z) {cor(z, w, method = "spearman", use = "complete.obs")})
  print(s[1:5])
  
  # Scale the scores to be between 0 and 1
  s <- (s - min(s)) / (max(s) - min(s))
  print(s[1:5])
  
  # Assign stemness to seurat object
  s <- as.data.frame(s)
  spe[["stemness"]] <- s$s
  return(spe)
}

#Call the function
spe_with_stemness <- stemness_comet_spe(spe, mm)

spe@metadata$stemness <- spe_with_stemness$stemness

colData(spe)$stemness <- spe_with_stemness$stemness

spe$stemness <- as.numeric(spe$stemness)

plotSpatial(spe, 
            node_color_by = "stemness", 
            img_id = "sample_id", 
            node_size_fix = 0.5) +
  scale_color_gradient(low = "#d9eefa", high = "dodgerblue4") +
  theme(legend.position = "right", legend.title = element_blank(), legend.text = element_text(size = 8))

plotSpatial(spe[,spe$sample_id == "patient3_cleared"], 
            node_color_by = "stemness", 
            img_id = "sample_id", 
            node_size_fix = 0.5) +
  scale_color_gradient(low = "#d9eefa", high = "dodgerblue4") +
  theme(legend.position = "right", legend.title = element_blank(), legend.text = element_text(size = 8))

##define which cell types have the highest stemness level
stemness_df <- as.data.frame(colData(spe))

# Plot stemness values across different cluster cell types
ggplot(stemness_df, aes(x = cluster_celltype, y = stemness, fill = cluster_celltype)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = metadata(spe)$color_vectors$celltype) +
  labs(x = "Cluster Cell Type", y = "Stemness") +
  theme_minimal()

##for patient 1
patient1_data <- subset(as.data.frame(colData(spe)), patient_id == "patient1")

# Plot stemness values for patient 1
ggplot(patient1_data, aes(x = cluster_celltype, y = stemness, fill = cluster_celltype)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = metadata(spe)$color_vectors$celltype) +
  labs(title = "Stemness Distribution for Patient 1", x = "Cluster Cell Type", y = "Stemness") +
  theme_minimal()

ggplot(patient1_data) + 
  geom_density_ridges(aes(stemness, cluster_celltype, fill = cluster_celltype)) +
  scale_fill_manual(values = metadata(spe)$color_vectors$celltype) +
  labs(title = "Stemness Distribution for Patient 1", x = "Stemness", y = "Cluster Cell Type") +
  theme_minimal()

##for patient 3
patient3_data <- subset(as.data.frame(colData(spe)), patient_id == "patient3")

# Plot stemness values for patient 3
ggplot(patient3_data, aes(x = cluster_celltype, y = stemness, fill = cluster_celltype)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = metadata(spe)$color_vectors$celltype) +
  labs(title = "Stemness Distribution for Patient 3", x = "Cluster Cell Type", y = "Stemness") +
  theme_minimal()

ggplot(patient3_data) + 
  geom_density_ridges(aes(stemness, cluster_celltype, fill = cluster_celltype)) +
  scale_fill_manual(values = metadata(spe)$color_vectors$celltype) +
  labs(title = "Stemness Distribution for Patient 1", x = "Stemness", y = "Cluster Cell Type") +
  theme_minimal()

#ridges plots for both
library(ggridges)

ggplot(as.data.frame(patient1_data)) + 
  geom_density_ridges(aes(stemness, cluster_celltype, fill = cluster_celltype)) +
  scale_fill_manual(values = metadata(patient1_data)$color_vectors$celltype) +
  ggtitle("Density Ridgeline Plot for Patient 1")

saveRDS(spe, "spe.rds")