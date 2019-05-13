%creates a class for Keithley Ammeter

classdef Ammeter < handle
    properties
        GPIB
    end
    
    methods
        function obj = Ammeter()
            obj.GPIB = gpib('Keithley',0,14);
            obj.GPIB.Timeout = 1;
            fopen(obj.GPIB);
            
            %reset
            obj.sendComm('*RST')
            
            %set rate
            obj.setRate(1);
            
            %set range
            obj.setRange(' 2E-6')
            
            %turn zero check off
            obj.setZeroCheck(false)

        end
        
        %get data from the instrument
        function data = getData(obj)
            str = query(obj.GPIB,'READ?');
            
            %check if its a string
            if ischar(str)
                data = strsplit(str,',');
                %make sure it is in expected format
                if length(data) == 3
                    data = data{1};
                    data = str2num(data(1:end-1)); %#ok<ST2NM>
                end
            end
        end
        
        %turns zero check on and off. zerocheck should be on when you are
        %making and breaking connections
        function setZeroCheck(obj,mode)
            if mode
                obj.sendComm('SYST:ZCH ON')
            else
                obj.sendComm('SYST:ZCH OFF')
            end
        end
        

        function setRate(obj,rate)
            obj.sendComm(['SENS:CURR:NPLC ' num2str(rate)]);
        end    
        
        function setRange(obj,range)
            %string must be {':AUTO 1', ' 2E-9',' 2E-8',' 2E-7',' 2E-6',
            %' 2E-5',' 2E-4',' 2E-3',' 2E-2'};
            str = ['SENS:CURR:RANG' range];
            obj.sendComm(str);
        end
        
        %check if object is connected by asking for its information
        function check(obj)
            str = query(obj.GPIB,'*IDN?');
            disp(str)
        end
        
        %communication functions to read and respond
        function sendComm(obj,str)
            fprintf(obj.GPIB,str);
        end
        
        function resp = readResp(obj)
            resp = fscanf(obj.GPIB);
        end
        
        %close out GPIB object
        function close(obj)
            fclose(obj.GPIB);
        end
    end
end
        