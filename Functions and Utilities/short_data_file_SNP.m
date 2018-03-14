%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 06.08.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Cut raw data file into more manageable chunks
% baseline correct Response data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ All_short ] = short_data_file_SNP( data, cutpoints, time_before, time_after )
x = [];
for i = 1:(length(cutpoints))
    PRE = cutpoints(i)-time_before+1;
    POST = cutpoints(i)+time_after;
    if PRE>0 && POST<height(data)
        x = [x;data(PRE:POST,:)];
    elseif PRE>0 && POST>height(data)
        disp('---!!!!Last trace is too short!!!!---')
    end
end
mean_r = mean(data.Response(1:10000)); %find baseline
x.Response = (x.Response - mean_r)*1000; %baseline correct and multiply by 1000
All_short = x;
figure
plot(All_short.Response, 'b');
hold on
plot((All_short.Displacement)*200-300,'r');
end