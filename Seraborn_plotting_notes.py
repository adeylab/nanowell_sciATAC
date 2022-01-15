### Seaborn stuff, requires seaborn to be installed

import seaborn as sns
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

######################### 
##########NOTES:#########
#########################
"""
1. Probably want to incorporate some published sci-ATAC datasets from our lab in the figures
2. Figures to make:
	1. Num Unique reads
		- based on complexity.txt files, I guess. 
		- log scale Y-axis
	2. FRIP
		- use frac on target.values probably for most things
		
	3. Histogram of cells per prep passing filter
		- use annot file?
	4. Projected complexity
		- not sure how to do this one.
"""

######################Parse in complexity files as data frames, then plot####################################
### read in individual complexity.txt files into data frames
MB201106=pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/201106_MouseBrain/201115_NovaSeq_iCell8_12.mm10.merged.complexity.txt", header=None, names=['Number', 'Barcode', 'TotalReads', 'UniqueRead','PercentUnique'])
GM190719=pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/GM12878/190719_22_25_HI_Takara1.complexity.txt", header=None, names=['Number', 'Barcode', 'TotalReads', 'UniqueRead','PercentUnique'])
MB200107=pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/200107_Mouse_Brain_Analysis/All.merged.complexity.txt", header=None, names=['Number', 'Barcode', 'TotalReads', 'UniqueRead','PercentUnique'])
MB201221=pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/201221_MouseBrain_scaleATAC/201221_MouseBrain_scaleATAC.mm10.complexity.txt",header=None, names=['Number', 'Barcode', 'TotalReads', 'UniqueRead','PercentUnique'])

SpatialWB_complexity=pd.read_table("/home/groups/oroaklab/adey_lab/projects/spatial/wholebrain/wholebrain.complexity.txt",header=None,  names=['Number', 'Barcode', 'TotalReads', 'UniqueRead','PercentUnique'])

### Combine individual data-frames, and make experiment a categorical column
result=pd.concat([SpatialWB_complexity,MB201106,GM190719,MB200107,MB201221], keys=["Thornton et al. sci-ATAC", "MB201106_sciATACn","GM190719_sciATACn", "MB200107_sciATACn", "MB201221_scaleATACn"],names=['Experiment', 'Row ID'])
result.reset_index(inplace=True, level = ['Experiment'])



### Set Y-limits to 50-100
# plt.ylim(50, 100)

### Plot percent unique by experiment as violin plot and save figure
# plot=sns.catplot(x="Experiment", y="PercentUnique", kind='box', data=result,order=["GM190719_sciATACn","MB200107_sciATACn","MB201106_sciATACn", "MB201221_scaleATACn"], showfilers=False)
# plot.savefig("test_complexity_violinplot.png")
### Better version
plot=sns.catplot(x="Experiment", y="PercentUnique", kind='box', data=result,order=["Thornton et al. sci-ATAC", "GM190719_sciATACn","MB200107_sciATACn","MB201106_sciATACn", "MB201221_scaleATACn"], showfliers = False)

### Set rotation of x labels
plt.xticks(
	rotation=45,
	horizontalalignment='right')

plot.savefig("Combined.PercentUnique.pdf")

log10_unique=sns.catplot(x="Experiment", y="UniqueRead", kind="box", data=result, order=["Thornton et al. sci-ATAC", "GM190719_sciATACn","MB200107_sciATACn","MB201106_sciATACn", "MB201221_scaleATACn"], showfliers = False)

plt.xticks(
	rotation=45,
	horizontalalignment='right')
plt.yscale("log")
log10_unique.savefig("Combined.Log10Unique.pdf")



################################################################
### Filter results based on number of unique reads per cell. ###
################################################################
tmp = result.loc[((result["UniqueRead"]>=1000) &((result["Experiment"]=="Thornton et al. sci-ATAC")|(result["Experiment"]=="GM190719_sciATACn")))|((result["UniqueRead"]>=80000) &(result["Experiment"]=="MB201221_scaleATACn"))|((result["UniqueRead"]>=1000) &(result["Experiment"]=="MB200107_sciATACn") &(result["PercentUnique"]<=80.0)) |((result["Experiment"]=="MB201106_sciATACn")&(result["UniqueRead"]>=3000))]

