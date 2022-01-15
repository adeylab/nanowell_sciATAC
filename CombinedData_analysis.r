
CombinedData<-loadArchRProject(path="./CombinedData")
small_seRNA<-readRDS("./small_brainspan.rds")
markerTest<-getMarkerFeatures(ArchRProj = CombinedData, useMatrix="GeneScoreMatrix", groupBy="HarmonyClusters", testMethod="wilcoxon", bias=c("TSSEnrichmen
t", "log10(nFrags)"))
subsetSE <- markerTest[which(rowData(markerTest)$name %in% c(getFeatures(ArchRProj=CombinedData, select="Olfr")))]
testHeatmap<-markerHeatmap(seMarker=subsetSE, transpose=T)
ComplexHeatmap::draw(testHeatmap, heatmap_legend_side = "bot", annotation_legend_side = "bot")
plotPDF(testHeatmap, name = "OlfactoryReceptor.GeneScores.Heatmap", width = 8, height = 6, ArchRProj = CombinedData, addDOC = FALSE)
CombinedData<-addGeneIntegrationMatrix(ArchRProj=CombinedData, 
                                        useMatrix="GeneScoreMatrix", 
                                        matrixName="GeneIntegrationMatrix", 
                                        reducedDims="Harmony_LSIv3", 
                                        seRNA=small_seRNA, 
                                        groupRNA="subclass_label",
                                        nameCell = "predictedCell",
                                        nameGroup = "predictedGroup",
                                        nameScore = "predictedScore",
                                        force=T,
                                        threads=1)## Changed threads to save memory.
CombinedData<-saveArchRProject(ArchRProj=CombinedData)
cM<-confusionMatrix(CombinedData$HarmonyClusters, CombinedData$predictedGroup)
labelOld<-rowNames(cM)
labelNew<-colnames(cM)[apply(cM, 1, which.max)]
CombinedData$HarmonyClusters2<-mapLabels(CombinedData$HarmonyClusters, 
                                        newLabels=labelNew, 
                                        oldLabels=labelOld)
CombinedData<-saveArchRProject(ArchRProj=CombinedData)
CombinedData<-addGroupCoverages(ArchRProj=CombinedData, groupBy="HarmonyClusters2")
### Warning, the above uses a crap-pile of memory
### Probably want to save here just in case.
pathToMacs2 <- findMacs2()
CombinedData<-saveArchRProject(ArchRProj=CombinedData)
CombinedData<-addReproduciblePeakSet(ArchRProj = CombinedData, groupBy="HarmonyClusters2", pathToMacs2=pathToMacs2, force=T)
#Midbrain dopamine neuron (mDA) pitx3 https://doi.org/10.1038/s41467-019-08453-1 , "Nrsn2", "Impact", "Eno2", "Tuba4a" https://doi.org/10.1038/s41467-019-08453-1
# Corticospinal neuron L1CAM https://doi.org/10.3389/fncel.2020.00031 Bcl11b (https://www.jneurosci.org/content/31/11/4166) Otx1 Er81 (https://doi.org/10.1016/j.neuron.2004.12.036)
# Hippocampus markers Ebpl HMGCR actn2, nrgn, Calb1 (http://hippocampome.org/php/markers.php)
CombinedData<-addPeakMatrix(CombinedData, force=T)
CombinedData<-addCoAccessibility(ArchRProj=CombinedData, reducedDims="Harmony_LSIv3", force=T)
cA<-getCoAccessibility(ArchRProj=CombinedData, corCutOff=0.5, resolution=1, returnLoops=F)
CombinedData<-saveArchRProject(ArchRProj=CombinedData)
