function [ output_RDF, output_IFF ] = summary_figure_load_trialdata( summary_fig_name,summary_IFF_name, stim, datatype )
%For Response, Displacement, or Force
h = openfig(summary_fig_name, 'invisible'); %% Need the Trial Summary Figure in path
handles=findobj(h,'Type','axes');

if strcmpi(datatype,'response')==1
    n=5;
elseif strcmpi(datatype,'displacement')==1
    n=4;
elseif strcmpi(datatype,'force')==1
    n=3;
end

axesObjs=handles(n);
dataObjs=allchild(axesObjs);
ydata = get(dataObjs, 'YData');

data_RDF_max = ydata{stim,1};
output_RDF = (data_RDF_max-mean(data_RDF_max(1:100)))';

%For IFF values

h = openfig(summary_IFF_name, 'invisible'); %% Need the Trial Summary Figure in path
axesObjs = get(h, 'Children');  %axes handles
dataObjs = axesObjs.Children;
ydata = get(dataObjs, 'YData');
data_IFF_max = ydata{stim,1};
output_IFF = (data_IFF_max-mean(data_IFF_max(1:100)))';
end