log10_unique=sns.catplot(x="Experiment", y="UniqueRead", kind="box", data=tmp, order=["Thornton et al. sci-ATAC", "GM190719_sciATACn","MB200107_sciATACn","MB201106_sciATACn", "MB201221_scaleATACn"], showfliers = False)

plt.xticks(
	rotation=45,
	horizontalalignment='right')
plt.yscale("log")
log10_unique.savefig("Combined.Log10Unique.filt.pdf")

### Cells Pass Filter plot
cells_pf = sns.catplot(x="Experiment", data=tmp, kind="count",order=["Thornton et al. sci-ATAC", "GM190719_sciATACn","MB200107_sciATACn","MB201106_sciATACn", "MB201221_scaleATACn"])
plt.xticks(
	rotation=45,
	horizontalalignment='right')
# plt.ylim(0, 1000000)
plt.yscale("log")

cells_pf.savefig("Combined.CellsPF.filt.pdf")

pc_unique=sns.catplot(x="Experiment", y="PercentUnique", kind='box', data=tmp,order=["Thornton et al. sci-ATAC", "GM190719_sciATACn","MB200107_sciATACn","MB201106_sciATACn", "MB201221_scaleATACn"], showfliers = False)

### Set rotation of x labels
plt.xticks(
	rotation=45,
	horizontalalignment='right')

pc_unique.savefig("Combined.PercentUnique.filt.pdf")
### Save to file
# result.to_pickle("./combined_complexity.pkl")
## Can reload with
# result = pd.load_pickle("./combined_complexity.pkl")





#################################################################################################################
################ Plot frip as boxplot

MB201106_frip=pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/201106_MouseBrain/201115_NovaSeq_iCell8_12.mm10.merged.bbrd.q10.500.fracOnTarget.values", header=None, names=['Barcode', 'FRIP'])
GM190719_frip=pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/GM12878/190719_22_25_HI_Takara1.bbrd.q10.filt.500.fracOnTarget.values", header=None, names=['Barcode', 'FRIP'])
MB200107_frip=pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/200107_Mouse_Brain_Analysis/All.merged.bbrd.q10.iSwitch_scrubbed.500.fracOnTarget.values", header=None, names=['Barcode', 'FRIP'])
MB201221_frip=pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/201221_MouseBrain_scaleATAC/201221_MouseBrain_scaleATAC.mm10.bbrd.q10.own_peaks.fracOnTarget.values",header=None, names=['Barcode', 'FRIP'])
SpatialWB_frip=pd.read_table("/home/groups/oroaklab/adey_lab/projects/spatial/wholebrain/wholebrain.bbrd.q10.filt.500.fracOnTarget.values",header=None, names=['Barcode', 'FRIP'])

combinedFrip= pd.concat([MB201106_frip,GM190719_frip,MB200107_frip, MB201221_frip, SpatialWB_frip],keys=["MB201106 sci-ATACn","GM190719 sci-ATACn", "MB200107 sci-ATACn", "MB201221 scale-ATACn", "Thornton et al. sci-ATAC"],names=['Experiment', 'Row ID'])
combinedFrip.reset_index(inplace=True, level = ['Experiment'])
FRIP=sns.catplot(x="Experiment", y="FRIP", kind='box', data=combinedFrip, flierprops = dict(markerfacecolor = '0.50', markersize = 2), order=["Thornton et al. sci-ATAC", "GM190719 sci-ATACn","MB200107 sci-ATACn","MB201106 sci-ATACn", "MB201221 scale-ATACn"]) ###Can also use showfliers = False
plt.xticks(
	rotation=45,
	horizontalalignment='right')
FRIP.savefig("Combined.FRIP.pdf")



