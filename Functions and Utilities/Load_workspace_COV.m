function [x,y,z] = Load_workspace_COV( workspace )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    x = load(workspace,'Data_DynStaEnd_101');
    x = x.Data_DynStaEnd_101;
    y = load(workspace,'OUT_PUT_FRQ_no_Zero101');
    y = y.OUT_PUT_FRQ_no_Zero101;
    z = load(workspace,'rDFISI101_convert_B');
    z = z.rDFISI101_convert_B ;
end