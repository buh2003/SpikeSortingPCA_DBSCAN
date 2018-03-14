%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.24.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Measure Displacement inflection points
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ OUT01 ] = Displacement_inflections_aurora( Displacement, baseline_start, baseline_end, sat_start, sat_end )

[row, cols] = size(Displacement);
tOUT01 = []; OUT01 = [];

for i = 1:cols
      baseline = mean(Displacement(baseline_start:baseline_end,i));  % Calculate averaged initial vale
      sat = mean(Displacement(sat_start:sat_end,i));  % Calculate averaged saturating vale
      temp_start = 0; Count_start = 0;
      temp_peak = 0; Count_peak = 0;
      temp_late = 0 ; Count_late = 0;
      temp_end = 0; Count_end = 0;
      Fn01 = 0; Fn02 = 0; Fn03 = 0; Fn04 = 0; temp_baseline = baseline; temp_sat = sat;
      TEST=0;
      Start = NaN;Peak = NaN;Late = NaN;End = NaN;
      for j = baseline_end:row
          value = Displacement(j,i); 
          if ((value > temp_baseline)&&(Count_start < 200))
             temp_start = j; temp_baseline = value;
             Count_start = Count_start+1;
          end
          if (Count_start==200)% When Count01 reaches 20, the point is named start point. 
              Start = temp_start-80; Fn01=1;
          end
          if ((value > sat)&&(Count_peak == 0)&&(Fn01 == 1))% Find peak point
             Peak = j+2500; Fn02 = 1;
             Count_peak = Count_peak+1;
          end
          if ((value < temp_sat)&&(Count_late < 5)&&(Fn02 == 1)&&(j > Peak+90000))%4.5sec later from peak
             temp_late = j; temp_sat = value;
             Count_late = Count_late+1;
          end
          if Count_late==5 % Find Late point (4.5s after peak)
              Late = temp_late; Fn03 = 1;
          end
          if ((value < baseline)&&(Count_end < 20)&&(Fn03 == 1))
             temp_end = j;
             Count_end = Count_end+1;
          end
          if Count_end == 20
              End = temp_end;
          end
           
      end          
      tOUT01 = [Start Peak Late End];   
      OUT01 = [OUT01; tOUT01];
      
end 
end

