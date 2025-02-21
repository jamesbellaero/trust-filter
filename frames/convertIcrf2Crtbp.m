function [rEmbr, vEmbr] = convertEci2Embr(rEmbr_icrf, vEmbr_icrf, rL, vL, params)
% getEci2Embr     : Convert position and velocity in the ECI frame to
%                   position and velocity in the rotating earth-moon frame
%                   centered at the Earth-Moon barycenter
%
% INPUTS
%
% rEci ------------ 3 x 1 position of object in ECI
%
% vEci ------------ 3 x 1 velocity of object in ECI
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
%
% OUTPUTS
%
% rEci ------------ 3 x 1 position of object in EMBR
%
% vEci ------------ 3 x 1 velocity of object in EMBR
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


[R_CRTBP_ICRF,w_CRTBP_ICRF] = getIcrf2Crtbp(rL,vL,params);

% Get location of object w.r.t. barycenter in the rotating frame
rEmbr = R_CRTBP_ICRF*(rEmbr_icrf);
% Get velocity of the object w.r.t. barycenter in the rotating frame
vEmbr = R_CRTBP_ICRF*(vEmbr_icrf - cross(w_CRTBP_ICRF,rEmbr_icrf));


















end