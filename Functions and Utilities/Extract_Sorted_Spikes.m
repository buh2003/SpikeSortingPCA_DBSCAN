%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.04.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Extract sorted spikes into file
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Extracted_Spikes, Show_Spike_Train ] = Extract_Sorted_Spikes( Spike_Train, Final_Sort )
[row_ST, col_ST]=size(Spike_Train);
[row_FS, col_FS]=size(Final_Sort);
Extracted_Spikes=[];
count=0;
tR = zeros(row_ST,1); %boolean vector for extracted spikes in spike train
for i = 1:col_FS 
    if (Final_Sort(63,i) == 100) %check if spike passed sorting (row 63 == 100)
        Extracted_Spikes = [Extracted_Spikes Final_Sort(:,i)];
        count=count+1;
        B = Final_Sort(62,i);
        tR(B,1) = 1; 
    end
end
Show_Spike_Train=[Spike_Train tR];  
message = ['Number of Extracted Spikes: ', num2str(count)];
disp(message);
end

