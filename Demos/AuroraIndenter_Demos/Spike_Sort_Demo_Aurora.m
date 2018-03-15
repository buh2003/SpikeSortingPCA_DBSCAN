%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Spike Sorting and Data Analysis
% Ben Hoffman
% 08.09.16
%
% With PCA and DBSCAN sorting
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -------- Set figure title names and dock all figures
dataName = 'AuroraIndenter_DemoData'; % add file Name!
set(0,'DefaultFigureWindowStyle','docked')
%% -------- Step 1: Prepare Data
%  -------- Step 1-1: Split Response, Force and Displacement data
Allraw = initialprocess_SNP(data,3);
%  -------- Step 1-2: Filter Force Trace
d = designfilt('lowpassiir','FilterOrder',1,'PassbandFrequency',20,'PassbandRipple',.1,'SampleRate',20000);
Allraw.Force = filtfilt(d,Allraw.Force);
%  -------- Step 1-3: Cut data, set start point, make short data files
cutpoints = Force_cutpoint_SNP(Allraw,0.0025,2,200000); %find time points when indentation starts
All_short = short_data_file_SNP_aurora(Allraw, cutpoints, 20000, 180000); %cut data @ time before and after indentation starts; baseline correct response data
title(dataName)
savefig([dataName 'ALL' '.fig']);
%% -------- Step 2: Define target peak shape
%  -------- Step 2-1: Set Bandpass for Spike Peaks
[Spike_Train, Spike_Shape] = Spike_Bandpass_SNP(All_short, 1000, 50, 48); % ENTER PEAK BANDPASS
%  -------- Step 2-2: Curve Smoothing
Spike_Shape_Smoothed = Curve_smoothing_SNP(Spike_Shape, 1, 60, 1);
Spike_Shape_Recentered = Recenter_Peaks_SNP(Spike_Shape_Smoothed, 1, 60, 12);
%% -------- Step 3: Spike Sort
%  -------- Step 3-1: Perform PCA on spikes
[PCA_weights, PCA_variable, latent] = pca(Spike_Shape_Recentered(1:40,:));
figure; plot(latent, 'ro');
% -------- 3-2: Perform DBSCAN clustering
idx = DBSCAN(PCA_weights(:,1:2),0.01,3); % (PCA1 and PCA2, epsilon, minimum spikes per cluster)  
Spikes_Sorted = [Spike_Shape_Recentered(1:62,:); idx'];
% -------- 3-3: Sorting Summary Plot
PCA_DBSCAN_Summary(All_short.Response, All_short.Displacement, Spike_Shape_Recentered,...
    PCA_weights, Spikes_Sorted, idx, dataName);
%savefig([dataName ' PCA_DBSCAN' '.fig']);
%% -------- Step 4: Extract Cluster of Spikes
Cluster_Num = 2; % ENTER CLUSTER TO EXTRACT
[Extracted_Spikes, Show_Spike_Train] = Extract_Sorted_Spikes_PCA_DBSCAN(Spike_Train, Spikes_Sorted,Cluster_Num); 
%% -------- Step 5: Compare to Electrical Stimulation
%%%%%% !!!!!!!! FIRST LOAD IN the 'data' variable from the electrical stimulation file !!!!!! %%%%%%%%
[Elec_Spike_Train, Elec_Spikes_Sorted] = electrical_stimulation(data,Extracted_Spikes, 0.04, dataName); %enter epsilon value
%% ------- 5-1: Compare to Electrical Stimulation
Cluster_Num = 2; % ENTER CLUSTER TO EXTRACT
[Elec_Extracted_Spikes, Elec_Show_Spike_Train] = Extract_Sorted_Spikes_PCA_DBSCAN(Elec_Spike_Train,...
    Elec_Spikes_Sorted,Cluster_Num); 
% -------- 5-2: Compare evoked spikes to electrically evoked spikes
figure; plot(Extracted_Spikes(1:60,:),'b'); hold on; plot(Elec_Extracted_Spikes(1:60,:),'r');
%savefig([dataName ' electricalComp' '.fig']);
%% -------- Step 6: Data Analysis
%  -------- Step 6-1: Reduce spike train file size; plot R,F,D and Raster
[Output_R, Output_F, Output_D, Output_R_boolean] = Reduce_Spike_Train_aurora(All_short, Show_Spike_Train, 20000);
Summary_Plot_aurora(Output_R, Output_F, Output_D, Output_R_boolean, dataName, Cluster_Num);
savefig([dataName ' Summary' '.fig']);
%  -------- Step 6-2: Measure Force/Distance trace inflection points
[Mags_D, Mags_F] = Measure_Stim_Magnitude(Output_D, Output_F, 1, 10000, 42000, 52000);
d = designfilt('lowpassiir','FilterOrder',1,'PassbandFrequency',20,'PassbandRipple',.1,'SampleRate',20000);
Output_F_filt = filtfilt(d,Output_F);
Disp_points = Displacement_inflections_aurora(Output_F_filt, 1, 10000, 60000, 80000);
%  -------- Step 6-3: Generate ISI file
[IFF_out, IFF_no_zero_out, rISI_ALL, rISI_DETAIL] = Data_analysis(Output_R_boolean, Disp_points, 20000);
[ALL_ISI_OF,StimPhase_ISI_OF,Dynamic_ISI_OF,Late_Static_ISI_OF, End_ISI_OF] = ISI_output_file_aurora(Mags_D, Mags_F, rISI_ALL);
IFF_plot(IFF_out,150);
savefig([dataName ' IFF' '.fig']);
%  -------- Step 6-4: Measure latency to spike
latencies=latencytospike(Disp_points, Output_R_boolean, 20000);
%% -------- Step 7: Save data to .xlsx
% Choose Mac or PC script
% For Mac
save_file_mac_aurora(ALL_ISI_OF,StimPhase_ISI_OF,Dynamic_ISI_OF,Late_Static_ISI_OF, End_ISI_OF, Disp_points,latencies, dataName);
% For PC
%save_file_windows_aurora(ALL_ISI_OF,StimPhase_ISI_OF,Dynamic_ISI_OF,Late_Static_ISI_OF, End_ISI_OF, Disp_points,latencies, dataName);




