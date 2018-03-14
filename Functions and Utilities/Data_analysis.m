%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Skin Nerve Data Analysis Software
% Ben Hoffman
% 08.24.16
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Data analysis function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ IFF_out, IFF_no_zero_out, rISI_ALL, rISI_DETAL ] = Data_analysis( Output_R_boolean, Disp_points, SampleF )
Period_DSE = [20000 1000;40001 50000; 0 30000]; %2-4.5sec %for end of static (B file)

X=Output_R_boolean; [row, lin]=size(X);OUT_PUT_FRQ=zeros(row,lin);
Peak_D = Disp_points;
PD=Disp_points;[rowPD, linPD]=size(PD);
rISI=[];rISI_ALL=[];OUT_PUT_FRQ_no_Zero=[];
tALLISI=[];tRISI=[];tAISI=[];tEISI=[];STIMULUS_PERIOD=[];
ALL_RESULT=[];
%%%%%%%%%%%%%% Begine Make ISI file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
for i01=1:lin
    count=0;Pre=0;ISI=[];Init_Spk_P=0;
    tOUT_PUT_FRQ_no_Zero=[i01 0 0 0];
    OUT_PUT_FRQ_no_Zero=[OUT_PUT_FRQ_no_Zero; tOUT_PUT_FRQ_no_Zero];
    for i02=1:row 
     ATAI=X(i02,i01);  
     if (ATAI==1)&(Pre==0)
          count=count+1;Pre=i02;
          tOUT_PUT_FRQ_no_Zero=[i01 i02 0 0];
          OUT_PUT_FRQ_no_Zero=[OUT_PUT_FRQ_no_Zero; tOUT_PUT_FRQ_no_Zero];
     elseif (ATAI==1)&(Pre>1)
          count=count+1;ttISI=i02-Pre;Pre=i02;
          Frq=SampleF/ttISI;OUT_PUT_FRQ(i02,i01)=Frq;
          tOUT_PUT_FRQ_no_Zero=[i01 i02 Frq ttISI];
          OUT_PUT_FRQ_no_Zero=[OUT_PUT_FRQ_no_Zero; tOUT_PUT_FRQ_no_Zero];  
     end
    end
end
Y01=OUT_PUT_FRQ_no_Zero;
%%%%%%%%%%%%%%%% End Make ISI file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% Start Make Analyzed period file %%%%%%%%%%%%%%%%%%%%%%%
[row_Y01, lin_Y01]=size(Y01);
LCOUNT=0;LCOUNT_TEST=[];tLCOUNT_TEST=[];
COUNT=0;COUNT_TEST=[];tCOUNT_TEST=[];
for i03=1:row_Y01
    A01=Y01(i03,1);A02=Y01(i03,2);A03=Y01(i03,3); A04=Y01(i03,4);
    if ((A02==0)&&(A03==0)&&(A04==0))
        LCOUNT=LCOUNT+1;
        LCOUNT_TEST=[LCOUNT_TEST; A01];
    end
end

for i03=1:LCOUNT
    LA01=LCOUNT_TEST(i03,1); ttSP=0;ttEP=0;COUNT=0;COUNT2=0;
    for i03b=1:row_Y01  
        A01=Y01(i03b,1);A02=Y01(i03b,2);A03=Y01(i03b,3); A04=Y01(i03b,4);
        if ((A01==LA01)&&(A02==0))
            ttSP=i03b;
        elseif((A01>LA01)&&(A02==0)&&(ttEP==0))
            ttEP=i03b-1;
        end
    end
    if (LA01==LCOUNT)
        tCOUNT_TEST=[LA01 ttSP row_Y01 row_Y01-ttSP];
    else
        tCOUNT_TEST=[LA01 ttSP ttEP ttEP-ttSP];
    end
    COUNT_TEST=[COUNT_TEST;tCOUNT_TEST];  
end

