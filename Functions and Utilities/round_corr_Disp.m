function [ output ] = round_corr_Disp( data, corr )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
    corr_Disp = data.Displacement - 0.6;
    rounded_Disp = round((corr_Disp)/0.05)*0.05;
    output = table(corr_Disp, rounded_Disp, data.DyavgCVisi, data.StavgCVisi,...
        'VariableNames',{'Displacement','Rounded_Displacement','DyAvgCVisi','StAvgCVisi'});
end

