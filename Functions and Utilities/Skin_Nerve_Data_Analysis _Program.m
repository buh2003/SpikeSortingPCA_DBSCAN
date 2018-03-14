%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 06.08.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -------- Set figure title names and dock all figures
dataName = ['042716 37 Rleg leg2 Trial1']; % add file Name!
set(0,'DefaultFigureWindowStyle','docked')
%% -------- Step 1: Prepare Data
%  -------- Step 1-1: Split Response, Force and Displacement data
Allraw = initialprocess_SNP(data,3);
%  -------- Step 1-2: Cut data, set start point, make short data files
cutpoints = Disp_cutpoint_SNP(Allraw,0.1,2,200000); %find time points when indentation starts
All_short = short_data_file_SNP(Allraw, cutpoints, 20000, 180000); %cut data @ time before and after indentation starts; baseline correct response data
title(dataName)
%savefig([dataName 'ALL']);
%% -------- Step 2: Define target peak shape
%  -------- Step 2-1: Set Bandpass for Spike Peaks
[Spike_Train, Spike_Shape] = Spike_Bandpass_SNP(All_short, 800, 100, 48); % ENTER PEAK BANDPASS
%  -------- Step 2-2: Curve Smoothing
Spike_Shape_Smoothed = Curve_smoothing_SNP(Spike_Shape, 1, 60, 1);
Spike_Shape_Recentered = Recenter_Peaks_SNP(Spike_Shape_Smoothed, 1, 60, 12);
%% -------- Step 3: Spike Sort
%  -------- Step 3-1: Set local bandpass for spike sorting
Bandpass_points = [6 100 -60; 12 520 360; 20 -70 -270; 22 -120 -400; 25 -240 -380]; % ENTER BANDPASS POINTS
%  -------- Step 3-2: Spike Sort by local bandpass
Spikes_Sorted = Discriminate_Spikes_SNP(Spike_Shape_Recentered, Bandpass_points);
Spikes_Sorted_Clean = Eliminate_Overlapping_SNP(Spikes_Sorted, 62, 20,63,-1); % Eliminates multiunit spikes that are extremely close together
%  -------- Step 3-3: Sort spikes against average shape
Average_spike_shape = Sorted_average_shape(Spikes_Sorted_Clean);
Final_Sort = Sort_against_average(Average_spike_shape, Spikes_Sorted_Clean, 0.85); % Number here is Pearsons Correlation Coefficient, higher is more stringent
[Extracted_Spikes, Show_Spike_Train] = Extract_Sorted_Spikes(Spike_Train, Final_Sort);
%% -------- Step 4: Data Analysis
%  -------- Step 4-1: Reduce spike train file size; plot R,F,D and Raster
[Output_R, Output_F, Output_D, Output_R_boolean] = Reduce_Spike_Train(All_short, Show_Spike_Train);
Summary_Plot(Output_R, Output_F, Output_D, Output_R_boolean, dataName);

