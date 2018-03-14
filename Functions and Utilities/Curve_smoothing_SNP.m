%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 06.08.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Curve smoothing: Local averaging in 3 data point bins
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Spike_Shape_Smoothed ] = Curve_smoothing_SNP( x, startP, endP, AP ) 
[rows, cols] = size(x);
Spike_Shape_Smoothed = [];
data1 = x(endP+1:rows,:);
A=[];
for i = 1:cols
    B = [];
    C = [];
    for j = 1:endP
        if j<startP
            C = x(j,i);
            B = [B; C];       
        elseif j>=startP
            C=x(j,i);
            for k = 1:AP
                PreP=[];
                PostP=[];
                if (j-k)>0
                  PreP=x((j-k),i);  
                end
                if (j+k)<=endP
                  PostP=x((j+k),i); 
                end
               C=[PreP; C; PostP];
            end
            C=mean(C);
            B=[B; C];           
        end
    end
    A=[A B];
end
Spike_Shape_Smoothed=[A;data1];
end

