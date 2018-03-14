function [ Spike_Train, Spikes_Sorted ] = electrical_stimulation(data, Extracted_Spikes, epsilon, dataName)
%% -------- Step 1: Prepare Data
%  -------- Step 1-1: Split Response, Force and Displacement data
Allraw = initialprocess_SNP(data,3);
Allraw.Response = ((Allraw.Response - (mean(Allraw.Response(1:10000))))*1000);
%  -------- Step 1-2: Cut data, set start point, make short data files
%savefig([dataName 'ALL']);
%% -------- Step 2: Define target peak shape
%  -------- Step 2-1: Set Bandpass for Spike Peaks
Max = max(max(Extracted_Spikes(1:60,:)))*1.35;
Min = max(max(Extracted_Spikes(1:60,:)))*0.5;
[Spike_Train, Spike_Shape] = Spike_Bandpass_SNP(Allraw, Max, 40, 48); % ENTER PEAK BANDPASS
%  -------- Step 2-2: Curve Smoothing
Spike_Shape_Smoothed = Curve_smoothing_SNP(Spike_Shape, 1, 60, 1);
Spike_Shape_Recentered = Recenter_Peaks_SNP(Spike_Shape_Smoothed, 1, 60, 12);
%% -------- Step 3: Spike Sort
%  -------- Step 3-1: Perform PCA on spikes
[PCA_weights, PCA_variable, latent] = pca(Spike_Shape_Recentered(1:32,:));
figure; plot(latent, 'ro');
% -------- 3-2: Perform DBSCAN clustering
idx = DBSCAN(PCA_weights(:,1:2),epsilon,2); % (PCA1 and PCA2, epsilon, minimum spikes per cluster)  
Spikes_Sorted = [Spike_Shape_Recentered(1:62,:); idx'];
% -------- 3-3: Sorting Summary Plot
PCA_DBSCAN_Summary(Allraw.Response, Allraw.Displacement, Spike_Shape_Recentered,...
    PCA_weights, Spikes_Sorted, idx, dataName);
%savefig([dataName ' PCA_DBSCAN']);
end

