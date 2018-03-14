function [ output ] = roundDisp( data )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
    rounded_Disp = round(data.Displacement/0.05)*0.05;
    output = table(data.Displacement, rounded_Disp, data.DyavgCVisi, data.StavgCVisi,...
        'VariableNames',{'Displacement','Rounded_Displacement','DyAvgCVisi','StAvgCVisi'});
end

