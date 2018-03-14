%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% YF2_Make_Add_Value_For_Print (3)
%  Yoshi Baba 2011/08/16 modify 2011/10/31
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This program add some value in each trace for print
%
function y= YF2_Make_Add_Value_For_Print(X,Input) 
%y= YF2_Make_Add_Value_For_Print(OUT_PUT_CS401,1);
[row, lin]=size(X);
OUT_PUT=[];
for i2=1:lin
      A=X(:,i2)+(i2-1)*Input;
      OUT_PUT=[OUT_PUT A];
end
y=OUT_PUT;
