classdef NEpump < handle
    properties
        Serial
    end
    
    methods 
        function obj = NEpump(COMport)
            obj.Serial = serial(COMport);
            obj.Serial.BaudRate = 19200;
            obj.Serial.StopBits = 1;
            obj.Serial.DataBits = 8;
            obj.Serial.Terminator = 'CR';
            fopen(obj.Serial);
            
            fprintf(obj.Serial,'FUN RAT');
        end
        
        function setFlowRate(obj,rate)
            command = ['RAT' num2str(rate) 'MM'];
            fprintf(obj.Serial,command);
            pause(0.01)
        end
        
        function setFlowForward(obj)
            command = 'DIR INF';
            fprintf(obj.Serial,command);
            pause(0.01)
        end
        
        function setFlowBackward(obj)
            command = 'DIR WDR';
            fprintf(obj.Serial,command);
            pause(0.01)
        end
        
        function startFlow(obj)
            command = 'RUN';
            fprintf(obj.Serial,command);
            pause(0.01);
        end
        
        function stopFlow(obj)
            command = 'STP';
            fprintf(obj.Serial,command);
            pause(0.01);
        end
    end
end
        