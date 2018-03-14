function [ output ] = join_COVdata( NoTrials, data1, data2, data3 )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    if NoTrials > 1
        join1_2 = [data1;data2];   
    end
    if NoTrials > 2
        join1_2_3 = [join1_2;data3];
    end
    if NoTrials == 1
        output = data1;   
    end
    if NoTrials == 2
        output = join1_2;
    end
    if NoTrials == 3
        output = join1_2_3;
    end
end

