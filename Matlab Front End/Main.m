clear all; close all; clc;

%% COnnection to Arduino:

if ~exist('megaSerial','var')
    
    megaSerial = serial('COM4','BAUD',9600);
    fopen(megaSerial);
    
elseif strcomp(megaSerial.status,'closed')
    fopen(megaSerial);
    
end

%% Joystick Setup:

joy = vrjoystick(1);

%% Main Loop:

% Define Initial Variables:

oldxaxis = 0;
oldyaxis = 0;
oldzaxis = 0;

oldActuatorUp = 0;
oldActuatorDown = 0;

oldpumpButt = 0;
oldheatButt = 0;

while true % Main Loop, Exit with ctrl + c
    
    
    % Update Joystick Readings:
    
    ax = axis(joy); % Get joystick axis readings
    butt = button(joy); % Get joystick button readings
    
    % Define axis readings:
    
    xaxis = ax(1);
    yaxis = -ax(2);
    zaxis = ax(5);
    
    ActuatorUp = butt(3);
    ActuatorDown = butt(6);
    
    pumpButt = butt(3);
    heatButt = butt(2);
    
    
    
    % Drive System:
    
    if xaxis == oldxaxis
        % No change
        oldxaxis = xaxis;
    else
        % Change
        driveupdate = 1;
        oldxaxis = xaxis;
    end
    
    
    
    if yaxis == oldyaxis
        % No change
        oldyaxis = yaxis;
    else
        % Change
        driveupdate = 1;
        oldyaxis = yaxis;
    end
    
    
    
    if zaxis == oldzaxis
        % No change
        oldzaxis = zaxis;
    else
        % Change
        driveupdate = 1;
        oldzaxis = zaxis;
    end
    
    
    
    if driveupdate = 1
        Stepper(megaSerial,xaxis,yaxis,zaxis);
        driveupdate = 0;
    end
    
    
    
    % Actuator:
    
    if ActuatorUp = oldActuatorUp
        % No change
        oldActuatorUp = ActuatorUp;
    else
        % Change
        Acutatorupdate = 1;
        oldActuatorUp = ActuatorUp;
    end
    
    
    
    if ActuatorDown = oldActuatorDown
        % No change
        oldActuatorDown = ActuatorDown;
    else
        % Change
        Actuatorupdate = 1;
        oldActuatorDown = ActuatorDown;
    end
    
    
    
    if Actuatorupdate = 1
        linActuator(megaSerial,ActuatorUp,ActuatorDown);
        Actuatorupdate = 0;
    end
    
    
    
    % Pump:
    
    if pumpButt == oldpumpButt
        % No change
        oldpumpButt = pumpButt;
    else
        % Change
        PumpUpdate = 1;
        oldpumpButt = 1;
    end
    
    
    
    if PumpUpdate = 1;
        Pump(megaSerial,pumpButt);
        oldpumpButt = 0;
    end
    
    
    
    % Heater:
    
    if heatButt = oldheatButt
        % No change
        oldheatButt = heatButt;
    else
        % Change
        HeatUpdate = 1;
        oldheatHutt = 1;
    end
    
    
    
    if HeatUpdate = 1
        Heater(megaSerial,heatButt)
        HeatUpdate = 0;
    end
end