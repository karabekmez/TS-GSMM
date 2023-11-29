# TS-GSMM
Time Series Genome Scale Metabolic Models

STEP 1: Prepare inputs

Dependencies:    
* COBRA Toolbox (https://github.com/opencobra/cobratoolbox)
  
Inputs (for each time point):
* model (Genome Scale Metabolic Model (GSMM) that includes Gene-Protein-Reaction (GPR) rules and its reaction bounds should be numeric)
* gene_expression
(gene_expression structure has two components: gene_expression.gene is a cell array containing GeneIDs in the same format as model.genes and gene_expression.value is a vector containing corresponding expression values. Gene expression values can be count data (RPKM/FPKM/TPM) or microarray data (without log2 normalization). The model must have model.rules section. Loading models from .mat files may lead model.grRules section which carry the same information in a different format. To get model.rules properly it is recommended to load the models from .xml files)

Implementation (for each time point):

          reaction_expression= mapExpressionToReactions(model, gene_expression);

Outputs (for each time point):
* reaction_expression (Gene expression data mapped on the GSMM)

STEP 2: Integrate Transcriptomics with the GSMM

Dependencies:
* COBRA Toolbox (https://github.com/opencobra/cobratoolbox)
* fE-Flux (https://github.com/karabekmez/fE-Flux)
  
Inputs (for each time point):
* model (GSMM)
* reaction_expression (obtained in Step 1)
       
Outputs (for each time point): 
* model_Ti (time point spesific GSMM for t(i) whose upper and lower bounds were manipulated via fE-Flux) 


STEP 3: Sampling

Dependencies:
* COBRA Toolbox (https://github.com/opencobra/cobratoolbox)

Inputs (for each time point):
* model_Ti (time point specific GSMM)

Implementation 

        [modelSampling_Ti, samples_Ti] = sampleCbModel(model_Ti,'samples_Ti','ACHR', 'modelSampling_Ti');

* merge all samples_Ti's

Output: 
* SEF_N (3D array (reactions, samples, time points))
  
STEP 4: Clustering flux distributions

Dependencies:
* COBRA Toolbox (https://github.com/opencobra/cobratoolbox)
* Wasserstein distance (https://github.com/nklb/wasserstein-distance)

Inputs:
* samples_Ti (time point specific samplings of the GSMMs)

Implementation 
* run wasdis (creates between time series dissimilarity matrices to cluster flux distribution levels)
* run createWTSD (creates within time series dissimilarity matrices to cluster flux profiles)
* Calinski-Harabasz clustering evaluation criterion (CH index) and/or silhouette scores can be used to determine number of clusters (m or k)
  
        evalclusters(DD);
        evalclusters(WTSDD);
        [ind_ts_level]=kmedoids(DD,m);
        [ind_ts_profile]=kmedoids(WTSDD,k);
        
Outputs: 
* ind_ts_level (index of cluster for each reaction - clustering ts level)
* ind_ts_profile (index of cluster for each reaction - clustering ts trend)
