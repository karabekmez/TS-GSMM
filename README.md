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
       
Outputs (for each time point): 
* samples_Ti (flux distribution of sampled 2000 points (default) for each reaction) 
