json = loadjson('..\inputs\100.json')
%ecgData = M(:,1);
ecgData = json.input.ecgbaseline +1;
rpeaks =  json.input.rpeaks + 1;
qrsEnd = json.input.qrsend + 1;
tpeaks = json.input.tpeak +1;

ecgData = ecgData;

ws = warning('off','all');
tic
[starts ends p4s p3s p2s p1s typy nachylenia epizody]= run(ecgData, rpeaks, tpeaks, qrsEnd);
toc
plot (ecgData);
hold on
plot ( starts, ecgData(starts), 'r*');
plot ( ends, ecgData(ends), 'y*');
plot ( p1s, ecgData(p1s), 'bo');
plot ( p2s, ecgData(p2s), 'go');
plot ( p3s, ecgData(p3s), 'ro');
plot ( p4s, ecgData(p4s), 'yo');
plot ( tpeaks, ecgData(tpeaks), 'black o');
plot ( qrsEnd, ecgData(qrsEnd), 'black o');
matlab1 = sum(typy(:)==1)
matlab2 = sum(typy(:)==2)
matlab3 = sum(typy(:)==3)
matlab4 = sum(typy(:)==4)
matlab5 = sum(typy(:)==5)
matlab6 = sum(typy(:)==6)
matlab0 = sum(typy(:)==0)


% cpp1 = sum(json.output.types(:)==1)
% cpp2 = sum(json.output.types(:)==2)
% cpp3 = sum(json.output.types(:)==3)
% cpp4 = sum(json.output.types(:)==4)
% cpp5 = sum(json.output.types(:)==5)
% cpp6 = sum(json.output.types(:)==6)
% cpp0 = sum(json.output.types(:)==0)



hold off;