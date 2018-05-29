clear all;
clc 
%% Init neccesary var and handles
% Make sure not to delete the serial handle megaSerial, it must always be
% closed before deleting with fclose(megaSerial). If you do not, you will
% have to restart matlab as it still has the serial port open
clear all;
close all;

if ~exist('megaSerial','var') % Check if it exists
    
    megaSerial = serial('COM4','BAUD',9600); % Create it if it does not
    fopen(megaSerial);
    
elseif strcmp(megaSerial.status,'closed') % Check if it is open or closed
   
    fopen(megaSerial); % Open if closed
    
end

% stopasync(megaSerial) % not sure why, but needed

i = 0; % variable to check when to send data
k = 1;
    %% Recieving Data
    
    %if megaSerial.BytesAvailable > 0
        
        raw_data = fscanf(megaSerial);
        
        data = strsplit(raw_data,'_');
        
      
       % for j = 1:2:length(data)
      
       for j = 1:2:100
            
        raw_data = fscanf(megaSerial);
        
        data(k) = strsplit(raw_data,'_');
            
%             if strcmp(data{j},'F')
%                 
%                  FOB = str2double(data{j+1});
%                  FOB_val(k) = FOB;
%                 
%             elseif strcmp(data{j},'C')
%                 
%                Current = str2double(data{j+1});
%                Current_val(k) = Current;
%                plot(Current_val);
%                ylabel('Power (Watt)');
%                xlabel('Time (seconds)');
%                pause(0.05); 
%             elseif strcmp(data{j},'T')
%                 
                Temp = str2double(data{k});
                Temp_val(k) = Temp;
                plot(Temp_val);
                
                ylabel('Temperature (Celcius)');
                xlabel('Time (seconds)');
                pause(0.05);
%              end
        
            k = k + 1;
        end
%     else
%         'error'
%     end