%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software for PCA-DBSCAN sorting
% Ben Hoffman
% 08.09.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Plot Sorting Summary
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ output_args ] = PCA_DBSCAN_Summary( Response, Displacement, Spike_Shape_Recentered,...
    PCA_weights, Spikes_Sorted, idx, dataName )
figure; 
suptitle([dataName ' PCA-DBSCAN']); 

subplot(2,2,1); % Plot spike train
plot(Response, 'b'); 
hold on; 
plot((Displacement)*200-300,'r'); 
hold off;

subplot(2,2,2); % Plot aligned spikes
plot(Spike_Shape_Recentered(1:35,:));

subplot(2,2,3) % Plot PCA1 vs PCA2 with DBSCAN clusters
k=max(idx);
Colors=hsv(k);
Legends = {};
X = PCA_weights(:,1:2);
for i=0:k
    Xi=X(idx==i,:);
    if i~=0
        Style = 'x';
        MarkerSize = 8;
        Color = Colors(i,:);
        Legends{end+1} = ['Cluster #' num2str(i)];
    else
        Style = 'o';
        MarkerSize = 6;
        Color = [0 0 0];
        if ~isempty(Xi)
            Legends{end+1} = 'Noise';
        end
    end
    if ~isempty(Xi)
        plot(Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
    end
    hold on;
end
hold off;
grid on;
legend(Legends);
legend('Location', 'NorthEastOutside');


subplot(2,2,4); % Plot Sorted Spikes
hold on;
groups = unique(Spikes_Sorted(63,:));
if groups == 1
    Colors = hsv((length(groups))); 
else
    if all(Spikes_Sorted(63,:),2) == 1
        Colors(1:length(groups),:) = hsv((length(groups)));
    else
        Colors(1,:) = [0 0 0]; Colors(2:length(groups),:) = hsv((length(groups)-1));
    end
end
for i = 1:length(groups)
    temp = (Spikes_Sorted(63,:)==groups(i));
    plot(Spikes_Sorted(1:35,temp), 'Color', Colors(i,:));
end
hold off

end

