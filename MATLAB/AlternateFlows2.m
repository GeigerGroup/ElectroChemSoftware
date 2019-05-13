% %%%ISMATEC%%%
% 
% %channels
% chA = 2;
% chB = 3;
% 
% %set flow rate
% rate = 20;
% pump.setFlowRate(chA,rate)
% pump.setFlowRate(chB,rate)
% 
% %time to alternate in seconds
% time =5;
% 
% %number of intervals
% numCycles = 5;
% 
% for i = 1:numCycles
%     pump.startFlow(chA);
%     pause(time)
%     pump.stopFlow(chB);
%     pump.startFlow(chB);
%     pause(time)
%     pump.stopFlow(chB);
% end

%%%NEW ERA%%%

%time to alternate in seconds
time =5;

%flow rates
slowRate = 100;
fastRate = 25;

%number of intervals
numCycles = 2;

for i = 1:numCycles
    pump1.setFlowRate(fastRate);
    pump2.setFlowRate(slowRate);
    pump1.startFlow();
    pump2.startFlow();
    pause(time)
    pump1.stopFlow();
    pump2.stopFlow();
    pump1.setFlowRate(slowRate);
    pump2.setFlowRate(fastRate);
    pump1.startFlow();
    pump2.startFlow();
    pause(time)
    pump1.stopFlow();
    pump2.stopFlow();
end

