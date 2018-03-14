%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 06.08.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Recenter peaks
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Spike_Shape_Recentered, change_counts ] = Recenter_Peaks_SNP( X, startP, endP, peakP )
[rows, cols] = size(X);
data1 = X(endP+1:rows,:);
Spike_Shape_Recentered = [];
A = [];
count = 0; count1 = 0; count2 = 0; count3 = 0;
for i = 1:cols
    Pre = X(peakP-1,i); PP = X(peakP,i); Post = X(peakP+1,i); 
    B = X(startP:endP,i);
    if (PP>=Pre) && (PP>=Post)
        count = count+1;
    elseif (PP<Pre) && (PP>Post)
        count1 = count1+1;
        rows_B = size(B,1);
        C = B(1:rows_B-1,1);
        avg_temp = (B(rows_B,1)+B(1,1))/2;
        B = [avg_temp;C];
    elseif (PP>Pre) && (PP<Post)
        count2 = count2+1;
        rows_B = size(B,1);
        C = B(2:rows_B,1);
        avg_temp = (B(rows_B,1)+B(1,1))/2;
        B = [C;avg_temp];
    else
        count3=count3+1;
    end
    A = [A B];
end
change_counts = [count count1 count2 count3];
Spike_Shape_Recentered = [A;data1];
figure
plot(Spike_Shape_Recentered(1:endP,:));
a = min(Spike_Shape_Recentered(1:endP,:));
b = round(min(a),-1)-40;
c = max(Spike_Shape_Recentered(1:endP,:));
d = round(max(c),-1)+40;
% set(gca, 'YTick', [b:10:d])
% set(gca, 'YGrid', 'on')
% set(gca, 'XTick', [0:1:endP])
% set(gca, 'XGrid', 'on')
% line([6 6],[b d],'Color','b')
% line([12 12],[b d],'Color','b')
% line([20 20],[b d],'Color','b')
% line([22 22],[b d],'Color','b')
% line([25 25],[b d],'Color','b')
end

