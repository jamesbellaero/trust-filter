function [R_LCLF_LCI, w_LCLF_LCI] = getLclf2Lci(rL, vL, params)
% LCLF2LCR        : Compute and return a rotation matrix which transforms a
%                   3x1 position vector from the earth-centered inertial frame
%                   to the earth-moon barycenter rotating frame
%
% INPUTS
%
% tJD ------------- Time in JD
%
% params. - n x 7 matrix where the first column is time (JD), the
%                   next 3 are lunar position (ICRF, geocentric), and the
%                   last 3 are lunar velocity (ICRF, geocentric). Length n
%                   is the number of time steps between t0 and tf
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
%  
% Copyright 2023 Infinity Labs, LLC. All rights reserved.
% 
% The use, dissemination or disclosure of data in this file is subject to
% limitation or restriction. See UTAUS-FA00002493 for details
%+==============================================================================+

R_LCLF_LCI = eye(3);

end