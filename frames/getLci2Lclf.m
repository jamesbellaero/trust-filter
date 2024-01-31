function [R_LCLF_LCI, w_LCLF_LCI] = getLci2Lclf(tJD, rL, vL, params)
% R_LCLF_LCI      : Compute the rotation and rotation rate of the lunar
%                   fixed frame relative to the ICRF frame. The rotation
%                   rate is, for the most part, just the rotation rate of
%                   the moon around the earth (AKA that of the CRTBP frame)
%
% INPUTS
%
% tJD ------------- Time in JD
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
% R_LCLF_LCI ----- 3 x 3 matrix where x_LCLF = R_LCLF_LCI * x_LCI
% 
%+------------------------------------------------------------------------------+
% Source: https://ntrs.nasa.gov/api/citations/20210021336/downloads/Lunar_inertia_Ahrens.pdf
%
% https://lunar.gsfc.nasa.gov/library/LunCoordWhitePaper-10-08.pdf
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


end