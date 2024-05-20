function [yDot] = crtbp(t,y,control,params)
% Give the derivatives for mass state given mass state and crtbp standard
% parameters (mass of the two major bodies, mean motion of the system).

% Reference: https://orbital-mechanics.space/the-n-body-problem/circular-restricted-three-body-problem.html
jd = params.jd0 + t/86400;
[~,inds] = mink(abs(params.ephemLuna(1,:)-jd),3);
rL = zeros(3,1);
rL(1) = interp1(params.ephemLuna(1,inds),params.ephemLuna(2,inds),jd,'pchip','extrap');
rL(2) = interp1(params.ephemLuna(1,inds),params.ephemLuna(3,inds),jd,'pchip','extrap');
rL(3) = interp1(params.ephemLuna(1,inds),params.ephemLuna(4,inds),jd,'pchip','extrap');
rL = norm(rL);%params.ephemLuna(2:4,ind));
    % Need mean motion for dimensionalized crtbp solution
    % w = cross(params.ephemLuna(2:4,ind),params.ephemLuna(5:7,ind))/rL^2;
    % T = 2*pi/norm(w);
    M = params.mean_motion;
    %rL = norm(params.rL);
    muL = params.muL;
    muE = params.muE;

    piE = (muE/(muE+muL));% Mass of earth relative to system
    piL = (muL/(muE+muL));% Mass of moon relative to system
    
    
    rEMag = norm([y(1)+piL*rL,y(2),y(3)]);
    rLMag = norm([y(1)-piE*rL,y(2),y(3)]);
    coeffZ = -muE/rEMag^3-muL/rLMag^3;
    coeffXY = coeffZ + M^2;
    
    A = zeros(6,6);
    % Velocity equals velocity
    A(1:3,4:6) = eye(3);
    % Due to r1Mag and r2Mag being in A, A is a function of
    % y, so this is a nonlinear system. Luckily, we can still integrate.
    A(4:6,1:3) = diag([coeffXY,coeffXY,coeffZ],0); 
    A(4:6,4:6) = [0,2*M,0;-2*M,0,0;0,0,0];

    yDot = A*y;
    yDot = yDot + [0;0;0;-muE/rEMag^3*piL*rL+muL/rLMag^3*piE*rL;0;0];
    yDot = yDot + [0;0;0;control];
end








