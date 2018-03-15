# SpikeSortingPCA_DBSCAN
Spike sorting implemented with principal component analysis (PCA) and density-based spatial clustering of applications with noise (DBSCAN) for extracellular differential electrode recordings. Primary functionality is analyzing mechanical stimulation experiments, but can be adapted for any type of experiment.

IMPORTANT: Tested on Matlab R2017b

IMPORTANT: The following Matlab Toolboxes are required:

Bioinformatics Toolbox, Statistics and Machine Learning Toolbox, Signal Processing Toolbox, Curve Fitting Toolbox,



# Software designed to handle raw data formats exported to Matlab format from Labchart software.

IMPORTANT: Export data in the following order: Raw trace, Force Trace, Displacement Trace.

IMPORTANT: Select demo based on indenter used (GerlingIndenter, AuroraIndenter)


# Demos are provided for each indenter (Aurora Indenter or Gerling Indenter):

AURORA INDENTER

1) Spike_Sort_Demo_Aurora # Start here. This demo takes you through raw data processing, spike sorting, and data analysis

2.1) TrialAveraging_Demo_DynamicStatic_Aurora # Use this demo next if you want to compare Dynamic and Static Firing Rates (skip if not)

2.2) TrialAveraging_Demo_meanFiringRate_Aurora # Use this demo instead if you want to analyze Mean Firing Rate (skip if not)

3) SummaryFigureDemo_ForAurora # Use this demo to make a figure quality summary figure

GERLING INDENTER

1) Spike_Sort_Demo_GerlingIndenter # Start here. This demo takes you through raw data processing, spike sorting, and data analysis

2) TrialAveraging_Demo_4PLfit_GerlingIndenter # Use this demo next if you want to compare Dynamic and Static Firing Rates

3) Summary_Figure_Demo_GerlingIndenter # Use this demo to make a figure quality summary figure