Y03=COUNT_TEST;
%%%%%%%%%% End Make Analyzed period file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% Start Analyzing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
DET_RESULT=[];
[row_Y03, lin_Y03]=size(Y03);
for i05=1:row_Y03
    Y03_01=Y03(i05,1);%Stimulus #
    Y03_02=Y03(i05,2);%Start Point
    Y03_03=Y03(i05,3);%End Point
    Y03_04=Y03(i05,4);% # of spikes
    
    PD01=Peak_D(i05,1);% Starting Ris point
    PD02=Peak_D(i05,2);% Arrive setting point
    PD03=Peak_D(i05,3);% Starting Pull movement
    PD04=Peak_D(i05,4);% Arriving initial point
    
    DSE_11=Period_DSE(1,1);DSE_12=Period_DSE(1,2); %Dynamic phase information
    DSE_21=Period_DSE(2,1);DSE_22=Period_DSE(2,2); %Static phase infomation
    DSE_31=Period_DSE(3,1);DSE_32=Period_DSE(3,2); %End phase infomation
    
    %%%%%%%%%%%%%%%%%%%% ISIs in ALL period %%%%%%%%%%%%%%%%%%%%%%%%%%
    tAve=0; tSD=0; tCOV=0; tMed=0; tMin=0; tMax=0;tNoS=0;
    if (Y03_04<2)
        tALL_RESULT=[Y03_01 Y03_04 tAve tSD tCOV tMin tMed tMax tNoS];
        ALL_RESULT=[ALL_RESULT; tALL_RESULT];
    else
        tAve=mean(Y01( Y03_02+2:Y03_03,4)/SampleF*1000); 
        tSD=std(Y01( Y03_02+2:Y03_03,4)/SampleF*1000);
        tCOV=0; 
        tMin=min(Y01( Y03_02+2:Y03_03,4)/SampleF*1000); 
        tMed=median(Y01( Y03_02+2:Y03_03,4)/SampleF*1000); 
        tMax=max(Y01( Y03_02+2:Y03_03,4)/SampleF*1000); 
        tNoS=Y03_03-Y03_02-1;
             if (tAve>0)
                 tCOV=tSD/tAve;
             end
        tALL_RESULT=[Y03_01 Y03_04 tAve tSD tCOV tMin tMed tMax tNoS];
        ALL_RESULT=[ALL_RESULT; tALL_RESULT];
     end
     %%%%%%%%%%%%%% END ISIs in ALL period %%%%%%%%%%%%%%%%%%%%%%%%%%
     
     %%%%%%%%%%%%%%%% Start detail analysis %%%%%%%%%%%%%%%%%%%%%%%%%
     if (Y03_04>1) % Analyzing the data having two spikes
         
        DYNMIC=[];
        STATIC=[];
        END=[];
        DtoE=[];
        Point_Dyn=-1;Point_Sta=-1;Point_End=-1;Point_DtoE=-1;%Point duration 

        %%%%%%%%%%%%%%%%%%%%%% Check period %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        SP_dyn=PD02-DSE_11;   EP_dyn=PD02+DSE_12; PP_dyn=EP_dyn-SP_dyn;
        SP_sta=EP_dyn+DSE_21; EP_sta=SP_sta+DSE_22; PP_sta=EP_sta-SP_sta;
        SP_end=PD03+DSE_31;   EP_end=SP_end+DSE_32; PP_end=EP_end-SP_end;
        PP_DroE=EP_end-SP_dyn;
        Count_dyn=0; Count_sta=0;Count_end=0;Count_DtoE=0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        tX02=Y01(Y03_02+1,2);
        if ((tX02>=SP_dyn)&(tX02<EP_dyn))%Count dynamic spikes
            Count_dyn=Count_dyn+1;
        elseif((tX02>=SP_sta)&(tX02<EP_sta))%Count Static spikes
            Count_sta=Count_sta+1;
        elseif ((tX02>=SP_end)&(tX02<EP_end))%Count End spikes
            Count_end=Count_end+1;
        end

        for i06=Y03_02+2:Y03_03
            tX02=Y01(i06,2);tX04=Y01(i06,4); 
            if ((tX02>=SP_dyn)&(tX02<EP_dyn))%Pick up dynamic ISIs
                DYNMIC=[DYNMIC;tX04/SampleF*1000];
                Count_dyn=Count_dyn+1;
            elseif ((tX02>=SP_sta)&(tX02<EP_sta))%Pick up Static ISIs
                STATIC=[STATIC;tX04/SampleF*1000];
                Count_sta=Count_sta+1;
            elseif ((tX02>=SP_end)&(tX02<EP_end))%Pick up End ISIs
                END=[END;tX04/SampleF*1000];
                Count_end=Count_end+1;
            end
            if ((tX02>=SP_dyn)&(tX02<EP_end))%Pick up Dynamic to End ISIs
                DtoE=[DtoE;tX04/SampleF*1000];
                Count_DtoE=Count_DtoE+1;
            end   
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % All data are converted into time (msec)
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%% Cal Dynamic 
        tAve=0; tSD=0; tCOV=0; tMed=0; tMin=0; tMax=0;tNoS=0;
        ZZ=DYNMIC;
        [row_tR, lin_tR]=size(ZZ);  
        if (row_tR>0)
            tAve=mean(ZZ); tSD=std(ZZ); tMed=median(ZZ); tMin=min(ZZ); tMax=max(ZZ);tNoS=Count_dyn;
            if (tAve>0)
                tCOV=tSD/tAve;
            end
        end
        tDYN_RESULT=[0 tNoS tAve tSD tCOV tMin tMed tMax PP_dyn ];
        
        %%%%%%%%%%% Cal Static
        tAve=0; tSD=0; tCOV=0; tMed=0; tMin=0; tMax=0;tNoS=0;
        ZZ=STATIC;
        [row_tR, lin_tR]=size(ZZ);  
        if (row_tR>0)
            tAve=mean(ZZ); tSD=std(ZZ); tMed=median(ZZ); tMin=min(ZZ); tMax=max(ZZ);tNoS=Count_sta;
            if (tAve>0)
                tCOV=tSD/tAve;
            end
        end
        tSTA_RESULT=[0 tNoS tAve tSD tCOV tMin tMed tMax PP_sta ];

        %%%%%%%%%%% Cal End
        tAve=0; tSD=0; tCOV=0; tMed=0; tMin=0; tMax=0;tNoS=0;
        ZZ=END;
        [row_tR, lin_tR]=size(ZZ);  
        if (row_tR>0)
            tAve=mean(ZZ); tSD=std(ZZ); tMed=median(ZZ); tMin=min(ZZ); tMax=max(ZZ);tNoS=Count_end;
            if (tAve>0)
                tCOV=tSD/tAve;
            end
        end
        tEND_RESULT=[0 tNoS tAve tSD tCOV tMin tMed tMax PP_end ];

        %%%%%%%%%%% Cal Start to end
        tAve=0; tSD=0; tCOV=0; tMed=0; tMin=0; tMax=0;tNoS=0;
        ZZ=DtoE;
        [row_tR, lin_tR]=size(ZZ);  
        if (row_tR>0)
            tAve=mean(ZZ); tSD=std(ZZ); tMed=median(ZZ); tMin=min(ZZ); tMax=max(ZZ);tNoS=Count_DtoE;
            if (tAve>0)
                tCOV=tSD/tAve;
            end
        end
        tDtoE_RESULT=[0 tNoS tAve tSD tCOV tMin tMed tMax PP_DroE ];
        
    elseif (Y03_04==1) % 1 spike
        tDET_RESULT=zeros(1,36);tDtoE_RESULT=[0 1 0 0 0 0 0 0 0 ];tEND_RESULT=[0 0 0 0 0 0 0 0 0 ];
        tSTA_RESULT=[0 0 0 0 0 0 0 0 0 ]; tDYN_RESULT=[0 0 0 0 0 0 0 0 0 ];
        %ALL_RESULT=[
     else % 0 spike
        tDET_RESULT=zeros(1,36);tDtoE_RESULT=[0 0 0 0 0 0 0 0 0 ];tEND_RESULT=[0 0 0 0 0 0 0 0 0 ];
        tSTA_RESULT=[0 0 0 0 0 0 0 0 0 ]; tDYN_RESULT=[0 0 0 0 0 0 0 0 0 ];%ALL_RESULT=
    end
        
    tDET_RESULT=[tDtoE_RESULT tDYN_RESULT tSTA_RESULT tEND_RESULT];
    
    DET_RESULT=[DET_RESULT;tDET_RESULT];
    
end

rISI_DETAL=DET_RESULT;
rISI_ALL=[ALL_RESULT DET_RESULT];

y=rISI_ALL;

IFF_out = OUT_PUT_FRQ;
IFF_no_zero_out = OUT_PUT_FRQ_no_Zero; 
end