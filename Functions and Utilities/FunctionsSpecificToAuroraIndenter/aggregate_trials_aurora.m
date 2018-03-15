%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trial Averaging, Dose response Curves, and Non-Linear regression
% Ben Hoffman
% 08.25.16
%
% Aggregate Trials, perform statistics
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Dynamic_agg, Total_agg ] = aggregate_trials_aurora( Dynamic, Total )
Dynamic_agg = grpstats(Dynamic,'Round_Corr_F','mean');
Dynamic_std = grpstats(Dynamic,'Round_Corr_F','std', 'DataVars','Peak_IFF');
std_Peak_IFF = Dynamic_std.std_Peak_IFF;
Dynamic_std = table(std_Peak_IFF);
Dynamic_agg = [Dynamic_agg Dynamic_std];

Total_agg = grpstats(Total,'Round_Corr_F','mean');
Total_std = grpstats(Total,'Round_Corr_F','std', 'DataVars','Mean_IFF');
std_Mean_IFF = Total_std.std_Mean_IFF;
Total_std = table(std_Mean_IFF);
Total_agg = [Total_agg Total_std];
end

