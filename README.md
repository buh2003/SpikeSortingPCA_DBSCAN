# SpikeSortingPCA_DBSCAN
Spike sorting implemented with principal component analysis (PCA) and density-based spatial clustering of applications with noise (DBSCAN) for extracellular differential electrode recordings. The primary functionality of this software package is for analyzing mechanical stimulation experiments, but it can be adapted for any type of experimental protocol.

IMPORTANT: Tested on Matlab R2017b

IMPORTANT: The following Matlab Toolboxes are required:

Bioinformatics Toolbox, Statistics and Machine Learning Toolbox, Signal Processing Toolbox, Curve Fitting Toolbox,



## The software is designed to handle raw data formats exported to Matlab from Labchart software.

IMPORTANT: Currently only supports data aquired with a 20 kHz sampling rate.

IMPORTANT: Export data in the following order: Raw trace, Force Trace, Displacement Trace.

IMPORTANT: Select demo based on indenter used (GerlingIndenter, AuroraIndenter)


## Demos are provided for each indenter (Aurora Indenter or Gerling Indenter):

### AURORA INDENTER

1) Spike_Sort_Demo_Aurora # Start here. This demo takes you through raw data processing, spike sorting, and data analysis

    - Try with GerlingIndenter Demo Data. Process each trial data individually, then combine in the below 'Trial Averaging Demo'
        
    - To load data simply load Demo Data into Matlab workspace. The variable with raw data is called "data".

2) Trial Averaging Demos (2 implemented for Aurora):

    - TrialAveraging_Demo_DynamicStatic_Aurora # Use this demo next if you want to compare Dynamic and Static Firing Rates (skip if not)
    
    - TrialAveraging_Demo_meanFiringRate_Aurora # Use this demo instead if you want to analyze Mean Firing Rate (skip if not)

3) SummaryFigureDemo_ForAurora # Use this demo to make a figure quality summary figure

### GERLING INDENTER

1) Spike_Sort_Demo_GerlingIndenter # Start here. This demo takes you through raw data processing, spike sorting, and data analysis

    - Try with GerlingIndenter Demo Data. Process each trial data individually, then combine in the below 'Trial Averaging Demo'
        
    - To load data simply load Demo Data into Matlab workspace. The variable with raw data is called "data".

2) TrialAveraging_Demo_4PLfit_GerlingIndenter # Use this demo next if you want to compare Dynamic and Static Firing Rates

3) Summary_Figure_Demo_GerlingIndenter # Use this demo to make a figure quality summary figure

# Authors:
- Benjamin Uri Hoffman, Columbia University
- Ellen A. Lumpkin, Columbia University

# Citation:

Hoffman, Benjamin U. & Lumpkin, Ellen A. (2018, March 20). buh2003/SpikeSortingPCA_DBSCAN: SpikeSortingPCA_DBSCAN v1.0.0 (Version v1.0.0). Zenodo. http://doi.org/10.5281/zenodo.1204652

# License:

MIT License

Copyright (c) 2018 buh2003 (Benjamin U. Hoffman)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


