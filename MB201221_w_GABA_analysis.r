MB201221<-loadArchRProject(path="MB201221")
tmp<-which(MB201221@cellColData$Clusters %in% c("C3", "C4", "C5", "C13","C14","C15","C16","C17"))
GABA_subset_cells<-MB201221$cellNames[tmp]
MB201221_GABA<-MB201221[GABA_subset_cells,]
MB201221_GABA<- addIterativeLSI(ArchRProj=MB201221_GABA, 
                                useMatrix="TileMatrix", 
                                name = "IterativeLSI_GABAsubset",
                                force=TRUE,
                                iterations=5, 
                                clusterParams = list(resolution=2),
                                varFeatures = 600000, 
                                totalFeatures=1e+06)
MB201221_GABA<-saveArchRProject(ArchRProj=MB201221_GABA, outputDirectory="MB201221_GABA")
MB201221_GABA<-addClusters(input=MB201221_GABA,
                            reducedDims="IterativeLSI_GABAsubset", 
                            name="Clusters_GABA")
MB201221_GABA<-addUMAP(ArchRProj=MB201221_GABA, 
                        reducedDims="IterativeLSI_GABAsubset", 
                        name="UMAP_GABA", 
                        minDist=0.1)
p1 <- plotEmbedding(ArchRProj = MB201221_GABA, colorBy = "cellColData", name = "Clusters_GABA", embedding = "UMAP_GABA")
plotPDF(p1, name="MB201221_GABAsubclusters.UMAP", ArchRProj=MB201221_GABA, addDOC=F, width=5, height=5)
markerGS<-getMarkerFeatures(ArchRProj=MB201221_GABA, useMatrix="GeneScoreMatrix", groupBy="Clusters_GABA", bias=c("TSSEnrichment", "log10(nFrags)"),testMethod = "wilcoxon")
markerList <- getMarkers(markerGS, cutOff = "FDR <= 0.01 & Log2FC >= 1.25")
heatmapGS<- markerHeatmap(seMarker=markerGS, cutOff="FDR <= 0.01 & Log2FC >= 1.25",transpose=T)
ComplexHeatmap::draw(heatmapGS, heatmap_legend_side='bot', annotation_legend_side="bot")
plotPDF(heatmapGS, name="MB201221_GABA_genescores.MarkerHeatmap", width = 16, height=6, ArchRProj=MB201221_GABA)
gabaMarkers<-c("Xkr4","Cpa6","Prex2","A830018L16Rik", "Olfr1413", "Rnf152", "Cdh19", "Myoc","Il17a", "Mir6896", "Creg2", "Il1r1","Myo1b", "Cryge", "Cps1", "Erbb4","Pi15", "Gm16070", "Crispld1", "Gm4956","Mir30c-2", "Khdrbs2", "Gm5415", "Gulp1","Lincmd1", "Ctla4", "Myl1", "Lancl1","Il18rap", "Alpi", "Efhd1", "Olfr12","4931428L18Rik", "Nrp2", "4930487H11Rik", "Lypd1","AA619741", "1700066B17Rik", "Pantr1", "Pou3f3","Sbspon", "Gm17767", "Crygd", "A630001G21Rik","Fn1", "Apol7d", "Gm8883", "1700027A15Rik","A830018L16Rik", "Ogfrl1", "Gm3646", "Ramp1","Cd209c", "Cpa6", "Prex2", "A830018L16Rik","Plk5", "Rac2", "Mlc1", "Lta","Lyg2", "9930111H07Rik", "Mir128-1", "9330162B11Rik","Slc5a8", "Olfr769", "Olfr790", "Gm12130")_
gabaMarkers<-c("Xkr4","Cpa6","Prex2","A830018L16Rik", "Olfr1413", "Rnf152", "Cdh19", "Myoc","Il17a", "Mir6896", "Creg2", "Il1r1","Myo1b", "Cryge", "Cps1", "Erbb4","Pi15", "Gm16070", "Crispld1", "Gm4956","Mir30c-2", "Khdrbs2", "Gm5415", "Gulp1","Lincmd1", "Ctla4", "Myl1", "Lancl1","Il18rap", "Alpi", "Efhd1", "Olfr12","4931428L18Rik", "Nrp2", "4930487H11Rik", "Lypd1","AA619741", "1700066B17Rik", "Pantr1", "Pou3f3","Sbspon", "Gm17767", "Crygd", "A630001G21Rik","Fn1", "Apol7d", "Gm8883", "1700027A15Rik","A830018L16Rik", "Ogfrl1", "Gm3646", "Ramp1","Cd209c", "Cpa6", "Prex2", "A830018L16Rik","Plk5", "Rac2", "Mlc1", "Lta","Lyg2", "9930111H07Rik", "Mir128-1", "9330162B11Rik","Slc5a8", "Olfr769", "Olfr790", "Gm12130")
heatmapGS<- markerHeatmap(seMarker=markerGS, cutOff="FDR <= 0.001 & Log2FC >= 1.25",transpose=T, labelMarkers=gabaMarkers)
ComplexHeatmap::draw(heatmapGS, heatmap_legend_side='bot', annotation_legend_side="bot")
plotPDF(heatmapGS, name="MB201221_GABA_genescores.MarkerHeatmap.FDR_0.001", width = 16, height=6, ArchRProj=MB201221_GABA)
features<-list(GABAergicNeurons=c("Gad1","Gad2","Pvalb","Dlx1","Dlx2","Sst", "Vip", "Slc32A1", "Chodl", "Lamp5"),
GABA_Lamp5=c("Lamp5","Lhx6", "Ndnf", "GAD1"),
GABA_Sncg=c("Sncg", "Col19a1"),
GABA_Vip=c("Vip", "GAD1", "GAD2"),
GABA_Sst_Chodl=c("Sst", "Chodl"),
GABA_Sst=c("Sst", "Col19a1"), GABA_Pvalb=c("Pvalb", "GAD2", "GAD1", "Acsl3"))
MB201221_GABA<-addModuleScore(MB201221_GABA, features=features, useMatrix="GeneScoreMatrix")
gaba_embed<-plotEmbedding(MB201221_GABA, name="Module.GABAergicNeurons", imputeWeights=getImputeWeights(MB201221_GABA), embedding="UMAP_GABA")
plotPDF(gaba_embed, name="Module.GABAergicNeurons.pdf", ArchRProj=MB201221_GABA, addDOC=F, width=5, height=5)
gab_l5_embed<-plotEmbedding(MB201221_GABA, name="Module.GABA_Lamp5", imputeWeights=getImputeWeights(MB201221_GABA), embedding="UMAP_GABA")
plotPDF(gab_l5_embed, name="Module.GABA_Lamp5.pdf", ArchRProj=MB201221_GABA, addDOC=F, width=5, height=5)
gab_Sncg_embed<-plotEmbedding(MB201221_GABA, name="Module.GABA_Sncg", imputeWeights=getImputeWeights(MB201221_GABA), embedding="UMAP_GABA")
plotPDF(gab_Sncg_embed, name="Module.GABA_Sncg.pdf", ArchRProj=MB201221_GABA, addDOC=F, width=5, height=5)
gab_Vip_embed<-plotEmbedding(MB201221_GABA, name="Module.GABA_Vip", imputeWeights=getImputeWeights(MB201221_GABA), embedding="UMAP_GABA")
plotPDF(gab_Vip_embed, name="Module.GABA_Vip.pdf", ArchRProj=MB201221_GABA, addDOC=F, width=5, height=5)
gab_sstChodl_embed<-plotEmbedding(MB201221_GABA, 
                                name="Module.GABA_Sst_Chodl", 
                                imputeWeights=getImputeWeights(MB201221_GABA), 
                                embedding="UMAP_GABA")
