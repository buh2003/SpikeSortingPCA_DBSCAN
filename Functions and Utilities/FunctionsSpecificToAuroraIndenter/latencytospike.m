function [latencies] = latencytospike( Disp_points, Output_R_boolean, samplerate )
trials=size(Disp_points,1);
latencies=NaN(trials,1);
for i=1:trials
    templatency=find(Output_R_boolean(Disp_points(i,1):Disp_points(i,4),i),1);
    if isempty(templatency)==0
        latencies(i,1)=templatency/(samplerate/1000);
    end
end
end

