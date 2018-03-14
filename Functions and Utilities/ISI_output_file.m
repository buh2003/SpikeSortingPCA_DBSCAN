%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.24.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Generate Output File
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ALL_ISI_output_file,StimPhase_ISI_output_file,Dynamic_ISI_output_file,Late_Static_ISI_output_file, End_ISI_output_file]...
    = ISI_output_file( Mags_D, Mags_F, rISI_ALL)

Mags_D_convert = Mags_D(:,1).*2.5; %convert step
Mags_F_convert = Mags_F(:,1).*173; %convert step



ALL_ISI_output_file = [Mags_D(:,2) Mags_D(:,1) Mags_F(:,1) Mags_D_convert Mags_F_convert rISI_ALL(:,2:9)]; 
StimPhase_ISI_output_file = [Mags_D(:,2) Mags_D(:,1) Mags_F(:,1) Mags_D_convert Mags_F_convert rISI_ALL(:,11:18)]; 
Dynamic_ISI_output_file = [Mags_D(:,2) Mags_D(:,1) Mags_F(:,1) Mags_D_convert Mags_F_convert rISI_ALL(:,20:27)]; 
Late_Static_ISI_output_file = [Mags_D(:,2) Mags_D(:,1) Mags_F(:,1) Mags_D_convert Mags_F_convert rISI_ALL(:,29:36)];
End_ISI_output_file = [Mags_D(:,2) Mags_D(:,1) Mags_F(:,1) Mags_D_convert Mags_F_convert rISI_ALL(:,38:45)];

end

