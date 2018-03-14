%%%%%% intialprocess_SNP %%%%%%%%
%%% ---------------------------------------
%%% SNP data analysis package
%%% Ben Hoffman 
%%% 06.08.2016
%%% ---------------------------------------
%%% Split the long format labchart data into 3 files for Response,
%%% Displacement and Force. Generate time from row numbers.

function [ Allraw ] = intialprocess_SNP( data,D_number )
    triallength = length(data)/D_number;
    time = (1:triallength)';
    Response = data(1,1:triallength)';
    Force = data(1,((triallength)+1):(triallength*2))';
    Displacement = data(1,((2*triallength)+1):(triallength*3))';
    Allraw = table(time,Response,Force,Displacement);
 end

