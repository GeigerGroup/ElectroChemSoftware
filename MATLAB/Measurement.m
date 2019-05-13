classdef Measurement < handle
    properties
        Name
        Timer
        TimeInterval
        Data
        Instrument
        PointNumber
        Figure
        LineHandle
    end
    
    methods
        function obj = Measurement(name,instr,time)
            obj.Name = name;
            obj.Instrument = instr;
            obj.TimeInterval = time;
            
            %create timer
            obj.Timer = timer;
            obj.Timer.StartFcn = @(~,~) disp('Measurement started.');
            obj.Timer.TimerFcn = {@(~,~,obj) obj.getData, obj}; 
            obj.Timer.StopFcn = @(~,~) disp('Measurement stopped.');
            obj.Timer.Period = time;
            obj.Timer.StartDelay = time;
            obj.Timer.ExecutionMode = 'fixedRate';
            
            obj.PointNumber = 1;
            
            obj.Data = NaN(100,2);
           
        end
        
        function startMeasurement(obj)
            %start timer
            start(obj.Timer);
            
            obj.Figure = figure;
            obj.LineHandle = plot(0,0);
            obj.LineHandle.XData = [];
            obj.LineHandle.YData = [];
        end
        
        function getData(obj)
            reading = obj.Instrument.getData();
            
            %check that it got a number
            if isnumeric(reading)
                time = obj.PointNumber*obj.TimeInterval;
            
                % double matrix size if got two big
                if obj.PointNumber > length(obj.Data)
                    obj.Data = vertcat(obj.Data,NaN(length(obj.Data),2));
                end
            
                %add to data matrices
                obj.Data(obj.PointNumber,1) = time;
                obj.Data(obj.PointNumber,2) = reading;
                
                if mod(obj.PointNumber*obj.TimeInterval,1) == 0
                    %update plot
                    obj.LineHandle.XData = obj.Data(:,1);
                    obj.LineHandle.YData = obj.Data(:,2);
                end
            
                %iterate point number
                obj.PointNumber = obj.PointNumber +1;
            else
                return
            end
        end
        

        
        function pauseMeasurement(obj)        
            %stop timer
            stop(obj.Timer);      
        end
        
        function resumeMeasurement(obj)
            %start timer
            start(obj.Timer);  
        end
        
        function stopMeasurement(obj)
            %stop and delete timer
            stop(obj.Timer);
            delete(obj.Timer);
        end
            
            
    end
    
end

