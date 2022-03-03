%%ABC WITH LOSSES
clear all;
clc;
tic;
global data B Pd
% This program solves the economic dispatch with Bmn coefficients by BAT
% Algorithm 
% The data matrix should have 5 columns of fuel cost coefficients and plant  limits.
% 1.a ($/MW^2) 2. b $/MW 3. c ($) 4.lower lomit(MW) 5.Upper limit(MW)
%no of rows denote the no of plants(n)
data=[0.007	7	240	100	500
0.0095	10	200	50	200
0.009	8.5	220	80	300
0.009	11	200	50	150
0.008	10.5	220	50	200
0.0075	12	120	50	120];


% Demand (MW)
Pd=700;

% setting the  algorithm parameters.
M = 1000;   
    pop = 30;   
    dim = length(data(:,1));   
    gamma = 0.9;
    alpha = 0.99;
    r0Max = 1;
    r0Min = 0;
    AMax = 2;
    AMin = 1;
    freqDMax = 1.5;
    freqDMin = 0;
     G = 10;   
    probMax = 0.9;
    probMin = 0.6;
    thetaMax = 1;
    thetaMin = 0.5;
    wMax = 0.9;
    wMin = 0.5;
    CMax = 0.9;
    CMin = 0.1;

 %   F is the total fuel cost
 %P1 is the allocation vector
% Pl is the transmission losss