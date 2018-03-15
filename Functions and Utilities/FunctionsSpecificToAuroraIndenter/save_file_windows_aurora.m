%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.24.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Save to excel function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ ] = save_file_windows_aurora(ALL_ISI_OF,StimPhase_ISI_OF,Dynamic_ISI_OF,Late_Static_ISI_OF, End_ISI_OF, Disp_points, latencies, dataName)
headers = {'Stim #', 'Raw Disp', 'Raw Force', 'Disp', 'Force', '# Spikes', 'Mean ISI', 'SD ISI', 'CoV ISI', 'Min ISI', 'Medi ISI', 'Max ISI', ''};
xlswrite([dataName ' analyzed.xlsx'],headers,'Dynamic'); 
xlswrite([dataName ' analyzed.xlsx'],Dynamic_ISI_OF,'Dynamic', 'A2'); 
xlswrite([dataName ' analyzed.xlsx'],headers,'Late Static'); 
xlswrite([dataName ' analyzed.xlsx'],Late_Static_ISI_OF,'Late Static', 'A2'); 
xlswrite([dataName ' analyzed.xlsx'],headers,'ALL'); 
xlswrite([dataName ' analyzed.xlsx'],ALL_ISI_OF,'ALL', 'A2'); 
xlswrite([dataName ' analyzed.xlsx'],headers,'StimPhase'); 
xlswrite([dataName ' analyzed.xlsx'],StimPhase_ISI_OF,'StimPhase', 'A2'); 
xlswrite([dataName ' analyzed.xlsx'],headers,'StimPhase'); 
xlswrite([dataName ' analyzed.xlsx'],StimPhase_ISI_OF,'StimPhase', 'A2');
xlswrite([dataName ' analyzed.xlsx'],headers,'End'); 
xlswrite([dataName ' analyzed.xlsx'],End_ISI_OF,'End', 'A2'); 
headers_disp = {'Disp Start', 'Disp Peak', 'Disp Late', 'Disp End'};
xlswrite([dataName ' analyzed.xlsx'],headers_disp,'Disp Points');
xlswrite([dataName ' analyzed.xlsx'],Disp_points,'Disp Points', 'A2');
xlswrite([dataName ' analyzed.xlsx'],{'Force','Latency to Spike'},'Latencies');
xlswrite([dataName ' analyzed.xlsx'],[ALL_ISI_OF(:,5),latencies],'Latencies', 'A2');
disp('Saving.......Done!')
end

