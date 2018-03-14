%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trial Averaging, Dose response Curves, and Non-Linear regression
% Ben Hoffman
% 08.25.16
%
% Save data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ output_args ] = save_boltz_data( Dynamic_IFF_fit, Dynamic_gof, Dynamic_agg, Static_IFF_fit, Static_gof, Static_agg, dataName)
temp = strsplit(dataName,'trial');
file_name = char(temp(1,1));

%Save Dynamic Aggregate Values
Dy_agg_names = Dynamic_agg.Properties.VariableNames;
Dy_agg_values = table2array(Dynamic_agg);
xlwrite([file_name 'aggregated analysis.xlsx'],Dy_agg_names,'Dynamic Aggregate Values');
xlwrite([file_name 'aggregated analysis.xlsx'],Dy_agg_values,'Dynamic Aggregate Values','A2');
%Save Dynamic Boltz Values
Dy_boltz_names = {'Slope','Upper Limit', 'ED50','rsquare'};
Dy_boltz_values = [coeffvalues(Dynamic_IFF_fit) Dynamic_gof.rsquare];
xlwrite([file_name 'aggregated analysis.xlsx'],Dy_boltz_names,'Dynamic Boltz Values');
xlwrite([file_name 'aggregated analysis.xlsx'],Dy_boltz_values,'Dynamic Boltz Values','A2');

%Save Static Aggregate Values
St_agg_names = Static_agg.Properties.VariableNames;
St_agg_values = table2array(Static_agg);
xlwrite([file_name 'aggregated analysis.xlsx'],St_agg_names,'Static Aggregate Values');
xlwrite([file_name 'aggregated analysis.xlsx'],St_agg_values,'Static Aggregate Values','A2');
%Save Static Boltz Values
St_boltz_names = {'Slope','Upper Limit', 'ED50','rsquare'};
St_boltz_values = [coeffvalues(Static_IFF_fit) Static_gof.rsquare];
xlwrite([file_name 'aggregated analysis.xlsx'],St_boltz_names,'Static Boltz Values');
xlwrite([file_name 'aggregated analysis.xlsx'],St_boltz_values,'Static Boltz Values','A2');
disp('saving......done!');

end

