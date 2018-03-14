%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 06.08.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Spike Peak Bandpass
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Spike_Train, Spike_Shape ] = Spike_Bandpass_SNP( x, max, min, length )
x = table2array(x);
rows = size(x,1);
Spike_Train = zeros(rows,4);
Pre_point = 11;
temp_spike = [];
Spike_Shape = [];
for i = 2:(rows-1)
    x0 = x(i-1,2);
    x1 = x(i,2);
    x2 = x(i+1,2);
    if((x1>x2) && (x1>x0) && (x1>=min) && (x1<max))
       Spike_Train(i,3) = 1;
       pre = i-Pre_point;
       post = i+length;
       if((pre>0) && (post<=rows))
          Spike_Train(pre:post,2) = x(pre:post,2);
          temp_spike = x(pre:post,2);
          temp_spike = [temp_spike;0;i;0];
          Spike_Shape = [Spike_Shape temp_spike];
       else
           disp 'error'
       end    
    end
end
Spike_Train(:,1) = x(:,1);
end