plotPDF(gab_sstChodl_embed, 
        name="Module.GABA_Sst_Chodl.pdf", 
        ArchRProj=MB201221_GABA, 
        addDOC=F, 
        width=5, height=5)
gab_sst_embed<-plotEmbedding(MB201221_GABA, 
                            name="Module.GABA_Sst", 
                            imputeWeights=getImputeWeights(MB201221_GABA), 
                            embedding="UMAP_GABA")
plotPDF(gab_sst_embed, 
        name="Module.GABA_Sst.pdf", 
        ArchRProj=MB201221_GABA, 
        addDOC=F, 
        width=5, height=5)
gab_pvalb_embed<-plotEmbedding(MB201221_GABA, 
                                name="Module.GABA_Pvalb", 
                                imputeWeights=getImputeWeights(MB201221_GABA), 
                                embedding="UMAP_GABA")
plotPDF(gab_pvalb_embed, 
        name="Module.GABA_Pvalb.pdf", 
        ArchRProj=MB201221_GABA, 
        addDOC=F, 
        width=5, height=5)
newMarkers<-c("Gad1","Gad2","Pvalb","Dlx1","Dlx2","Sst", "Vip", "Slc32A1", "Chodl","Lamp5","Lhx6", "Ndnf","Sncg", "Acsl3")
p<-plotBrowserTrack(ArchRProj=MB201221_GABA, 
                    groupBy="Clusters_GABA", 
                    geneSymbol=newMarkers, 
                    upstream=50000, downstream=50000)