#######################
"""
Making a clusters by modules heatmap
"""


test = pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/201106_MouseBrain/MB200107/scaleMB_umap.dims", sep=' ')
test2 = pd.read_table("/home/groups/oroaklab/adey_lab/projects/Takara/201106_MouseBrain/MB200107/scaleMB_data.tsv")

joinedData = test.join(test2)
joinedData.columns
"""Index(['IterativeLSI_v1#UMAP_Dimension_1', 'IterativeLSI_v1#UMAP_Dimension_2',
       'Sample', 'TSSEnrichment', 'ReadsInTSS', 'ReadsInPromoter',
       'ReadsInBlacklist', 'PromoterRatio', 'PassQC', 'NucleosomeRatio',
       'nMultiFrags', 'nMonoFrags', 'nFrags', 'nDiFrags', 'BlacklistRatio',
       'Clusters', 'Clusters_v2', 'Module.OligOPC', 'Module.Endothelia',
       'Module.Astrocytes', 'Module.Microglia', 'Module.GlutamatergicNeurons',
       'Module.GABAergicNeurons', 'Module.OPC', 'Module.VLMC',
       'Module.GABA_Lamp5', 'Module.GABA_Sncg', 'Module.GABA_Vip',
       'Module.GABA_Sst_Chodl', 'Module.GABA_Sst', 'Module.GABA_Pvalb',
       'Module.Glu_L4_5_IT_CTX', 'Module.Glu_L6_IT_CTX',
       'Module.Glu_L5_PT_CTX'],
      dtype='object')
"""
### Group by clusters, take the mean of each columm/cluster values
grouped=joinedData.groupby('Clusters').mean()
groupedModules=grouped[['Module.OligOPC',
        'Module.Endothelia', 'Module.Astrocytes', 'Module.Microglia',
        'Module.GlutamatergicNeurons', 'Module.GABAergicNeurons', 'Module.OPC',
        'Module.VLMC', 'Module.GABA_Lamp5', 'Module.GABA_Sncg',
        'Module.GABA_Vip', 'Module.GABA_Sst_Chodl', 'Module.GABA_Sst',
        'Module.GABA_Pvalb', 'Module.Glu_L4_5_IT_CTX', 'Module.Glu_L6_IT_CTX',
        'Module.Glu_L5_PT_CTX']]
g=sns.clustermap(groupedModules, vmin=0, vmax=1.0, metric="correlation", cmap="coolwarm",standard_scale=1)
g.savefig("test_scaleMB.clustermap_standardized.pdf")
g=sns.clustermap(groupedModules, vmin=0, vmax=1.0, metric="correlation", cmap="coolwarm")
g.savefig("test_scaleMB.clustermap.pdf")

#Try alternate clustering
groupedV2=joinedData.groupby('Clusters_v2').mean()
groupedModulesV2=groupedV2[['Module.OligOPC',
        'Module.Endothelia', 'Module.Astrocytes', 'Module.Microglia',
        'Module.GlutamatergicNeurons', 'Module.GABAergicNeurons', 'Module.OPC',
        'Module.VLMC', 'Module.GABA_Lamp5', 'Module.GABA_Sncg',
        'Module.GABA_Vip', 'Module.GABA_Sst_Chodl', 'Module.GABA_Sst',
        'Module.GABA_Pvalb', 'Module.Glu_L4_5_IT_CTX', 'Module.Glu_L6_IT_CTX',
        'Module.Glu_L5_PT_CTX']]
g=sns.clustermap(groupedModulesV2, vmin=0, vmax=1.0, metric="correlation", cmap="coolwarm",standard_scale=1)
g.savefig("201221_scaleATACn_MB_CellID.v2..clustermap_standardized.pdf")
g=sns.clustermap(groupedModulesV2, vmin=0, vmax=1.0, metric="correlation", cmap="coolwarm")
g.savefig("201221_scaleATACn_MB_CellID.v2.clustermap.pdf")
########################