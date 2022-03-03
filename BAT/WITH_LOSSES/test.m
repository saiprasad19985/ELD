clear;
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
% Loss coefficients it should be squarematrix of size nXn where n is the no
% of plants
B=1e-4*[0.14	0.17	0.15	0.19	0.26	0.22
0.17	0.6	0.13	0.16	0.15	0.2
0.15	0.13	0.65	0.17	0.24	0.19
0.19	0.16	0.17	0.71	0.3	0.25
0.26	0.15	0.24	0.3	0.69	0.32
0.22	0.2	0.19	0.25	0.32	0.85
];

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
  [ x, fMin ] = NBA( @eldnba, M, pop, dim, G, gamma, alpha, ...
    r0Max, r0Min, AMax, AMin, freqDMax, freqDMin, probMax, probMin, ...
    CMax, CMin, thetaMax, thetaMin, wMax, wMin )
 [ F P1 Pl]=eldnba(x)
 tic;
 %   F is the total fuel cost
 %P1 is the allocation vector
% Pl is the transmission losss