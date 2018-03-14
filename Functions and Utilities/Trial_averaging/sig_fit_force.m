%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trial Averaging, Dose response Curves, and Non-Linear regression
% Ben Hoffman
% 03.03.17
%
% Perform sigmoid fit
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Dynamic_IFF_fit, Dynamic_gof, Static_IFF_fit, Static_gof ] = sig_fit_force( Dynamic_agg, Static_agg, dataName )

%Define the sigmoid equation (a: slope, b: Lower, c: Upper, d:F50)
fit_eq = fittype('(b+(c./(1+exp((-1*a)*(x-d)))))','dependent',{'y'},...
    'independent',{'x'},'problem',{'b'}); % b is fixed as a problem

%Sig fit for Dynamic
x = Dynamic_agg.mean_Force;
y = Dynamic_agg.mean_Peak_IFF;
options = fitoptions(fit_eq);
start_a = ((max(y)-min(y))/(max(x)-min(x)))/20; % starting value for slope
start_d = median(x); % starting value for X50 is the median displacement
start_c = max(y); % starting value for Upper is the median IFF
options.StartPoint = [start_a,start_c,start_d]; % Set start points, slope start is 1
[Dynamic_IFF_fit,Dynamic_gof] = fit(x,y,fit_eq,options,'problem',0); % Fit to equation, fix lower at 0

%Sig fit for Static
x = Static_agg.mean_Force;
y = Static_agg.mean_Mean_IFF;
options = fitoptions(fit_eq);
start_a = ((max(y)-min(y))/(max(x)-min(x)))/10; % starting value for slope
start_d = median(x);
start_c = max(y);
options.StartPoint = [start_a,start_c,start_d];
[Static_IFF_fit,Static_gof] = fit(x,y,fit_eq,options,'problem',0);

%Plotting
figure;
ax = gca;
hold on
%Dynamic Data
Dy_error = errorbar(Dynamic_agg.mean_Force, Dynamic_agg.mean_Peak_IFF, Dynamic_agg.std_Peak_IFF);
Dy_error.LineStyle = 'none'; Dy_error.Marker = '.'; Dy_error.MarkerSize = 15; 
Dy_error.Color= [0.059, 0.6, 0.698]; Dy_error.MarkerEdgeColor= [0.059, 0.6, 0.698]; 
Dy_error.MarkerFaceColor= [0.059, 0.6, 0.698];

%Static Data
St_error = errorbar(Static_agg.mean_Force, Static_agg.mean_Mean_IFF, Static_agg.std_Mean_IFF);
St_error.LineStyle = 'none'; St_error.Marker = '.'; St_error.MarkerSize = 15; 
St_error.MarkerEdgeColor= [0.752,0,0.752]; St_error.Color= [0.752,0,0.752];
St_error.MarkerFaceColor= [0.752,0,0.752];
 
% Plot fits
ax.XLim = [(min(Dynamic_agg.mean_Force)) (max(Dynamic_agg.mean_Force))];
Dy_fit = plot(Dynamic_IFF_fit); Dy_fit.LineWidth = 2; Dy_fit.Color = [0.059,0.6,0.698];
ax.XLim = [min(Static_agg.mean_Force) max(Static_agg.mean_Force)];
St_fit = plot(Static_IFF_fit); St_fit.LineWidth = 2; St_fit.Color = [0.752,0,0.752]; 

% Set other plot attributes
ax.XLim = [(min(Dynamic_agg.mean_Force)-log(min(Dynamic_agg.mean_Force))) ...
    (max(Dynamic_agg.mean_Force) + 2*log(max(Dynamic_agg.mean_Force)))];
ax.FontName = 'Arial';
xlabel('Force (mN)');
ylabel('Firing Rate (Hz)');
temp = strsplit(dataName,'trial');
title_name = char(temp(1,1));
title(title_name);
legend('Dynamic Peak IFF','Static Mean Firing','Dynamic Peak IFF Fit','Static Mean Firing Fit');
%legend('off');
set(gca,'XScale','log')


print('-bestfit',[title_name 'force'],'-dpdf');

end

