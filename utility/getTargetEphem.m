function [ephemData,metaData,response] = getTargetEphem(t0JD,tfJD,dt,target,center,frame,includeMetaData)
% getLunarEphem   : Compute and return a rotation matrix which transforms a
%                   3x1 position vector from the Lunar-centered, Lunar-fixed
%                   frame to the Lunar-centered rotating frame (x toward
%                   earth)
%
% INPUTS
%
% t0JD ------------ Time to start ephemeris in JD
%
% tfJD ------------ Time to end ephemeris in JD
%
% dt -------------- Time step in seconds. Minimum value is 60
%
% includeMetaData - Boolean value to include metadata in the
%                   request/response
%
% OUTPUTS
%
% ephemData ------- n x 7 matrix where the first column is time (JD), the
%                   next 3 are lunar position (ICRF, geocentric), and the
%                   last 3 are lunar velocity (ICRF, geocentric). Length n
%                   is the number of time steps between t0 and tf
%
% metaData -------- List of lines from the metadata sent by JPL Horizons
% 
%+------------------------------------------------------------------------------+
% Source: JPL Horizons - https://ssd.jpl.nasa.gov/horizons/manual.html
%
%+==============================================================================+
% Written by James Bell, Infinity Labs, james.bell@i-labs.tech
% Last edited Dec 2023
%  
% Copyright 2023 Infinity Labs, LLC. All rights reserved.
% 
% The use, dissemination or disclosure of data in this file is subject to
% limitation or restriction. See UTAUS-FA00002493 for details
%+==============================================================================+

if(nargin == 6)
    includeMetaData = 0;
end

COMMAND = target;
if(includeMetaData)
    OBJ_DATA = "YES";
else
    OBJ_DATA = "NO";
end
MAKE_EPHEM = "YES";
EPHEM_TYPE = "VECTORS";
CENTER = center;
START_TIME = "JD"+num2str(t0JD);
STOP_TIME = "JD"+num2str(tfJD);
% Assumes that dt input is in seconds:
STEP_SIZE = num2str(round(max(dt/60,1)),"%d")+"MINUTES";
VEC_TABLE = "2";
CSV_FORMAT = "YES";
VEC_DELTA_T = "YES";
REF_PLANE = "FRAME";
OUT_UNITS = "KM-S";
REF_SYSTEM='ICRF';

apiAddr = "https://ssd.jpl.nasa.gov/api/horizons.api";

% This fails because cmdName is out of scope inside the anonymous fn
%makeOpt = @(cmdName) "&" + cmdName + "='" + eval(cmdName) + "'";
makeOpt = @(cmdName,cmd) "&" + cmdName + "='" + cmd + "'";

reqUri = apiAddr + "?format=text" + makeOpt("COMMAND",COMMAND) + makeOpt( ...
    "OBJ_DATA",OBJ_DATA) + makeOpt("MAKE_EPHEM",MAKE_EPHEM) + makeOpt("CENTER",CENTER) + makeOpt( ...
    "START_TIME",START_TIME) + makeOpt("STOP_TIME",STOP_TIME) + makeOpt("STEP_SIZE",STEP_SIZE) + makeOpt( ...
    "VEC_TABLE",VEC_TABLE) + makeOpt("CSV_FORMAT",CSV_FORMAT) + makeOpt("VEC_DELTA_T",VEC_DELTA_T) + ...
    makeOpt(frame,REF_PLANE)+makeOpt("EPHEM_TYPE",EPHEM_TYPE)+makeOpt("OUT_UNITS",OUT_UNITS) + makeOpt(...
    "REF_SYSTEM",REF_SYSTEM);

reqMsg = matlab.net.http.RequestMessage;
response = send(reqMsg,reqUri);
dataBlock = response.Body.Data;

dataList = split(dataBlock,newline);
startInd = find(dataList=="$$SOE");
endInd = find(dataList == "$$EOE");

data = dataList(startInd+1:endInd-1);
ephemData = zeros(size(data,1),7);
for i = 1:size(data,1)
    line = data(i,:);
    lineList = split(line,",");
    ephemData(i,1) = str2double(lineList(1)) + str2double(lineList(3))/86400;
    for j = 4:9
        ephemData(i,j-2) = str2double(lineList(j));
    end
end

metaData = dataList(1:startInd);

end