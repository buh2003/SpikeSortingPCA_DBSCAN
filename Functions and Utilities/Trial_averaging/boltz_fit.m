%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trial Averaging, Dose response Curves, and Non-Linear regression
% Ben Hoffman
% 08.25.16
%
% Perform Boltz fit
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Dynamic_IFF_fit, Dynamic_gof, Static_IFF_fit, Static_gof ] = boltz_fit( Dynamic_agg, Static_agg, dataName )

%Define the boltz equation (a: slope, b: Lower, c:Upper, d:X50)
boltz_eq = fittype('((c-b)/(1+exp((d-x)/a))+b)','dependent',{'y'},...
    'independent',{'x'},'problem',{'b'}); % b is fixed as a problem

%Boltz fit for Dynamic
x = Dynamic_agg.Round_Corr_D;
y = Dynamic_agg.mean_Peak_IFF;
options = fitoptions(boltz_eq);
start_d = median(x); % starting value for X50 is the median displacement
start_c = median(y); % starting value for Upper is the median IFF
options.StartPoint = [1,start_c,start_d]; % Set start points, slope start is 1
[Dynamic_IFF_fit,Dynamic_gof] = fit(x,y,boltz_eq,options,'problem',0); % Fit to equation, fix lower at 0

%Boltz fit for Static
x = Static_agg.Round_Corr_D;
y = Static_agg.mean_Mean_IFF;
options = fitoptions(boltz_eq);
start_d = median(x);
start_c = median(y);
options.StartPoint = [1,start_c,start_d];
[Static_IFF_fit,Static_gof] = fit(x,y,boltz_eq,options,'problem',0);

%Plotting
figure;
ax = gca;
hold on
%Dynamic Data
Dy_error = errorbar(Dynamic_agg.Round_Corr_D, Dynamic_agg.mean_Peak_IFF, Dynamic_agg.std_Peak_IFF);
Dy_error.LineStyle = 'none'; Dy_error.Marker = '.'; Dy_error.MarkerSize = 15; 
Dy_error.Color= [0.059, 0.6, 0.698]; Dy_error.MarkerEdgeColor= [0.059, 0.6, 0.698]; 
Dy_error.MarkerFaceColor= [0.059, 0.6, 0.698];

%Static Data
St_error = errorbar(Static_agg.Round_Corr_D, Static_agg.mean_Mean_IFF, Static_agg.std_Mean_IFF);
St_error.LineStyle = 'none'; St_error.Marker = '.'; St_error.MarkerSize = 15; 
St_error.MarkerEdgeColor= [0.752,0,0.752]; St_error.Color= [0.752,0,0.752];
St_error.MarkerFaceColor= [0.752,0,0.752];
 
% Plot fits
ax.XLim = [(min(Dynamic_agg.Round_Corr_D)) (max(Dynamic_agg.Round_Corr_D))];
Dy_fit = plot(Dynamic_IFF_fit); Dy_fit.LineWidth = 2; Dy_fit.Color = [0.059,0.6,0.698];
ax.XLim = [min(Static_agg.Round_Corr_D) max(Static_agg.Round_Corr_D)];
St_fit = plot(Static_IFF_fit); St_fit.LineWidth = 2; St_fit.Color = [0.752,0,0.752]; 

% Set other plot attributes
ax.XLim = [(min(Dynamic_agg.Round_Corr_D - 0.2)) (max(Dynamic_agg.Round_Corr_D + 0.2))];
ax.FontName = 'Arial';
xlabel('Displacement (mm)');
ylabel('Firing Rate (Hz)');
temp = strsplit(dataName,'trial');
title_name = char(temp(1,1));
title(title_name);
legend('Dynamic Peak IFF fit','Dynamic Peak IFF','Static Mean IFF fit','Static Mean IFF');
legend('off');


print('-bestfit',title_name,'-dpdf');

end

