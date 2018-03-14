%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 06.08.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Eliminate spikes with overlapping latency
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ output ] = Eliminate_Overlapping_SNP( INPUT, Check_Point, Cut_Point, Put_Point, Put_Number )
%Y=YF2_SP01_Eliminate_ShotLatency(SP01_S_SHAPE_ANA01, 62, 20,63,-1);
CP=Check_Point; %Check point in INPUT
CUT=Cut_Point;%Check number in Check pont in INPUT
PP=Put_Point;   %Put point in result file
PN=Put_Number;  %Put number in the point in result file
[row, lin]=size(INPUT); 
X = INPUT;
count=0;  
PreP=1;
for ii=1:lin
  tX=INPUT(CP,ii);
  L=tX-PreP;
  if (L<=CUT)
      X(PP,ii)=PN;
  end
  PreP=tX;
end
output=X;
end

