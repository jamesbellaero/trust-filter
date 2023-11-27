function R_LCLF_LCI = getLclf2Lcr(tUTC, params)
% LCLF2LCR       : Compute and return a rotation matrix which transforms a
%                  3x1 position vector from the Lunar-centered, Lunar-fixed
%                  frame to the Lunar-centered rotating frame (x toward
%                  earth)
%
% INPUTS
%
% t   ------------ Time in UTC
%
% params.coeff --- Coefficients or something
%
% OUTPUTS
%
% R_LCLF_LCI ----- 3 x 3 matrix where x_LCLF = R_LCLF_LCI * x_LCI
% 
%+------------------------------------------------------------------------------+
% Source: 
%
%+==============================================================================+
% Written by James Bell, Infinity Labs, james.bell@i-labs.tech
% Last edited 2023
% <Insert License>

R_LCLF_LCI = eye(3);

end