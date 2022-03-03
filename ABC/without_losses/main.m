clear all ;
clc;
global objfun D ub lb data B  Pd
objfun='abceld1'; %cost function to be optimized
 %/*The number of parameters of the problem to be optimized*/
 % the data matrix should have 5 columns of fuel cost coefficients and plant  limits.
% 1.a ($/MW^2) 2. b $/MW 3. c ($) 4.lower limit(MW) 5.Upper limit(MW)
%no of rows denote the no of plants(n)

data=[0.15247	38.53973	756.79886	10	125
0.10587	46.15916	451.32513	10	150
0.02803	40.3965	1049.9977	35	225
0.03546	38.30553	1243.5311	35	210
0.02111	36.32782	1658.569	130	325
0.01799	38.27041	1356.6592	125	315];
B=1e-4*[1.4 .17 .15 .19 .26 .22;.17 .60 .13 .16 .15 .20;.15 .13 .65 .17 .24 .19;.19 .16 .17 .71 .30 .25;.26 .15 .24 .30 .69 .32;.22 .20 .19 .25 .32 .85];
Pd=700;
lb=data(:,4)';%/*lower bounds of the parameters. */
ub=data(:,5)';%/*upper bound of the parameters.*/
D=length(data(:,1));

%/* Control Parameters of ABC algorithm*/
NP=20; %/* The number of colony size (employed bees+onlooker bees)*/
FoodNumber=NP/2; %/*The number of food sources equals the half of the colony size*/
limit=100; %/*A food source which could not be improved through "limit" trials is abandoned by its employed bee*/
maxCycle=1000; %/*The number of cycles for foraging {a stopping criteria}*/
%/* Problem specific variables*/
% objfun='der1'; %cost function to be optimized
% D=1; %/*The number of parameters of the problem to be optimized*/
% ub=ones(1,D)*30; %/*lower bounds of the parameters. */
% lb=ones(1,D)*(0);%/*upper bound of the parameters.*/

runtime=1;%/*Algorithm can be run many times in order to see its robustness*/


algorithm
R=GlobalParams;
[ F P1 ]=abceld1(R)