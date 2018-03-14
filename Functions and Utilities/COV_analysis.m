%%
dataName = ['040815_02_trial2'];
%%
Displacements = rDFISI101_convert_B(:,4);
[Dy_COVdata_ALL, Dy_COVdata_avg] = COV_analysis(OUT_PUT_FRQ_no_Zero101, Data_DynStaEnd_101, [-20000,21000], 2);
[St_COVdata_ALL, St_COVdata_avg] = COV_analysis(OUT_PUT_FRQ_no_Zero101, Data_DynStaEnd_101, [41000,50000], 2);
COVdata_avg_summary = table(Dy_COVdata_avg.trialNum,Displacements,Dy_COVdata_avg.avgCVisi,St_COVdata_avg.avgCVisi,...
    'VariableNames',{'trial','Displacement','DyavgCVisi','StavgCVisi'});
%%
writetable(COVdata_avg_summary, [dataName '_COVdata.xlsx']);
writetable(Dy_COVdata_ALL,[dataName '_COVdata.xlsx'],'Sheet',2);
writetable(St_COVdata_ALL,[dataName '_COVdata.xlsx'],'Sheet',3);


