function rB = getEarthMoonBarycenter(rL, params)
% getEarthMoonBarycenter: Compute location of barycenter in ECI
%
% INPUTS
%
% rL -------------- Position of the moon relative to the earth in ECI
%
% params.muE ------ Gravitational parameter for the earth
% 
% params.muL ------ Gravitational parameter for the moon (Luna)
%
% OUTPUTS
%
% rB -------------- Position of Earth-Moon barycenter in ECI
% 
%+------------------------------------------------------------------------------+
% Source: First principles and a pen (aka none, could be wrong)
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

% Get the distance to rB
dL = norm(rL);
dB = dL/(sqrt(params.muL/params.muE)+1);

% Get rB w.r.t. the ECI frame
rB = dB*rL/dL;

end