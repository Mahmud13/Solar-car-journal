function [SOCn, Vt, I, R, Vd] = batteryParam(SOCo, Ich, Pin, temperature)

len = length(Pin);

dt = 1;
cap25 = 70*60*60;
cap = cap25*(0.0082*temperature+0.77);

VOC = 5*(1.46*SOCo+11.0233);
Vd = 5*(0.086*SOCo-0.011);
R = (-0.031*SOCo+0.077);
    
I = real(((VOC-Vd)-sqrt((VOC-Vd)^2-4*R*Pin))/(2*R))-Ich;
    
Vt = VOC-Vd-I*R;
Qdis = I*dt;
SOCn = SOCo - Qdis/cap;
if SOCn>=1
    SOCn = 1;
end
end