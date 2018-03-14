%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trial Averaging, Dose response Curves, and Non-Linear regression
% Ben Hoffman
% 08.25.16
%
% Aggregate Trials, perform statistics
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Dynamic_agg, Static_agg ] = aggregate_trials( Dynamic, Static )
Dynamic_agg = grpstats(Dynamic,'Round_Corr_D','mean');
Dynamic_std = grpstats(Dynamic,'Round_Corr_D','std', 'DataVars','Peak_IFF');
std_Peak_IFF = Dynamic_std.std_Peak_IFF;
Dynamic_std = table(std_Peak_IFF);
Dynamic_agg = [Dynamic_agg Dynamic_std];

Static_agg = grpstats(Static,'Round_Corr_D','mean');
Static_std = grpstats(Static,'Round_Corr_D','std', 'DataVars','Mean_IFF');
std_Mean_IFF = Static_std.std_Mean_IFF;
Static_std = table(std_Mean_IFF);
Static_agg = [Static_agg Static_std];
end

