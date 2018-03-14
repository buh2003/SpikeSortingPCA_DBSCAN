%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 06.20.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Find cutpoints to shorten raw file
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ output ] = Force_cutpoint_SNP( data, threshold, waitP, stimlength )
    meanF = mean(data.Force(1:1000));
    corrF = (data.Force-meanF);
    cutpoints = [];
    waitP_count = 0;
    Cut_onoff = 1;
    Stimlength_count = 0;
    for i = 1:(length(data.time))
        value = corrF(i,1);
        Stimlength_count = Stimlength_count+1;
        if (value>threshold)&(waitP_count<waitP)
            waitP_count = waitP_count+1;
        elseif (value>threshold)&(waitP_count==waitP)&(Cut_onoff==1)
            cutpoints = [cutpoints;i];
            Cut_onoff = 0;
            Stimlength_count = 0;
        end
        if (Stimlength_count == stimlength)
            Cut_onoff = 1;
            Stimlength_count = 0;
        end
    end
    output = cutpoints;
end