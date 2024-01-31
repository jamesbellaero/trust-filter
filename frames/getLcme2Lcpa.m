function [R_LCME_LCPA] = getLcme2Lcpa()
%This code converts between lunar mean earth and lunar principle axis
%frames

arcsec2deg = 1/3600;
angles = [67.92,78.56,.30]*arcsec2deg*pi/180;
axes = [3,2,1];
R_LCME_LCPA = getFullRotationMatrix(angles,axes);