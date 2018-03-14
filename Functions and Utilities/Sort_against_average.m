%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.01.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Sort spikes against average spike shape
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Final_Sort ] = Sort_against_average( Average_spike_shape, Spikes_Sorted_Clean, ratio )

CP = 63; %Check point in CP_S_SHAPE_ANA 
PP = 63;   %Put point in result file
PN = 100;  %Put number in the point in result file
Result=[];
Final_Sort_Selected = []; 
Final_Sort_Removed = []; 
Final_Sort = [];
[row_avg, col_avg] = size(Average_spike_shape);
[row_spikes, col_spikes] = size(Spikes_Sorted_Clean);

PreP = 8;     %pre-check_point; 
PostP = 32;    %post-check_number;

TestAmpMx = 1.2;%AmpMax;
TestAmpMi = 0.8;%AmpMin;

count = 0; 
count1 = 0;
count2 = 0;
count3 = 0; 
average_shape = Average_spike_shape(PreP:PostP,1); % Average spike data for comparison     
SD_average_shape = std(average_shape); % SD of test shape (without (1/n-1)^0.5)
   
Result = [SD_average_shape 0 0 0];

for i = 1:col_spikes 
    if (Spikes_Sorted_Clean(63,i) == 1) % Check if spike passed previous sorting
        count1 = count1+1;
        spike_shape = Spikes_Sorted_Clean(PreP:PostP,i); % Result file spike for comparison   
        SD_spike_shape = std(spike_shape); % SD of spike shape (without (1/n-1)^0.5) 
        PCC_SpikeToAverage = corrcoef(average_shape,spike_shape); % Calculate Pearson's correlation coefficient
        PCC_SpikeToAverage = PCC_SpikeToAverage(1,2);
        SD_ratio = SD_spike_shape/SD_average_shape; % Compare SDs
        tCorResult=[SD_spike_shape PCC_SpikeToAverage PCC_SpikeToAverage SD_ratio];
        Result = [Result; tCorResult];
        if (PCC_SpikeToAverage >= ratio) && (SD_ratio < TestAmpMx) && (SD_ratio >= TestAmpMi)
            Sort_Selected = Spikes_Sorted_Clean(:,i); 
            Final_Sort_Selected = [Final_Sort_Selected Sort_Selected];
            J(1,i) = PN; count = count+1;  
        else
            count2=count2+1; J(1,i)=0; 
            Sort_Removed = Spikes_Sorted_Clean(:,i);
            Final_Sort_Removed=[Final_Sort_Removed Sort_Removed];
        end      
    else
        Sort_Removed = Spikes_Sorted_Clean(:,i);
        Final_Sort_Removed = [Final_Sort_Removed Sort_Removed];
        count3 = count3+1; J(1,i)=0;
    end    
end

TS = ['Total # Spikes: ', num2str(col_spikes)];
disp(TS)
ISSK = ['Initial Sort # Spikes Kept: ', num2str(count1)];
disp(ISSK)
ISSTO = ['Initial Sort # Spikes Thrown Out: ', num2str(count3)];
disp (ISSTO)
FSSK = ['Final Sort # Spikes Kept: ',num2str(count)];
disp(FSSK)
FSSTO = ['Final Sort # Spikes Thrown Out: ',num2str(count2)];
disp(FSSTO)

if ((PP>0)||(PP<row_spikes+1))
    if (PP<row_spikes)
       Final_Sort = [Spikes_Sorted_Clean(1:PP-1,:);J;Spikes_Sorted_Clean(PP+1:row_spikes,:)];
    else
       Final_Sort = [Spikes_Sorted_Clean(1:PP-1,:);J];
    end
else
    Final_Sort = [Spikes_Sorted_Clean ; J];
end

J=[0 J];
J=J';
figure
if (count2>0)||(count3>0)
    plot(Final_Sort_Removed(1:row_avg-3,:),'r')
    hold('on')
end
if (count>0)
    plot(Final_Sort_Selected(1:row_avg-3,:),'b')
end

end

