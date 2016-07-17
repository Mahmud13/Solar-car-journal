% Car characteristics
function [Power, Ich, I, R, Vd, Vm, SOC, Ga] = solarCar(month,mass,z, stops, isCloudy, isCloudFactor)

% Total length from home to office is 18 kilometers
totalLen = 18*1000;

% The temperature varies from month to month
Ta = [29 29 28 28 28 29 29 30 32 33 34 34 35 36 37 36 34 32 32 31 29 29 29 29];
T = [10 8 6 4 2 0 -2 0 4 6 8 10];
Ta = Ta-T(month);

% The function illumination calculates the illumination of a specific day,
% but we usually calculate the illumination for 15th of the month as an
% average for that month
[Ga SRT SST] = illumination(15, month, 2016, isCloudy, isCloudFactor);

% Sunrise time
SRT = round(SRT);

% Sunset time
SST = round(SST);

% Ga is considered zero until 8am
Ga(1:28800)=0;

% The terminal voltage is zero initially
VmInit = 0;

% The initial state of charge
SOCinit = .9;

% speed characteristic of the car
vin = [10 30 60 30 10].*1000/3600;
sinput = [0.05 (0.9-z)/2 z (0.9-z)/2 0.05]*totalLen;

% Calculating power required by DC motor
[Power vout sout] = powerRequired(stops,vin,sinput,mass);

for i = 1:86400
    f = ceil(i/3600);
    if i==1
        Ich(i) = panelCurrent(Ta(f),Ga(i),VmInit);
    elseif mod(i,120)==0
        Ich(i) = panelCurrent(Ta(f),Ga(i),VmInit);
    else
        Ich(i) = Ich(i-1);
    end
    [SOC(i), Vm(i), I(i), R(i), Vd(i)] = batteryParam(SOCinit, Ich(i), Power(i), Ta(f));
    SOCinit = SOC(i);
    VmInit = Vm(i);
end
end