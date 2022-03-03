% This program solve Economic load Dispatch (ELD) problem without Transmission losses using Ant Lion
% Optimization
clear all;
clc;
format long;
global data   lb ub dim  Pd
% Enter the No. of Search Agents
SearchAgents=30; % Number of search Agents (i.e. No. of Population)
%Define Maximum number of iterations
Max_iteration=500; 
%% input data ( generator coeffecients,upper and lower limits)
 data=[0.03546 38.30553 1243.5311 35 210
       0.02111 36.32782 1658.5696 130 325
       0.01799 38.27041 1356.6592 125 315];
   Pd=600;% Load demand
Function_name='eld';
[lb,ub,dim,fobj]=input(Function_name);

% Use ALO Main function to Evaluate the Population

[Best_score,Best_pos,cg_curve]=ALO(SearchAgents,Max_iteration,lb,ub,dim,fobj);

semilogy(cg_curve,'m-.');
[ F P1 ]=eld(Best_pos);
display(['Fuel Cost  : ', num2str(F,10)]);
display(['generation : ', num2str(P1,5)]);
title('Objective space')
xlabel('Iterations');
ylabel('Fuel Cost (Rs./hour)');
legend('ELD without losses using ALO')