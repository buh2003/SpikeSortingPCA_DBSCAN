%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.04.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Summary plot for Response trace, raster, displacement and force
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = Summary_Plot_aurora( Output_R, Output_F, Output_D, Output_R_boolean, dataName, Cluster_Num )
figure

Amplitude = max(max(Output_R))-min(min(Output_R)); % Plot every response spread out
Maximum_Y = Amplitude*size(Output_R,2);
For_Plot_R = Convert_for_plot(Output_R, Amplitude);
ax_R = subplot(2,2,1); plot(For_Plot_R); ylim([(min(min(Output_R))) Maximum_Y]);
ax_R.XTick = [0 20000 40000 60000 80000 100000 120000 140000 160000 180000 200000];
ax_R.XTickLabel = {'0','1','2','3','4','5','6','7','8','9','10'};

d = designfilt('lowpassiir','FilterOrder',1,'PassbandFrequency',20,'PassbandRipple',6,'SampleRate',20000);
Output_D_filt = filtfilt(d,Output_D);
For_Plot_D = (Convert_for_plot(Output_D_filt*1000, 0.6)); % Plot every displacement spread out
ax_D = subplot(2,2,2); plot(For_Plot_D);
ax_D.XTick = [0 20000 40000 60000 80000 100000 120000 140000 160000 180000 200000];
ax_D.XTickLabel = {'0','1','2','3','4','5','6','7','8','9','10'}; ylim([-.6 (max(max(For_Plot_D))+.6)])

For_Plot_F = Convert_for_plot((Output_F*1000), 173);
ax_F = subplot(2,2,4); plot(For_Plot_F);
ax_F.XTick = [0 20000 40000 60000 80000 100000 120000 140000 160000 180000 200000];
ax_F.XTickLabel = {'0','1','2','3','4','5','6','7','8','9','10'}; ylim([-173 (max(max(For_Plot_F))+173)])

For_Plot_Raster = YF2_Make_Add_Value_For_Print(Output_R_boolean,1);
ax_Rast = subplot(2,2,3); plot(For_Plot_Raster);
hold on; n=0:(size(For_Plot_Raster,2)-1);temp=ones(size(For_Plot_Raster,1),1);temp=temp*n;plot(temp,'w');
ylim([0 (size(For_Plot_Raster,2))]);
ax_Rast.XTick = [0 20000 40000 60000 80000 100000 120000 140000 160000 180000 200000];
ax_Rast.XTickLabel = {'0','1','2','3','4','5','6','7','8','9','10'};

Cluster_Num_Str = num2str(Cluster_Num); % Convert Cluster number to string for title
suptitle([dataName ' CLUSTER: ' Cluster_Num_Str]);
end

