function [Power, vout, sout, P] = powerRequired(stops,vin, sinput,m)

t = 0;
%vin = [10 30 60 30 10].*1000/3600;
totalLen = 18*1000;
%sinput = [0.05 (0.9-z)/2 z (0.9-z)/2 0.05]*totalLen;
%sinput = [0.05  0.9 0.05]*totalLen;
len = length(vin);
delT = 0;
totalLen = 18*1000;
vthr = 30*1000/3600;
splitNum = stops;

for i=1:len
    for j = (i-1)*splitNum+1:i*splitNum
        vi(j) = vin(i);
        si(j) = sinput(i);
    end
end
len = length(vi);
for i=1:len
    v(2*i-1) = vi(i);
    s(2*i-1) = si(i)/splitNum;
    restTime(2*i-1) = 0;
    if i~=len
        v(2*i)= 0;
        s(2*i) = 0;
        restTime(2*i) = delT;
    end
end

vmax = 60*1000/3600;
tmax = 1.5*60;
am = vmax/tmax;

Tf = 0;

numOfStamp = length(v);
for i=1:numOfStamp
    a = am*v(i)/vmax;
    if v(i)==0
        t(i)=restTime(i);
    else
        u = 0;
        tr(i) = (v(i)-u)/a;
        sr(i) = 0.5*a*tr(i)^2;
        sc(i) = s(i)-2*sr(i);

        tf(i) = tr(i);

        tc(i) = sc(i)/v(i);
        t(i) = (tr(i)+tf(i)) + tc(i);
    end
    Tf = Tf+t(i);
end
ts(1) = 0;
for i = 2:numOfStamp+1
    ts(i) = ts(i-1)+t(i-1);
end

g = 9.8;
Crr = 0.02;
Cd = 0.35;
A = 1.1;
density = 1.2;
sout(1) = 0;
for i=1:numOfStamp
    a = am*v(i)/vmax;
    for t = floor(ts(i))+1:floor(ts(i+1))
        if t<ts(i)+tr(i)      
            P(t) = m*a^2*(t-ts(i)) + m*g*Crr*a*(t-ts(i)) + 0.5*Cd*A*density*a^3*(t-ts(i))^3;
            vout(t) = a*(t-ts(i))*3600/1000;
            
        elseif t<ts(i+1)-tf(i)
            P(t) =  m*g*Crr*v(i) + 0.5*Cd*A*density*v(i)^3;
            vout(t) = v(i)*3600/1000;
        else
            P(t) = 0;
            vout(t) = a*(ts(i+1)-t)*3600/1000;
        end 
        sout(t+1) = sout(t)+vout(t)*1000/3600;
    end
end

temp = sout;
length(temp);
sout = zeros(1,length(temp)-1);
sout = temp(2:length(temp));
len = length(P);

Power1(1:28800) = 0;
Power1((1:len)+28800) = P;
Power1(28800+len+1:61200) = 0;
Power1(61201:61200+len) = P;
Power1(61200+len:86400)=0;
Power = Power1;

%Power = timeseries(P','Name','Power');
assignin('base','Vout', vout);