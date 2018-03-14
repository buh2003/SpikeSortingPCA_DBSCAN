%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trial Averaging, Dose response Curves, and Non-Linear regression
% Ben Hoffman
% 08.24.16
%
% Import data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Dynamic, Static ] = import_data( dataName )

Dynamic_Raw = xlsread([dataName '.xlsx'],'Dynamic','A1:M100');
Disp = Dynamic_Raw(1:end,4); Force = Dynamic_Raw(1:end,5);
No_Spikes = Dynamic_Raw(1:end,6); Mean_ISI = Dynamic_Raw(1:end,7); SD_ISI = Dynamic_Raw(1:end,8);
CoV_ISI = Dynamic_Raw(1:end,9); Min_ISI = Dynamic_Raw(1:end,10); Medi_ISI = Dynamic_Raw(1:end,11);
Max_ISI = Dynamic_Raw(1:end, 12);
Round_Corr_D = round_displacement(Disp);
Corr_D = Disp - 0.6;
Dynamic = table(Corr_D, Round_Corr_D, Force, No_Spikes, Mean_ISI, SD_ISI, CoV_ISI, Min_ISI, Medi_ISI, Max_ISI);

Static_Raw = xlsread([dataName '.xlsx'],'Late Static','A1:M100');
Disp = Static_Raw(1:end,4); Force = Static_Raw(1:end,5);
No_Spikes = Static_Raw(1:end,6); Mean_ISI = Static_Raw(1:end,7); SD_ISI = Static_Raw(1:end,8);
CoV_ISI = Static_Raw(1:end,9); Min_ISI = Static_Raw(1:end,10); Medi_ISI = Static_Raw(1:end,11);
Max_ISI = Static_Raw(1:end, 12);
Round_Corr_D = round_displacement(Disp);
Corr_D = Disp -0.6;
Static = table(Corr_D, Round_Corr_D, Force, No_Spikes, Mean_ISI, SD_ISI, CoV_ISI, Min_ISI, Medi_ISI, Max_ISI);

end

