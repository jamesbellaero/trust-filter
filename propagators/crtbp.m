function [yDot] = crtbp(t,y,params)
% Give the derivatives for mass state given mass state and crtbp standard
% parameters (mass of the two major bodies, mean motion of the system).

% Reference: https://orbital-mechanics.space/the-n-body-problem/circular-restricted-three-body-problem.html

    % Need mean motion for dimensionalized crtbp solution
    M = params.mean_motion;
    m1 = params.mEarth;
    m2 = params.mMoon;
    rL = params.rMoon;
    muL = params.muL;
    muE = params.muE;

    yDot = zeros(size(y));

    pi1 = (m1/(m1+m2));% Mass of earth relative to system
    pi2 = (m2/(m1+m2));% Mass of moon relative to system

    
    r1Mag = norm([y(1)+pi2*rL,y(2),y(3)]);
    r2Mag = norm([y(1)-pi1*rL,y(2),y(3)]);
    coeffZ = -muE/r1Mag^3+-muL/r2Mag^3;
    coeffXY = coeffZ + M^2;
    
    A = zeros(6,6);
    % Velocity equals velocity
    A(1:3,4:6) = eye(3);
    % Due to r1Mag and r2Mag being in A, A is a function of
    % y, so this is a nonlinear system. Luckily, we can still integrate.
    A(4:6,1:3) = diag(coeffXY,coeffXY,coeffZ); 
    A(4:6,4:6) = [0,2*M,0;-2*M,0,0;0,0,0];

    yDot = A*y;
    yDot = yDot + [-mu1/r2Mag^3*pi2*rL+mu2/r1Mag^3*pi1*rL;0;0];
end








