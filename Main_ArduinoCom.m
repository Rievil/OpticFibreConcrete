
obj=ArduinoObj(25);

OpenConnection(obj);
%%
LightUp(obj);
%%
GoDark(obj);
%%
samplearr=[1000];
mT=table;
LightUp(obj);
pause(5);
for j=1:numel(samplearr)
    
    
    arr=zeros(100,1);
    T=timetable;
    for i=1:samplearr(j)
        CheckRezistance(obj);

        val=str2double(replace(obj.State,"Resistance: ",""));
        arr(i,1)=val;
        Time=datetime(now(),'ConvertFrom','datenum');
        T=[T; timetable(val,'RowTimes',Time,'VariableNames',{'Signal'})];

    end
%     
    
    mT=[mT; table(samplearr(j),Time(end),{T},'VariableNames',{'Samples','Length','Signal'})];
end
GoDark(obj);
beep;
%%
CloseConnection(obj);
%%
fig=figure;
hold on;
for i=1:size(mT,1)
    color=lines(size(mT,1));
    x=seconds(duration(mT.Signal{i}.Time-mT.Signal{1}.Time(1)));
    y=mT.Signal{i}.Signal;
    
    scatter(x,y,'.','MarkerEdgeColor',color(i,:),'HandleVisibility','off');
    options = fitoptions('Method','LinearLeastSquares');
    [fitobj,gof]= fit(x,y,'exp2');
    newy=fitobj(x);
    plot(x,newy,'-','LineWidth',1.5,'Color',color(i,:),'DisplayName',sprintf('Měření: %d',i));
end
ylim([0,1024]);
legend;
%%

timeArr=seconds(duration(T.Time-T.Time(1)));
% arr=smooth(T.val);
arr=T.val;

options = fitoptions('Method','LinearLeastSquares');
[fitobj,gof]= fit(timeArr,arr,'exp2');

%%
figure;
hold on;
newy=fitobj(timeArr);
plot(timeArr,arr,'-');
plot(timeArr,newy,'-r','LineWidth',1.5);
%%
save('PhotorezistorMeasurement.mat','T');
%%
load('PhotorezistorMeasurement.mat');
%%
tst = arduino