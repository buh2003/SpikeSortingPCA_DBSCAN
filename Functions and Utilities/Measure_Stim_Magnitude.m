%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.24.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Measure Force and Displacement Magnitudes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Mags_Disp,Mags_Force ] = Measure_Stim_Magnitude( Displacement, Force, baseline_start, baseline_end, peak_start, peak_end )
Disp_cols = size(Displacement,2);
Force_cols = size(Force,2);

Mags_Disp = []; %Displacement magnitude
for i = 1:Disp_cols
      baseline_Disp = mean(Displacement(baseline_start:baseline_end,i));
      peak_Disp = mean(Displacement(peak_start:peak_end,i));
      Magnitude_Disp = peak_Disp - baseline_Disp;
      temp_Disp = [Magnitude_Disp i baseline_Disp peak_Disp];
      Mags_Disp = [Mags_Disp; temp_Disp];
end

Mags_Force = []; %Force magnitude
for i = 1:Force_cols
      baseline_Force = mean(Force(baseline_start:baseline_end,i));
      peak_Force = mean(Force(peak_start:peak_end,i));
      Magnitude_Force = peak_Force - baseline_Force;
      temp_Force = [Magnitude_Force i baseline_Force peak_Force];
      Mags_Force = [Mags_Force; temp_Force];
end

end

