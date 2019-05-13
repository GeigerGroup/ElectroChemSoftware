%creates a class for Keithley Voltmeter

classdef Voltmeter < handle
    properties
        Visa
    end
    
    methods
        function obj = Voltmeter()
            obj.Visa = visa('ni','USB0::0x05E6::0x2100::1420633::0');
            obj.Visa.Timeout = 0.3;
            fopen(obj.Visa);
        end
        
        function data = getData(obj)
            str = query(obj.Visa,'READ?');
            
            %check if its a string
            if ischar(str)
                data = str2double(str);
            end
        end
        
        function close(obj)
            fclose(obj.Visa);
        end

    end
    
end

