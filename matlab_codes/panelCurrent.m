function [Im]= panelCurrent(Ta, Ga, VM)
q = 1.6e-19;
m = 1.36;
k = 1.38e-23;
C2 = 0.03;
C3 = -2.3e-3;
T0C = 25;
Ga0 = 1000;
Tc = Ta+C2*Ga;
Vtc = m*k*(273+Tc)/q;

Nsm = 180;
Npm = 1;
Pmax0M = 250;
Voc0M = 95;
Isc0M = 3.1;

Pmax0C = Pmax0M/(Nsm.*Npm);
Voc0C = Voc0M/Nsm;
Isc0C = Isc0M/Npm;

Vt0C = m.*k.*Tc/q;

Voc0 = Voc0C/Vt0C;
FF0 = Pmax0C/(Voc0C*Isc0C);
FF = (Voc0 - log(Voc0+0.72))/(Voc0+1);

RsC = (1-FF/FF0)*Voc0C/Isc0C;
RsM = RsC.*Nsm/Npm;
IscM = Ga/Ga0*Isc0C*Npm;
VocM = (Voc0C + C3.*(Tc-T0C))*Nsm;

syms x;
eqn = x == Npm.*IscM.*(1-exp((VM-VocM-RsM.*x)/(Nsm.*Vtc)));

Im = double(solve(eqn,x));