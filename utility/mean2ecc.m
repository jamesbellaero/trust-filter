function [ E,iters ] = mean2ecc( M,e,eps )%M must be in radians.
%Solve's Kepler's equation with Newton-Raphson
if(nargin<3||eps<=0)
    eps=10^-10;
end
E=M;
dE=5*eps;
iters=0;
while(abs(dE)>eps)
    dE=(M-E+e*sin(E))/(-1+e*cos(E));
    E=E-dE;
    iters=iters+1;
    if(iters>100)
        pause
    end
end
%Ensure E is between 0 and 2*pi
while E>2*pi
    E=E-2*pi;
end
while E<0
    E=E+2*pi;
end
