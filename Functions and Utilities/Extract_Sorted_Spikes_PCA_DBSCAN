%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.24.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Extract sorted spikes into file
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Extracted_Spikes, Show_Spike_Train ] = Extract_Sorted_Spikes_PCA_DBSCAN( Spike_Train, Final_Sort, Cluster_Num )
[row_ST, col_ST]=size(Spike_Train);
[row_FS, col_FS]=size(Final_Sort);
Extracted_Spikes=[];
count=0;
tR = zeros(row_ST,1); %boolean vector for extracted spikes in spike train
for i = 1:col_FS 
    if (Final_Sort(63,i) == Cluster_Num) %check if spike passed sorting (row 63 == cluster number)
        if count == 0
            Extracted_Spikes = [Extracted_Spikes Final_Sort(:,i)];
            count=count+1;
            B = Final_Sort(62,i);
            tR(B,1) = 1;
            last_spike=i;
        end
        if count>0 && (Final_Sort(62,i)-Final_Sort(62,(last_spike))>20)
            Extracted_Spikes = [Extracted_Spikes Final_Sort(:,i)];
            count=count+1;
            B = Final_Sort(62,i);
            tR(B,1) = 1;
            last_spike=i;
        end
    end
end
Show_Spike_Train=[Spike_Train tR];  
message = ['Number of Extracted Spikes: ', num2str(count)];
disp(message);
end

