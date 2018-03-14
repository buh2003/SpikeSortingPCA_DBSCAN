%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trial Averaging, Dose response Curves, and Non-Linear regression
% Ben Hoffman
% 08.24.16
%
% Generate IFF values
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Dynamic, Static ] = generate_IFF( Dynamic, Static)
Peak_IFF = 1000./Dynamic.Min_ISI;
Peak_IFF(isinf(Peak_IFF)) = 0; % Replace INF with 0
Peak_IFF = table(Peak_IFF);
Dynamic = [Dynamic Peak_IFF];

Mean_IFF = 1000./Static.Mean_ISI;
Mean_IFF(isinf(Mean_IFF)) = 0; % Replace INF with 0
Mean_IFF = table(Mean_IFF);
Static = [Static Mean_IFF];
end

