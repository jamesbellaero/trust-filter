function yDot = threeBody(t,y,control,params)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

jd = params.jd0 + t/86400;
ind = find(params.ephemLuna(1,:) >= jd,1);
if(isempty(ind))
    ind=size(params.ephemLuna,2);
end
rL = params.ephemLuna(2:4,ind);
% Determine barycenter
%rBary = getEarthMoonBarycenter(rL,params);
% Calculate gravitational force
yDotSum = twoBody(t,y,control,params.muE) + twoBody(t,[y(1:3)-rL;y(4:6)],zeros(3,1),params.muL);
% Setup matrix
% get ydot

yDot = [y(4:6);yDotSum(4:6)];

end
