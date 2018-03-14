%%%%%%%%%%%%------------------ Generate Fiber Summary Figure ----------------%%%%%%%%%%
%%%%%%%%%% Ben Hoffman
%%%%%%%% 04.21.2017

%% Figure Title
dataName = '080717 941 fiber4';
Example_Names = ' (t1max1 t3med3 t1min5)';
figuretitle = [dataName ' Summary Figure' Example_Names];
%% Load Exemplary Files for Max Stim
Stim_max = 1; %% ENTER MAX STIM NUMBER HERE BEFORE YOU BEGIN
trial_Name = ''; %% ENTER TRIAL NUMBER HERE BEFORE YOU BEGIN
summary_fig_name = [dataName trial_Name ' Summary.fig'];
summary_IFF_name = [dataName trial_Name ' IFF.fig'];

[Response_max,IFF_max] = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_max, 'response'); 
Displacement_max = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_max, 'displacement'); 
Force_max = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_max, 'force');

%% Load Exemplary Files for Med Stim
Stim_med = 3; %% ENTER MAX STIM NUMBER HERE BEFORE YOU BEGIN
trial_Name = ''; %% ENTER TRIAL NUMBER HERE BEFORE YOU BEGIN
summary_fig_name = [dataName trial_Name ' Summary.fig'];
summary_IFF_name = [dataName trial_Name ' IFF.fig'];

[Response_med, IFF_med] = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_med, 'response'); 
Displacement_med = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_med, 'displacement'); 
Force_med = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_med, 'force');

%% Load Exemplary Files for Min Stim
Stim_min = 5; %% ENTER MAX STIM NUMBER HERE BEFORE YOU BEGIN
trial_Name = ''; %% ENTER TRIAL NUMBER HERE BEFORE YOU BEGIN
summary_fig_name = [dataName trial_Name ' Summary.fig'];
summary_IFF_name = [dataName trial_Name ' IFF.fig'];

[Response_min, IFF_min] = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_min, 'response'); 
Displacement_min = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_min, 'displacement'); 
Force_min = summary_figure_load_trialdata(summary_fig_name, summary_IFF_name, Stim_min, 'force');

%% %%%%%% -------STEP2: Make Figures -------- %%%%%%%%%%

set(0,'DefaultFigureWindowStyle','docked')
figure1 = figure;
set(figure1, 'inverthardcopy', 'off');

% Create Displacement Figure

axes1 = axes('Parent',figure1,'XColor',[1 1 1],'Position',[.33 .85 0.35 0.08]);
ylim(axes1,[min(Displacement_max(:))-.1 max(Displacement_max(:))+.1]);
hold(axes1,'on');
plot1_1 = plot(axes1, Displacement_max(1:180000,1), 'k');
plot1_2 = plot(axes1, Displacement_med(1:180000,1), 'k');
plot1_3 = plot(axes1, Displacement_min(1:180000,1), 'k');
ylabel('mm');
title(figuretitle);

% Create Force Figure

axes2 = axes('Parent',figure1, 'XColor',[1 1 1], 'Position',[.33 0.74 0.35 0.08]);
ylim(axes2,[min(Force_max(:))-.1 max(Force_max(:))+.1]);
hold(axes2,'on');
plot2_1 = plot(axes2, Force_max(1:180000,1), 'k');
plot2_2 = plot(axes2, Force_med(1:180000,1), 'k');
plot2_3 = plot(axes2, Force_min(1:180000,1), 'k');
ylabel('mN');

% Create Max Stimulation Trace
axes3 = axes('Parent',figure1,'Position',[.33 0.63 0.35 0.1]);
ylim(axes3,[min(Response_max(35000:60000,1))-10 max(Response_max(35000:60000,1))+10]);
hold(axes3,'on');
axis off
plot3 = plot(axes3, Response_max(1:180000,1), 'k');

% Create Med Stimulation Trace
axes4 = axes('Parent',figure1,'Position',[.33 0.52 0.35 0.1]);
ylim(axes4,[min(Response_max(35000:60000,1))-10 max(Response_max(35000:60000,1))+10]);
hold(axes4,'on');
axis off
plot4 = plot(axes4, Response_med(1:180000,1), 'k');

% Create Min Stimulation Trace
axes5 = axes('Parent',figure1, 'YTick',...
    [round(min(Response_min(1:180000,1))-10,-2):200:round(max(Response_min(1:180000,1))+10,-2)],...
    'XColor',[1 1 1], 'Position',[.33 0.41 0.35 0.1]);
ylim(axes5,[min(Response_max(35000:60000,1))-10 max(Response_max(35000:60000,1))+10]);
hold(axes5,'on');
plot5 = plot(axes5, Response_min(1:180000,1), 'k');
ylabel('µV');

% Create Max Stimulation IFF plot
IFF_max(IFF_max==0) = nan;
axes6 = axes('Parent',figure1,'XLim', [0 180000], 'XTick',[] ,'Position',[.33 0.30 0.35 0.1]);
ylim(axes6,[0 (ceil(max(IFF_max)/100)*100)]);
xlim(axes6, [0 180000]);
hold(axes6,'on');
plot6 = plot(IFF_max(:),'Parent',axes6,'DisplayName','OUT_PUT_FRQ101',...
    'MarkerFaceColor',[0 0 0],...
    'MarkerEdgeColor','k',...
    'MarkerSize',13,...
    'Marker','.',...
    'Color',[1 1 1]);

% Create Med Stimulation IFF plot
IFF_med(IFF_med==0) = nan;
axes7 = axes('Parent',figure1,'XLim', [0 180000], 'XTick',[] ,'Position',[.33 0.19 0.35 0.1]);
ylim(axes7,[0 (ceil(max(IFF_max)/100)*100)]);
hold(axes7,'on');
plot7 = plot(IFF_med(:),'Parent',axes7,'DisplayName','OUT_PUT_FRQ101',...
    'MarkerFaceColor',[0 0 0],...
    'MarkerEdgeColor','k',...
    'MarkerSize',13,...
    'Marker','.',...
    'Color',[1 1 1]);

% Create Min Stimulation IFF plot
IFF_min(IFF_min==0) = nan;
axes8 = axes('Parent',figure1, 'XLim', [0 180000], 'XTickLabel',{'0','2','4','6','8'},...
    'XTick',[0 40000 80000 120000 160000],'Position',[.33 0.08 0.35 0.1]);
ylim(axes8,[0 (ceil(max(IFF_max)/100)*100)]);
hold(axes8,'on');
plot8 = plot(IFF_min(:),'Parent',axes8,'DisplayName','OUT_PUT_FRQ101',...
    'MarkerFaceColor',[0 0 0],...
    'MarkerEdgeColor','k',...
    'MarkerSize',13,...
    'Marker','.',...
    'Color',[1 1 1]);
xlabel('Time (s)');
ylabel('Hz');


%% Save Figure (Move to fiber general folder first)
savefig(figure1,figuretitle);
