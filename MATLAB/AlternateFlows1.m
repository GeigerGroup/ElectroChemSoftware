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
time =20;

%flow rate mL/min
pump1.setFlowRate(50);
pump2.setFlowRate(50);

%number of intervals
numCycles = 15;

for i = 1:numCycles
    pump1.startFlow();
    pause(time)
    pump1.stopFlow();
    pump2.startFlow();
    pause(time)
    pump2.stopFlow();
end
