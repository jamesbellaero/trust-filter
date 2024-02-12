function [r,v] = getRVPoly(tJD,ephem)
% getLunarRVAtTime: Compute the cubics which interpolate along the ephemeris
%                   for a specific time frame. Returns a vector containing 
%                   the cubics for position and velocity, irrespective of
%                   frame.
%
% INPUTS
%
% t   ------------- Time in JD
%
% params.lunarEph - n x 7 matrix where the first column is time (JD), the
%                   next 3 are position, and the last 3 are velocity.
%                   Length n is the number of time steps between t0 and tf
%
% OUTPUTS
%
% r --------------- 3 x 1 vector for position in ECI
%
% v --------------- 3 x 1 vector for velocity in ECI
% 
%+------------------------------------------------------------------------------+
% Source: 
%
%+==============================================================================+
% Written by James Bell, Infinity Labs, james.bell@i-labs.tech
%  
% Copyright 2023 Infinity Labs, LLC. All rights reserved.
% 
% The use, dissemination or disclosure of data in this file is subject to
% limitation or restriction. See UTAUS-FA00002493 for details
%+==============================================================================+
ephem = params.lunarEph;

[~,inds] = mink(abs(ephem(:,1)-tJD));
models = zeros(6,1);

for i=1:6
    models(i) = polyfit(ephem(inds,1),ephem(inds,2:7),3);
   % model(i) = polyval(model,tJD);
end

r = models(1:3);
v = models(4:6);

end