function [R_CRTBP_ICRF, w_CRTBP_ICRF] = getIcrf2Crtbp(rL, vL, params)
% getIcrf2Crtbp   : Compute and return a rotation matrix and rotation rate
%                   vector which transform position and velocity from the
%                   ICRF intertial frame to the CRTBP rotating frame. This
%                   includes no offsets, just the rotational components
%
% INPUTS
%
% rL -------------- 3 x 1 position of the moon relative to the earth in ECI
%                   (ICRF)
%
% vL -------------- 3 x 1 velocity of the moon relative to the earth in ECI
%                   (ICRF)
%
% params.muE ------ Gravitational parameter for the earth
% 
% params.muL ------ Gravitational parameter for the moon (Luna)
%
% OUTPUTS
%
% R_CRTBP_ICRF ---- 3 x 3 matrix where x_ICRF = R_ICRF_CRTBP * x_CRTBP
%
% w_CRTBP_ICRF ---- 3 x 1 vector describing the rotation of the CRTBP frame
%                   relative to and defined in the ICRF frame
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

w = cross(rL,vL)/norm(rL)^2;
iX = rL/norm(rL);
iZ = w/norm(w);
iY = cross(iZ,iX)/norm(cross(iZ,iX));

R_CRTBP_ICRF = [iX,iY,iZ]';
w_CRTBP_ICRF = w;

end