function [r,v] = getLunarRVAtTime(tJD,params)
% getLunarRVAtTime: Compute and return a rotation matrix which transforms a
%                   3x1 position vector from the Lunar-centered, Lunar-fixed
%                   frame to the Lunar-centered rotating frame (x toward
%                   earth)
%
% INPUTS
%
% t   ------------- Time in JD
%
% params.lunarEph - n x 7 matrix where the first column is time (JD), the
%                   next 3 are lunar position (ICRF, geocentric), and the
%                   last 3 are lunar velocity (ICRF, geocentric). Length n
%                   is the number of time steps between t0 and tf
%
% OUTPUTS
%
% r --------------- 3 x 1 vector for lunar position in ECI (ICRF)
%
% v --------------- 3 x 1 vector for lunar velocity in ECI (ICRF)
% 
%+------------------------------------------------------------------------------+
% Source: 
%
%+==============================================================================+
% Written by James Bell, Infinity Labs, james.bell@i-labs.tech
% Last edited 2023
%  
% Copyright 2023 Infinity Labs, LLC. All rights reserved.
% 
% The use, dissemination or disclosure of data in this file is subject to
% limitation or restriction. See UTAUS-FA00002493 for details
%+==============================================================================+
eph = params.lunarEph;

[~,inds] = mink(abs(eph(:,1)-tJD));
state = zeros(6,1);

for i=1:6
    model = polyfit(eph(inds,1),eph(inds,2:7),3);
    state(i) = polyval(model,tJD);
end

r = state(1:3);
v = state(4:6);

end