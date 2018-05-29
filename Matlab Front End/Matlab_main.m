%% Init neccesary var and handles
% Make sure not to delete the serial handle megaSerial, it must always be
% closed before deleting with fclose(megaSerial). If you do not, you will
% have to restart matlab as it still has the serial port open
close all;
clear all;

if ~exist('megaSerial','var') % Check if it exists
    
    megaSerial = serial('COM7','BAUD',9600); % Create it if it does not
    fopen(megaSerial);
    
elseif strcmp(megaSerial.status,'closed') % Check if it is open or closed
   
    fopen(megaSerial); % Open if closed
    
end

% stopasync(megaSerial) % not sure why, but needed


joy = vrjoystick(1); % init controller handle


i = 0; % variable to check when to send data
k = 1;

%% The loop of the program, to exit ctl c
while true
        
    
    ax = axis(joy); % Returns axis readings of controller
    butt = button(joy); % Returns buttons being pressed
   
    xaxis = ax(1); % seperate each axis
    yaxis = -ax(2);
    zaxis = ax(5);
    
    Lbutt1 = butt(5);
    Lbutt2 = butt(6);
    
    pumpButt = butt(3);
    
    heatButt = butt(2);
    
    plot(xaxis,yaxis,'+'); % plot for visual
    axis([-1 1 -1 1])
    pause(.01)
    
    
    %% Sending Data
    
    if rem(i,20) == 0 % Send data only when i is a multiple of x

        Stepper(megaSerial,xaxis,yaxis,zaxis); % to send commands to steppers

        linAct(megaSerial,Lbutt1,Lbutt2); % Send Command to linAct
        
        Pump(megaSerial,pumpButt); % Send Command to pump
        
        Heater(megaSerial,heatButt); % Send  Command to heater
        
        i = 0;
        
    end
    
    i = i + 1;
    
    
    %% Recieving Data
%     
%     if megaSerial.BytesAvailable > 0
%         
%         raw_data = fscanf(megaSerial);
%         
%         data = strsplit(raw_data,'_');
%         
%       
%         for j = 1:2:length(data)
%             
%             
%             
%             if strcmp(data{j},'F')
%                 
% %                 FOB = str2double(data{j+1});
% %                 FOB_val(k) = FOB;
%                 
%             elseif strcmp(data{j},'C')
%                 
% %                 Current = str2double(data{j+1});
% %                 Current_val(k) = Current;
%                 
%             elseif strcmp(data{j},'T')
%                 
%                 Temp = str2double(data{j+1});
%                 Temp_val(k) = Temp;
%                 
%                 time = 0:1:100;
%                 plot(time,Temp);
%                 ylabel('Celcius');
%                 
%             end
%             
%         end
%         
%         k = k + 1;
%         
%     end
    
end
% 
%     for num = 2:100
%                         xaxis(k) = ax(1); % seperate each axis
%                 yaxis(k) = -ax(2);
%                 zaxis(k) = ax(5);
%         while length(xaxis) > 1
%             if xaxis(k) ~= xaxis(num-1) && yaxis(k) ~= yaxis(num-1) && zaxis(k) ~= zaxis(num-1)
%                 xaxis(k) = ax(1); % seperate each axis
%                 yaxis(k) = -ax(2);
%                 zaxis(k) = ax(5);
%             end
%         end
%     end

    
    