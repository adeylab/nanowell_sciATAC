### Trying to test different gene marker sets
library(presto)
source("/home/groups/oroaklab/nishida/ArchR/ArchR/R/MatrixTiles.R")
library(ArchR)
# markerGenes<-c("KDR", "FLT1","Cldn5")
# tp <-plotEmbedding(
	# ArchRProj = bigProj,
	# colorBy="GeneScoreMatrix",
	# name=markerGenes,
	# embedding="UMAP_LSIv3_Harmony", #For shits and giggles
	# imputeWeights=getImputeWeights(bigProj)
	# )
# tp2 <-lapply(tp, function(x){
	# x + guides(color = FALSE, fill = FALSE) +
	# theme_ArchR(baseSize = 6.5) +
	# theme(plot.margin = unit(c(0, 0, 0, 0), "cm")) +
	# theme(
	# axis.text.x=element_blank(),
	# axis.ticks.x=element_blank(),
	# axis.text.y=element_blank(),
	# axis.ticks.y=element_blank()
	# )
# })
# do.call(cowplot::plot_grid, c(list(ncol=3), tp2))
# plotPDF(plotList=tp, name="Endothelia_wImputation_LSIv3.pdf", ArchRProj=bigProj, addDOC=F, width=5, height=5)

# markerGenes<-c("Gfap","Glul","Agt","Pdpn","GJA1", "AQP4", "NTSR2")
# tp <-plotEmbedding(
	# ArchRProj = bigProj,
	# colorBy="GeneScoreMatrix",
	# name=markerGenes,
	# embedding="UMAP", 
	# imputeWeights=getImputeWeights(bigProj)
	# )
# tp2 <-lapply(tp, function(x){
	# x + guides(color = FALSE, fill = FALSE) +
	# theme_ArchR(baseSize = 6.5) +
	# theme(plot.margin = unit(c(0, 0, 0, 0), "cm")) +
	# theme(
	# axis.text.x=element_blank(),
	# axis.ticks.x=element_blank(),
	# axis.text.y=element_blank(),
	# axis.ticks.y=element_blank()
	# )
# })
# do.call(cowplot::plot_grid, c(list(ncol=3), tp2))
# plotPDF(plotList=tp, name="Astrocytes_wImputation.pdf", ArchRProj=bigProj, addDOC=F, width=5, height=5)
# markerGenes<-=c("C1qa","C1qc","Cx3cr1","Mrc1", "Ctss", "TyroBP")
# tp <-plotEmbedding(
	# ArchRProj = bigProj,
	# colorBy="GeneScoreMatrix",
	# name=markerGenes,
	# embedding="UMAP", 
	# imputeWeights=getImputeWeights(bigProj)
	# )
# tp2 <-lapply(tp, function(x){
	# x + guides(color = FALSE, fill = FALSE) +
	# theme_ArchR(baseSize = 6.5) +
	# theme(plot.margin = unit(c(0, 0, 0, 0), "cm")) +
	# theme(
	# axis.text.x=element_blank(),
	# axis.ticks.x=element_blank(),
	# axis.text.y=element_blank(),
	# axis.ticks.y=element_blank()
	# )
# })
# do.call(cowplot::plot_grid, c(list(ncol=3), tp2))
# plotPDF(plotList=tp, name="MicrogliaMacrophages_wImputation.pdf", ArchRProj=bigProj, addDOC=F, width=5, height=5)
# markerGenes<-c("Slc17a7","Col19a1","Dkk3","Ociad2","Rorb","Foxp2", "sulf1")
# tp <-plotEmbedding(
	# ArchRProj = bigProj,
	# colorBy="GeneScoreMatrix",
	# name=markerGenes,
	# embedding="UMAP", 
	# imputeWeights=getImputeWeights(bigProj)
	# )
# tp2 <-lapply(tp, function(x){
	# x + guides(color = FALSE, fill = FALSE) +
	# theme_ArchR(baseSize = 6.5) +
	# theme(plot.margin = unit(c(0, 0, 0, 0), "cm")) +
	# theme(
	# axis.text.x=element_blank(),
	# axis.ticks.x=element_blank(),
	# axis.text.y=element_blank(),
	# axis.ticks.y=element_blank()
	# )
# })
# do.call(cowplot::plot_grid, c(list(ncol=3), tp2))
# plotPDF(plotList=tp, name="GlutamatergicNeurons_wImputation.pdf", ArchRProj=bigProj, addDOC=F, width=5, height=5)
# markerGenes<-c("Gad1","Gad2","Pvalb","Dlx1","Dlx2","Sst", "Vip", "Slc32A1", "Pvalb")
# tp <-plotEmbedding(
	# ArchRProj = bigProj,
	# colorBy="GeneScoreMatrix",
	# name=markerGenes,
	# embedding="UMAP", 
	# imputeWeights=getImputeWeights(bigProj)
	# )
# tp2 <-lapply(tp, function(x){
	# x + guides(color = FALSE, fill = FALSE) +
	# theme_ArchR(baseSize = 6.5) +
	# theme(plot.margin = unit(c(0, 0, 0, 0), "cm")) +
	# theme(
	# axis.text.x=element_blank(),
	# axis.ticks.x=element_blank(),
	# axis.text.y=element_blank(),
	# axis.ticks.y=element_blank()
	# )
# })
# do.call(cowplot::plot_grid, c(list(ncol=3), tp2))
# plotPDF(plotList=tp, name="GABAergicNeurons_wImputation.pdf", ArchRProj=bigProj, addDOC=F, width=5, height=5)

### Getting whole features list
features<-list(
	OligOPC=c("CSPG4","OLIG1","PDGFRA", "MOBP", "MOG", "CLDN11", "Mbp", "CNP"),
	Endothelia=c("KDR", "FLT1","Cldn5"),
	Astrocytes=c("Gfap","Glul","Agt","Pdpn","GJA1", "AQP4", "NTSR2"),
	Microglia=c("C1qa","C1qc","Cx3cr1","Mrc1", "Ctss", "TyroBP"),
	GlutamatergicNeurons=c("Slc17a7","Col19a1","Dkk3","Ociad2","Rorb","Foxp2", "sulf1"),
	GABAergicNeurons=c("Gad1","Gad2","Pvalb","Dlx1","Dlx2","Sst", "Vip", "Slc32A1", "Pvalb")
	#GeneralNeuron=c("Lamp5","Cux2", "RAB3A", "YWHAB", "NDRG4","Elavl4", "Spin1", "MAPK8", "STAU2"), ###Don't necessarily need this one
	)

### addModuleScores for features	
bigProj<-addModuleScore(bigProj, features=features, useMatrix="GeneScoreMatrix")

##############################################################################################
### Need to put the stuff for writing to tsv files here
##############################################################################################



##############################################################################################
### Subset data (Using harmony clusters)
##############################################################################################
GABAProj<- subsetArchRProject(ArchRProj=combinedData, cells = combinedData$cellNames[which(combinedData$HarmonyClusters == "C13" | combinedData$HarmonyClusters == "C14" | combinedData$HarmonyClusters == "C19")], outputDirectory = "ArchRSubset", dropCells = TRUE, logFile = NULL, threads = getArchRThreads(), force = FALSE)