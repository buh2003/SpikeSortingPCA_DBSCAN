function [ output ] = Convert_for_plot( input, spacing_value )
%function y= YF2_Make_Add_Value_For_Print(X,Input) 
%y= YF2_Make_Add_Value_For_Print(OUT_PUT_CS401,1);
output = [];
for i = 1:size(input,2)
      A = input(:,i)+(i-1)*spacing_value;
      output = [output A];
end
end

