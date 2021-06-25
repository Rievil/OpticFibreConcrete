
obj=ArduinoObj(25);

OpenConnection(obj);
%%

%%
GoDark(obj);
%%
LightUp(obj);
pause(0.5);
arr=zeros(100,1);
T=timetable;
for i=1:1000
    CheckRezistance(obj);
%     disp(obj.State);
    val=str2double(replace(obj.State,"Resistance: ",""));
    arr(i,1)=val;
    time=datetime(now(),'ConvertFrom','datenum');
    T=[T; timetable(val,'RowTimes',time)];
%     pause(0.1);
end
GoDark(obj);
beep;
%%
CloseConnection(obj);
%%
fig=figure;
subplot(2,1,1);
plot(arr);
subplot(2,1,2);

timeArr=seconds(duration(T.Time-T.Time(1)));

plot(timeArr,T.val);
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
plot(timeArr,arr);
plot(timeArr,newy,'-r','LineWidth',1.5);
%%
save('PhotorezistorMeasurement.mat','T');
%%
load('PhotorezistorMeasurement.mat');
%%
tst = arduino