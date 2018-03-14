%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 06.08.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Discriminate Spikes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Spikes_Sorted ] = Discriminate_Spikes_SNP( Spike_Shape_Recentered, Bandpass_points )

[row_BP, cols_BP] = size(Bandpass_points);  
[row, cols] = size(Spike_Shape_Recentered);
Selected_Spikes = []; 
Deleted_Spikes = [];           
Spikes_Sorted = [];
Sort_Value = []; % Binary values indicated if a spike is to be kept or thrown out                           
count = 0;  

for i = 1:cols
CHECK_List = [];
    for j = 1:row_BP
       Bandpass_t = Bandpass_points(j,1); % time to evaluate bandpass
       value = Spike_Shape_Recentered(Bandpass_t,i);  % Spike value at time
       BP_H = Bandpass_points(j,2); % High threshold
       BP_L = Bandpass_points(j,3); % Low threshold
       if (value<BP_H) && (value>BP_L) % Evaluate if point falls between
          tCHECK_List = 1; % yes
       else
          tCHECK_List = 0; % no
       end
       CHECK_List = [CHECK_List; tCHECK_List]; % Generate list of yes/no
    end
    value = sum(CHECK_List);
    if (value == row_BP) % if any spike has a no (0), it will fail
         Sort_Value = [Sort_Value 1];
    else
         Sort_Value = [Sort_Value 0];
    end
end

for i = 1:cols % Generate sorted and thrown spikes for plotting purposes
   spike = Spike_Shape_Recentered(1:37,i);
   keepspike = Sort_Value(1,i);
   if (keepspike == 1)
       Selected_Spikes = [Selected_Spikes spike]; 
       count = count+1;
   else
       Deleted_Spikes = [Deleted_Spikes spike];   
   end
    
end

Spikes_Sorted = [Spike_Shape_Recentered(1:62,:);Sort_Value]; % Generate output file that indicates at row 63 with 1 or 0 if spike is sorted
figure
plot(Deleted_Spikes(1:37,:),'r')
hold on
plot(Selected_Spikes(1:37,:),'b')

end

