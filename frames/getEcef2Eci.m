function R_ECI_ECEF = getEcef2Eci(UTC,UTC2TAI)
% Converts ICRF to ITRF or vice versa. 
% UTC2TAI is the number of seconds between UTC and TAI (positive #)

%% Populate important coefficients
global prev_diff cs xp yp UTC_off
UTC_start = date2jed(datenum('01-Jan-1992'));
if isempty(cs) || abs(floor(UTC-UTC_start) - floor(prev_diff))>0
    prev_diff = UTC-UTC_start;
    % Get nutation coefficients
    fid = fopen('nut80.dat','r');
    fspec = '%d %d %d %d %d %f %f %f %f %d';
    cs = fscanf(fid,fspec,[10,106])'; 
    fclose(fid);

    % Get correct IERS data
    fid = fopen('iers2.dat','r');
    for i=0:(UTC-UTC_start-1)
        fgetl(fid);
    end
    line = fgetl(fid);
    lineArr = strsplit(line,'I');
    vals = str2num(lineArr{4}); %#ok<ST2NM>
    UTC_off = vals(7);
    xp = vals(5);
    yp = vals(6);
    fclose(fid);
end

%% Get times
arcsec2rad = pi/180/3600;
TAI = UTC + UTC2TAI/24/60/60; 
TT = TAI + 32.184/24/60/60;
UT1 = UTC + UTC_off/24/60/60;
J2000 = 2451545;

%% Precession
T_TT = (TT - J2000)/36525;
%m = 6.24035939+628.301956*T_TT;
t = T_TT;% + .001658/24/60/60*sin(m)+.00001385*sin(2*m);
tVec = [t;t^2;t^3];
a = [2306.2181,.30188,.017998]*tVec*arcsec2rad;
b = [2004.3109,-.42665,-.041833]*tVec*arcsec2rad;
c = [2306.2181,1.09468,.018203]*tVec*arcsec2rad;
P = getFullRotationMatrix([-a,b,-c],[3,2,3]);
P = orthodcm(P);

%% Nutation
mm = (134.96298139+[(1325*360+198.8673981),.0086972,1.78e-5]*tVec)*pi/180;
ms = (357.52772333+[(99*360+359.05034),-.0001603,-3.3e-6]*tVec)*pi/180;
um = (93.27191028+[(1342*360+82.0175381),-.006825,3.1e-6]*tVec)*pi/180;
ds = (297.85036306+[(1236*360+307.11148),-.0019142,5.3e-6]*tVec)*pi/180;
om = (125.04452222-[(5*360+134.13662608),.0020708,2.2e-6]*tVec)*pi/180;

dPsi = 0;%
dEps = 0;%

for i=1:106
    dPsi = dPsi + (cs(i,6)+cs(i,7)*t)*sin(cs(i,1)*mm+cs(i,2)*ms+cs(i,3)*um+cs(i,4)*ds+cs(i,5)*om);
    dEps = dEps + (cs(i,8)+cs(i,9)*t)*cos(cs(i,1)*mm+cs(i,2)*ms+cs(i,3)*um+cs(i,4)*ds+cs(i,5)*om);
end
dPsi = dPsi/10000*arcsec2rad;
dEps = dEps/10000*arcsec2rad;
eps_m = (84381.448 + [-46.8150,.00059,.001813]*tVec)*arcsec2rad;
eps_t = dEps + eps_m;
N = getFullRotationMatrix([eps_m,-dPsi,-eps_t],[1,3,1]);
N = orthodcm(N);

%% Sidereal
dT = (UT1 - J2000);
GMST = 4.894961212823058751375704430 + ...
       dT*(6.300388098984893552276513720 + ...
       dT*(5.075209994113591478053805523e-15 + ...
       dT*-9.253097568194335640067190688e-24));

alpha = GMST + (.00265*sin(om) +.000063*sin(2*om))*arcsec2rad + dPsi*cos(eps_m);

S = getRotationMatrix(alpha,3);
S = orthodcm(S);

%% W - Polar Motion
xp = .124126*arcsec2rad;
yp = .236687*arcsec2rad;
%W = eye(3) + [0,0,xp;0,0,-yp;-xp,yp,0];
sp = -.000047*T_TT*arcsec2rad;
W = getFullRotationMatrix([-sp,xp,yp],[3,2,1])';

%% CALCULATE
R_ECI_ECEF = P'*N'*S'*W';

















end