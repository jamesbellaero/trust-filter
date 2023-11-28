function [ephemData,metaData] = getLunarEphem(t0JD,tfJD,dt,includeMetaData)
% getLunarEphem   : Compute and return a rotation matrix which transforms a
%                   3x1 position vector from the Lunar-centered, Lunar-fixed
%                   frame to the Lunar-centered rotating frame (x toward
%                   earth)
%
% INPUTS
%
% t   ------------- Time in JDUTC
%
% params.lunarEph - Coefficients or something
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

%https://ssd.jpl.nasa.gov/api/horizons.api?format=text&COMMAND='499'&OBJ_DATA='YES'&MAKE_EPHEM='YES'&EPHEM_TYPE='OBSERVER'&CENTER='500@399'&START_TIME='2006-01-01'&STOP_TIME='2006-01-20'&STEP_SIZE='1%20d'&QUANTITIES='1,9,20,23,24,29'
if(nargin == 3)
    includeMetaData = 0;
end

COMMAND = "301";
if(includeMetaData)
    OBJ_DATA = "YES";
else
    OBJ_DATA = "NO";
end
MAKE_EPHEM = "YES";
EPHEM_TYPE = "VECTORS";
CENTER = "500@399";
START_TIME = "JD"+num2str(t0JD);
STOP_TIME = "JD"+num2str(tfJD);
% Assumes that dt input is in seconds:
STEP_SIZE = num2str(max(dt/60,1),0)+"m";
VEC_TABLE = "2";
CSV_FORMAT = "YES";
VEC_DELTA_T = "YES";
REF_PLANE = "FRAME";

apiAddr = "https://ssd.jpl.nasa.gov/api/horizons.api";

% This fails because cmdName is out of scope inside the anonymous fn
%makeOpt = @(cmdName) "&" + cmdName + "='" + eval(cmdName) + "'";
makeOpt = @(cmdName,cmd) "&" + cmdName + "='" + cmd + "'";

reqUri = apiAddr + "?format=text" + makeOpt("COMMAND",COMMAND) + makeOpt( ...
    "OBJ_DATA",OBJ_DATA) + makeOpt("MAKE_EPHEM",MAKE_EPHEM) + makeOpt("CENTER",CENTER) + makeOpt( ...
    "START_TIME",START_TIME) + makeOpt("STOP_TIME",STOP_TIME) + makeOpt("STEP_SIZE",STEP_SIZE) + makeOpt( ...
    "VEC_TABLE",VEC_TABLE) + makeOpt("CSV_FORMAT",CSV_FORMAT) + makeOpt("VEC_DELTA_T",VEC_DELTA_T) + ...
    makeOpt("REF_PLANE",REF_PLANE)+makeOpt("EPHEM_TYPE",EPHEM_TYPE);

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

% Find where the data starts
% Read the data until it ends
% First split by new line?







end