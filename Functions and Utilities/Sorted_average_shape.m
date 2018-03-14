%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.01.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Generate average shape of sorted spikes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [TEST_SPIKE] = Sorted_average_shape( Spikes_Sorted_Clean )
[row, cols] = size(Spikes_Sorted_Clean);
count_kept=0;
count_removed=0;
Spikes_for_average=[];
TEST_SPIKE=[];

for i = 1:cols
 if (Spikes_Sorted_Clean(63,i) == 1) % If spike is to be kept 
  count_kept = count_kept+1;
  good_spike = Spikes_Sorted_Clean(1:60,i);
  Spikes_for_average = [Spikes_for_average good_spike];
 else
  count_removed = count_removed+1;
 end
end

[row_spikes, cols_spikes] = size(Spikes_for_average);

for i=1:row_spikes
    TEST_SPIKE = [TEST_SPIKE; mean(Spikes_for_average(i,:))];
end         
plot(TEST_SPIKE(1:37,:),'k','LineWidth',3)
end

