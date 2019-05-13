%Select which pump to use
pump = pump1;

%select flow rate
flowrate = 100;
pump.setFlowRate(flowrate);
pause(0.1)

%length of flow and pause
flowtime = 10;
pausetime = 10;

%number of repeats
numCycles = 5;

%for i = 1:numCycles
    %pump.setFlowForward();
    %pump.startFlow();
    %pause(flowtime);
    %pump.setFlowBackward();
    %pump.startFlow();
    %pause(flowtime);
    %pause(pausetime);
    %pump.stopFlow();
    %pause(pausetime);%
%end

%length of flow and pause
 flowtime1 = 20;
 pausetime1 = 20;
 flowtime2 = 20;
 pausetime2 = 20;

%number of repeats
 numCycles = 5;

 for i = 1:numCycles
     pump.setFlowForward();
     pump.startFlow();
     pause(flowtime1);
     pump.stopFlow();
     pause(pausetime1);
     pump.startFlow();
     pause(flowtime2);
     pump.stopFlow();
     pause(pausetime2);
 end