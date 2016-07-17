function [Gt, SRT, SST] = illumination(d, mo, y, isCloudy, isCloudFactor)

N1 = floor(275*mo/9);
N2 = floor((mo + 9) / 12);
N3 = (1 + floor((y - 4 * floor(y / 4) + 2) / 3));
n = N1 - (N2 * N3) + d - 30;

lattitude = 23.7;
longitude = 90.35;
del = 23.45*sin(360*pi/180/365*(n+284));
Ws = acos(-tan(lattitude*pi/180)*tan(del*pi/180))*180/pi;
AST = 720-Ws*4;
LSTM = 15*round(longitude/15);
D = 360*pi/180*(n-80)/365;
ET = 9.87*sin(2*D)-7.53*cos(D)-1.5*sin(D);
SRT= AST-4*(LSTM-90.25)-ET;
SRT = SRT*60;

del = 23.45*sin(360*pi/180/365*(n+284));
Ws = -acos(-tan(lattitude*pi/180)*tan(del*pi/180))*180/pi;
AST = 720-Ws*4;
LSTM = 15*round(longitude/15);
D = 360*pi/180*(n-80)/365;
ET = 9.87*sin(2*D)-7.53*cos(D)-1.5*sin(D);
SST = AST-4*(LSTM-90.25)-ET;
SST = SST*60;

Gt = zeros(86400,1);

for i = 1:86400
    G0 = 1160 + sind(360*(n-275)/365);
    
    k = 0.174+0.035*sind(360*(n-100)/365);
    
    L = 23.7;
    
    delta = 23.45*sind(360*(284+n)/365.25);
    
    mid = (SRT+SST)/2;
    
    H = -15*(i-mid)/3600;
    
    sinbeta = cosd(L)*cosd(delta)*cosd(H) + sind(L)*sind(delta);
    
    beta = asind(sinbeta);
    
    if beta>0
        Gb = G0*exp(-k/sind(beta));
        phiS = asind(cosd(delta)*sind(H)/cosd(beta));
        phiP = 23.7;
        phi = 0;
        
        costheta = cosd(beta)*cosd(phiS - phiP)*sind(phi) + sind(beta)*cosd(phi);
        theta = acosd(costheta);
        
        Gbs = Gb.*cosd(theta);
        
        S = 0.095 + 0.04*sind(360*(n-100)/365);
        Gdp = S*Gb*((1+cosd(phi))/2);
        
        rho = 0.55;
        Grp = rho*Gb*(sind(beta)+S)*(1-cosd(phi))/2;
        
    else
        Gbs = 0;
        Gdp = 0;
        Grp = 0;
    end
    if isCloudy
        Gt(i,1) = Gdp + Grp;
    elseif isCloudFactor
        Gt(i,1) = Gbs + Gdp + Grp;
        switch mo
            case {12, 2, 5, 8, 9}
                Gt(i,1) = Gt(i,1)*.7;
            case {1, 6, 7}
                Gt(i,1) = Gt(i,1)*.6;
            case {3, 11}
                Gt(i,1) = Gt(i,1)*.75;
            case {4, 10}
                Gt(i,1) = Gt(i,1)*.8;
        end
    else
        Gt(i,1) = Gbs + Gdp + Grp;
    end
end

