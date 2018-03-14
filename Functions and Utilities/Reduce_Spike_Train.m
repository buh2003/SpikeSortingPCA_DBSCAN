%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.04.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Extracts data from Response, Force and Displacement into 10s stimuli
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Output_R, Output_F, Output_D, Output_R_boolean ] = Reduce_Spike_Train( All_short, Show_Spike_Train, samplerate)
Output_R = [];% 
Output_F = [];
Output_D = [];
Output_R_boolean = [];
Period = 200000;
Num = (size(All_short,1)/Period); % counts number of (Period) stimuli

for i = 1:Num
    Start = 1+(i-1)*Period;
    End = i*Period;
    if (End<=size(All_short,1))
        Output_R =[Output_R (All_short{Start:End,2})];
        Output_F =[Output_F (All_short{Start:End,3})];
        Output_D =[Output_D (All_short{Start:End,4})];
        Output_R_boolean = [Output_R_boolean (Show_Spike_Train(Start:End,5))]; % At each spike's peak, 1 if it passed sorting, 0 if not
    end
end

d = designfilt('lowpassiir','FilterOrder',3,'PassbandFrequency',20,'PassbandRipple',1,'SampleRate',samplerate);
Output_F = filtfilt(d,Output_F);

end