plotPDF(plotList=p, name="MB201221_GABAsubset.MarkerGenes.tracks.pdf", ArchRProj=MB201221, addDOC=F, width=5, height=5)
plotPDF(plotList=p, 
        name="MB201221_GABAsubset.MarkerGenes.tracks.pdf", 
        ArchRProj=MB201221_GABA, 
        addDOC=F, 
        width=5, height=5)
newMarkers<-c("Gad1","Gad2","Pvalb","Dlx1","Dlx2","Sst", "Vip", "Slc32A1", "Chodl","Lamp5","Lhx6", "Ndnf","Sncg", "Acsl3", "Xkr4", "Cpa6","Olfr1413","Il17a","Myo1b","Pi15", "Mir30c-2", "Lincmd1","Il18rap", "4931428L18Rik", "AA619741","Sbspon", "Fn1", "A830018L16Rik", "Cd209c", "Plk5", "Lyg2", "Slc5a8")
p<-plotBrowserTrack(ArchRProj=MB201221_GABA, 
                            groupBy="Clusters_GABA", 
                            geneSymbol=newMarkers, 
                            upstream=50000, downstream=50000)
plotPDF(plotList=p, name="MB201221_GABAsubset.MarkerGenes.tracks.pdf", ArchRProj=MB201221_GABA, addDOC=F, width=5, height=5)
MB201221_GABA<-saveArchRProject(ArchRProj=MB201221_GABA)
#seRNA <-readRDS("allen_brainspan_mouse.rds")
#small_seRNA <- seRNA[, sample(colnames(seRNA), size=10000, replace=F)] #Going to make a 10,000 cell version of this for memory reasons.
# saveRDS(small_seRNA, "small_brainspan.rds")
# rm(seRNA)
# gc() #Run these to save the 30GB+ that the large dataset takes
small_seRNA<-readRDS("small_brainspan.rds")
table(small_seRNA$subclass_label) # Probably the one we want to use for  most things. class_label is GABA, Glut, non-neuronal only
MB201221_GABA<-addGeneIntegrationMatrix(ArchRProj=MB201221_GABA, 
                                            useMatrix="GeneScoreMatrix", 
                                            matrixName="GeneIntegrationMatrix", 
                                            reducedDims="IterativeLSI_GABAsubset", 
                                            seRNA=small_seRNA, 
                                            addToArrow=T, 
                                            groupRNA="subclass_label",
                                            nameCell = "predictedCell",
                                            nameGroup = "predictedGroup",
                                            nameScore = "predictedScore")
cM<-confusionMatrix(MB201221_GABA$Clusters_GABA, MB201221_GABA$predictedGroup)
labelOld<-rowNames(cM)
labelNew<-colnames(cM)[apply(cM, 1, which.max)]
MB201221_GABA$Clusters_GABA2<-mapLabels(MB201221_GABA$Clusters_GABA, 
                                        newLabels=labelNew, 
                                        oldLabels=labelOld)
MB201221_GABA<-addGroupCoverages(ArchRProj=MB201221_GABA, groupBy="Clusters_GABA2")
### Warning, the above uses a crap-pile of memory
### Probably want to save here just in case.
pathToMacs2 <- findMacs2()

MB201221_GABA<-addReproduciblePeakSet(ArchRProj = MB201221_GABA, groupBy="Clusters_GABA2", pathToMacs2=pathToMacs2, threads=2)
#Midbrain dopamine neuron (mDA) pitx3 https://doi.org/10.1038/s41467-019-08453-1
# Corticospinal neuron L1CAM https://doi.org/10.3389/fncel.2020.00031
# Hippocampus markers Ebpl HMGCR (may not care about these)
MB201221_GABA<-addPeakMatrix(MB201221_GABA)
MB201221_GABA<-addCoAccessibility(ArchRProj=MB201221_GABA, reducedDims="IterativeLSI_GABAsubset")
cA<-getCoAccessibility(ArchRProj=MB201221_GABA, corCutOff=0.5, resolution=1, returnLoops=F)
