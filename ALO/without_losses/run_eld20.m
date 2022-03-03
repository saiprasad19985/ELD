% This program solve Economic load Dispatch (ELD) problem without Transmission losses using Ant Lion
% Optimization
clear all;
clc;
format short;
global data  lb ub dim  Pd
%% Enter the No. of Search Agents
SearchAgents=40; % Number of search Agents (i.e. No. of Population)
%% Define Maximum number of iterations
Max_iteration=1000; 
%% input data ( generator coeffecients,upper and lower limits)
 data=[ 0.00068     18.19	1000	150	600
        0.00071     19.26 	970     50 	200
        0.00650 	19.80 	600     50 	200 
        0.00500 	19.10	700     50 	200
        0.00738 	18.10	420     50 	160
        0.00612     19.26	360     20 	100 
        0.00790 	17.14 	490     25 	125
        0.00813 	18.92	660     50 	150
        0.00522 	18.27	765     50	200 
        0.00573 	18.92 	770     30 	150
        0.00480 	16.69	800     100	300
        0.00310     16.76 	970     150 500
        0.00850 	17.36	900 	40	160
        0.00511     18.70	700     20 	130
        0.00398 	18.70	450 	25 	185
        0.07120 	14.26	370 	20	80
        0.00890 	19.14	480     30 	85
        0.00713 	18.92	680     30 	120
        0.00622 	18.47	700     40 	120
        0.00773 	19.79	850     30 	100];

Pd=2500;% Load demand

Function_name='eld';
[lb,ub,dim,fobj]=input(Function_name);
%% Use GWO Main function to Evaluate the Population

[Best_score,Best_pos,cg_curve]=ALO(SearchAgents,Max_iteration,lb,ub,dim,fobj);


semilogy(cg_curve,'m-.');
[ F P1 ]=eld(Best_pos);

display([' Fuel Cost  : ', num2str(F,10)]);
display(['optimum generation scheduling  : ', num2str(P1,5)]);

title('Objective space')
xlabel('Iteration');
ylabel('Fule Cost (Rs./h)');

legend('ELD without loss using ALO')