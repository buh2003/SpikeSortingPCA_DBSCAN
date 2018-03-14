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
function [ ] = save_file(ALL_ISI_OF,StimPhase_ISI_OF,Dynamic_ISI_OF,Late_Static_ISI_OF, End_ISI_OF, Disp_points, dataName)
headers = {'Stim #', 'Raw Disp', 'Raw Force', 'Disp', 'Force', '# Spikes', 'Mean ISI', 'SD ISI', 'CoV ISI', 'Min ISI', 'Medi ISI', 'Max ISI', ''};
xlwrite([dataName ' analyzed.xlsx'],headers,'Dynamic'); 
xlwrite([dataName ' analyzed.xlsx'],Dynamic_ISI_OF,'Dynamic', 'A2'); 
xlwrite([dataName ' analyzed.xlsx'],headers,'Late Static'); 
xlwrite([dataName ' analyzed.xlsx'],Late_Static_ISI_OF,'Late Static', 'A2'); 
xlwrite([dataName ' analyzed.xlsx'],headers,'ALL'); 
xlwrite([dataName ' analyzed.xlsx'],ALL_ISI_OF,'ALL', 'A2'); 
xlwrite([dataName ' analyzed.xlsx'],headers,'StimPhase'); 
xlwrite([dataName ' analyzed.xlsx'],StimPhase_ISI_OF,'StimPhase', 'A2'); 
xlwrite([dataName ' analyzed.xlsx'],headers,'StimPhase'); 
xlwrite([dataName ' analyzed.xlsx'],StimPhase_ISI_OF,'StimPhase', 'A2');
xlwrite([dataName ' analyzed.xlsx'],headers,'End'); 
xlwrite([dataName ' analyzed.xlsx'],End_ISI_OF,'End', 'A2'); 
headers_disp = {'Disp Start', 'Disp Peak', 'Disp Late', 'Disp End'};
xlwrite([dataName ' analyzed.xlsx'],headers_disp,'Disp Points');
xlwrite([dataName ' analyzed.xlsx'],Disp_points,'Disp Points', 'A2');
disp('Saving.......Done!')
end

